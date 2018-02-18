import Prelude hiding (drop, (++))

(++) [] y = y
(++) (x:xs) y = (:) x ((++) xs y)

-- xの要素の数だけyの要素を先頭から落としたもの
drop [] y = y
drop x y = drop (tail x) (tail y)

-- xがyの先頭と一致するか
match [] _ = True
match _ [] = False
match x y = head x == head y && match (tail x) (tail y)

-- aからbへxの中を全て置換
replace _ _ [] = []
replace [] _ x = x
replace a b x
  | match a x = (++) b (replace a b (drop a x))
  | otherwise = (:) (head x) (replace a b (tail x))

-- xをaで分割
split _ [] = [[]]
split a x
  | head x == a = [] : split a (tail x)
  | otherwise = (head x : head (split a (tail x))) : tail (split a (tail x))

-- 与えられたプログラムをトークン列に分割
tokenize s = filter (/= "") (split ' ' s)

-- 与えられたトークン列を関数定義のリストに分割
parse x = map (filter (/= [])) (map (split ",") (filter (/= []) (split "." x)))

-- 式に使われる値
data Value = Literal String | Global String | Func [String] [Value] | Param String | Expr [Value] deriving Show

-- 値に対応したトークンを値に変換する
parseToken s
  | head s == '\"' = Literal s
  | 'A' <= head s && head s <= 'Z' = Global s
  | 'a' <= head s && head s <= 'z' = Param s

-- cの強度(長さ)でaをbの先頭にくっ付ける
conbine a (b:bs) [] = a:b:bs
conbine a ((Expr b):bs) (':':c) = (Expr (conbine a b c)) : bs
conbine a (b:bs) (':':c) = (Expr (conbine a [b] c)) : bs

-- トークン列から式の木を構築する
parseExpr [] = []
parseExpr [x] = [parseToken x]
parseExpr (x:y:xs)
  | head y == ':' = conbine (parseToken x) (parseExpr xs) y
  | otherwise = (parseToken x) : (parseExpr (y:xs))

-- 環境を関数名で検索し、関数定義を探す
searchDefine env func
  | head (head (head env)) == func = head env
  | otherwise = searchDefine (tail env) func

-- 関数定義から関数名、引数リスト、式を求める。
funcName define = head (head define)
funcParams define = tail (head define)
funcExpr define = parseExpr (head (tail define))

-- 引数リストを仮引数で検索し、実引数を返す
searchParam ((param, arg):xs) target
  | param == target = arg
  | otherwise = searchParam xs target

-- 式を評価する。
exec env ((Global f):expr) args =
  exec env (funcExpr (searchDefine env f)) ((zip (funcParams (searchDefine env f)) expr) : args)
exec env ((Expr f):expr) args =
  exec env f args
exec env ((Literal f):expr) args = (Literal f)