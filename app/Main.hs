import Prelude hiding (drop, (++))

(++) [] y = y
(++) (x:xs) y = (:) x ((++) xs y)

-- x�̗v�f�̐�����y�̗v�f��擪���痎�Ƃ�������
drop [] y = y
drop x y = drop (tail x) (tail y)

-- x��y�̐擪�ƈ�v���邩
match [] _ = True
match _ [] = False
match x y = head x == head y && match (tail x) (tail y)

-- a����b��x�̒���S�Ēu��
replace _ _ [] = []
replace [] _ x = x
replace a b x
  | match a x = (++) b (replace a b (drop a x))
  | otherwise = (:) (head x) (replace a b (tail x))

-- x��a�ŕ���
split _ [] = [[]]
split a x
  | head x == a = [] : split a (tail x)
  | otherwise = (head x : head (split a (tail x))) : tail (split a (tail x))

-- �^����ꂽ�v���O�������g�[�N����ɕ���
tokenize s = filter (/= "") (split ' ' s)

-- �^����ꂽ�g�[�N������֐���`�̃��X�g�ɕ���
parse x = map (filter (/= [])) (map (split ",") (filter (/= []) (split "." x)))

-- ���Ɏg����l
data Value = Literal String | Global String | Func [String] [Value] | Param String | Expr [Value] deriving Show

-- �l�ɑΉ������g�[�N����l�ɕϊ�����
parseToken s
  | head s == '\"' = Literal s
  | 'A' <= head s && head s <= 'Z' = Global s
  | 'a' <= head s && head s <= 'z' = Param s

-- c�̋��x(����)��a��b�̐擪�ɂ����t����
conbine a (b:bs) [] = a:b:bs
conbine a ((Expr b):bs) (':':c) = (Expr (conbine a b c)) : bs
conbine a (b:bs) (':':c) = (Expr (conbine a [b] c)) : bs

-- �g�[�N���񂩂玮�̖؂��\�z����
parseExpr [] = []
parseExpr [x] = [parseToken x]
parseExpr (x:y:xs)
  | head y == ':' = conbine (parseToken x) (parseExpr xs) y
  | otherwise = (parseToken x) : (parseExpr (y:xs))

-- �����֐����Ō������A�֐���`��T��
searchDefine env func
  | head (head (head env)) == func = head env
  | otherwise = searchDefine (tail env) func

-- �֐���`����֐����A�������X�g�A�������߂�B
funcName define = head (head define)
funcParams define = tail (head define)
funcExpr define = parseExpr (head (tail define))

-- �������X�g���������Ō������A��������Ԃ�
searchParam ((param, arg):xs) target
  | param == target = arg
  | otherwise = searchParam xs target

-- ����]������B
exec env ((Global f):expr) args =
  exec env (funcExpr (searchDefine env f)) ((zip (funcParams (searchDefine env f)) expr) : args)
exec env ((Expr f):expr) args =
  exec env f args
exec env ((Literal f):expr) args = (Literal f)