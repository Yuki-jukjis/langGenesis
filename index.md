# 2018年2月人工言語コンペ課題  
[Yuki-jukjis](https://twitter.com/Yuki_jukjis)  

## 目次  

* [今回のお題](#今回のお題)
* [作ろうとしたもの](#作ろうとしたもの)  
* [神話（部分）](#神話（部分）)  
* [課題についての考察](#課題についての考察)  
* [文法](#文法)  
* [作りたかった創世神話の仕様](#作りたかった創世神話の仕様)  
* [途中までの実装](#途中までの実装)  

## 今回のお題

人工言語で創世神話を記述する。既存のものでも良いし、架空文化の創世神話でも良い。

## 作ろうとしたもの  

この課題で架空言語を期待していた者には申し訳ないが、今回私が<s>作った</s>作ろうとした言語はプログラミング言語だ。  
関数指向のプログラミング言語を作り、Eval関数（その言語自身を実行できるエミュレータ）とQuine関数（そのプログラム自身を出力するプログラム）をその言語で実装すれば、そのプログラムが創世神話になるのではないかと考えた。  

## 神話（部分）  

以下の節では文字列（リスト）の置換関数を定義し、Quine関数（すなわち神話自身）を定義している。  

> kunt dat li karta dat nee. jorn dat det li go kunt sa dat det ba druntu puski sa dat jorn sa nenki se dat sa det. farl dat det li go kunt sa dat det ba farl nenki sa dat nenki sa det. mapt dat det li go kunt sa dat yaa ba go kunt sa det nee ba go karta sa puski se dat sa puski se det mapt sa nenki se dat sa nenki se det nee. bast dat det dit li go kunt sa dit nee ba go kunt sa dat dit ba go mapt sa dat sa dit jorn sa det sa bast se dat se det se farl so dat so dit ba druntu puski sa dit bast sa dat sa det sa nenki se dit. quin li bast prog ".." prog. prog li "kunt dat li karta dat nee. jorn dat det li go kunt sa dat det ba druntu puski sa dat jorn sa nenki se dat sa det. farl dat det li go kunt sa dat det ba farl nenki sa dat nenki sa det. mapt dat det li go kunt sa dat yaa ba go kunt sa det nee ba go karta sa puski se dat sa puski se det mapt sa nenki se dat sa nenki se det nee. bast dat det dit li go kunt sa dit nee ba go kunt sa dat dit ba go mapt sa dat sa dit jorn sa det sa bast se dat se det se farl so dat so dit ba druntu puski sa dit bast sa dat sa det sa nenki se dit. quin li bast prog "".."" prog. prog li "".."".".

## 課題についての考察  

### 創世神話について  

まず課題の根幹となっている創世神話について考えた。  
創世神話とは世界の成り立ちについて説明した神話を指すであろう。  
矛盾のない創世神話を目指すのであれば、世界にあるものすべてについて、存在を説明できるべきだ。  

では、「世界にあるもの全て」とは何だろうか。  
ものが多いほど創世神話の量が膨大になるので、少ない方から設定していく。言語コンペなので、世界で使われる言語は必要だ。また、課題になっている創世神話も不可欠だ。ここでは、最低限この二つを定義した創世神話を作ることを目標とする。この二つを創世神話に組み込むだけで十分に難易度の高い課題となったので、例えば人間などは存在しない（少なくとも創世神話では定義しない）。また、今回は架空世界のあり方について特に設定をしていないが、強いて言えば、数学の世界のように定義することによって生まれる世界と言えよう。  

### 創世神話の定義とは  

創世神話がそれ自身を定義するにはどうしたらよいか。例えば、「神は仰せられた。創世神話とは『～（創世神話本文）～』なる神話だと。すると創世神話があった」（文体は無駄にそれっぽくしている）とする方法が考えられるが、この文章を創世神話の中に入れると、長さが定まらない。  

これを回避するには、自らを含む文章を引用するような(機能語レベルの)指示語を作る方法と、引用する文章（文字列）を計算、構築できるようにする方法が考えられる。前者の指示語は使い道が限られるため、言語として実装するのは冗長だと思ったので、今回は後者の方法を選んだ。  

### 言語の定義とは  

何をもって言語を説明したとするか、決めるのは難しい。文法書を作ることも考えたが、前述のように文字列が計算可能になると決まったので、その言語のエミュレーターを作ることにした。  

### 課題の再設定  

こうして、「創世神話を自作言語で記述する」という課題を、「プログラミング言語を作り、言語の定義としてEval関数、神話の定義としてQuine関数を実装する」と（再）解釈し、課題に挑んだ。  


## 文法  

以下に冒頭のQuine関数を再掲する。これに基づいて文法を解説する。  

> kunt dat li karta dat nee. jorn dat det li go kunt sa dat det ba druntu puski sa dat jorn sa nenki se dat sa det. farl dat det li go kunt sa dat det ba farl nenki sa dat nenki sa det. mapt dat det li go kunt sa dat yaa ba go kunt sa det nee ba go karta sa puski se dat sa puski se det mapt sa nenki se dat sa nenki se det nee. bast dat det dit li go kunt sa dit nee ba go kunt sa dat dit ba go mapt sa dat sa dit jorn sa det sa bast se dat se det se farl so dat so dit ba druntu puski sa dit bast sa dat sa det sa nenki se dit. quin li bast prog ".." prog. prog li "kunt dat li karta dat nee. jorn dat det li go kunt sa dat det ba druntu puski sa dat jorn sa nenki se dat sa det. farl dat det li go kunt sa dat det ba farl nenki sa dat nenki sa det. mapt dat det li go kunt sa dat yaa ba go kunt sa det nee ba go karta sa puski se dat sa puski se det mapt sa nenki se dat sa nenki se det nee. bast dat det dit li go kunt sa dit nee ba go kunt sa dat dit ba go mapt sa dat sa dit jorn sa det sa bast se dat se det se farl so dat so dit ba druntu puski sa dit bast sa dat sa det sa nenki se dit. quin li bast prog "".."" prog. prog li "".."".".

これは架空言語風の見た目になるよう、単語を置き換えているが、以下の文法解説では扱いやすいよう、英単語やASCII文字に直したものを使う。  
以下に示すのが、例文で使用した単語と、読みやすく置き換えるための対応である。  
組み込み関数はスライムさんのS語根から、ユーザー定義関数はロジバンのgismuから借用した。形の区別がつきやすいよう、後者は最後の母音を削って子音で終わるようにしている。  

機能語  

|例文での表記 |解説での表記 |  
|---	|---	|  
|.	|;	|  
|li	|=	|  
|ba	|$	|  
|sa	|:	|  
|se	|::	|  
|so	|:::	|  

値・組み込み関数  

|例文での表記 |解説での表記 |  
|---	|---	|  
|yaa	|True	|  
|nee	|Nil	|  
|karta	|equal	|  
|puski	|head	|  
|nenki	|tail	|  
|druntu	|push	|  
|go	|if	|  

ユーザー定義関数  

|例文での表記 |解説での表記 |  
|---	|---	|  
|kunt	|empty	|  
|jorn	|join	|  
|farl	|drop	|  
|mapt	|match	|  
|bast	|replace	|  
|quin	|quine	|  
|prog   |program	|

引数

|例文での表記 |解説での表記 |  
|---	|---	|  
|dat	| a / x	|  
|det	| b / y	|  
|dit	| x	|  

以上の単語の定義に従って例文を置換すると以下のようになる。  
読みやすいよう、文（関数定義）ごとに改行を入れている。  

```  
empty x = equal y Nil ;  
join x y = if empty : x y $ push head : x join : tail :: x : y ;  
drop x y = if empty : x y $ drop tail : x tail : y ;  
match x y = if empty : x True $ if empty : y Nil $ if equal : head :: x : head :: y match : tail :: x : tail :: y Nil ;  
replace a b x = if empty : x Nil $ if empty : a x $ if match : a : x join : b : replace :: a :: b :: drop ::: a ::: x $ push head : x replace : a : b : tail :: x ;  
quine = replace program ".." program ;  

program = "kunt dat li karta dat nee. jorn dat det li go kunt sa dat det ba druntu puski sa dat jorn sa nenki se dat sa det. farl dat det li go kunt sa dat det ba farl nenki sa dat nenki sa det. mapt dat det li go kunt sa dat yaa ba go kunt sa det nee ba go karta sa puski se dat sa puski se det mapt sa nenki se dat sa nenki se det nee. bast dat det dit li go kunt sa dit nee ba go kunt sa dat dit ba go mapt sa dat sa dit jorn sa det sa bast se dat se det se farl so dat so dit ba druntu puski sa dit bast sa dat sa det sa nenki se dit. quin li bast prog "".."" prog. prog li ""..""." ;
```  

以下ではこの記法を基準に解説をする。  

関数名 仮引数名 仮引数名 ... 仮引数名 = 式 ;  

と書くことで、関数を定義できる。これを複数並べてプログラムを作る。  
式は関数、仮引数、文字列リテラル（以下これらをトークンと呼ぶ）を並べて作る。  
トークンを何も挟まずに並べると、左結合の関数適用となる。  
- a b  
  - (a b)  
- a b c d  
  - (((a b) c) d)  

*:* や *$* を間に挟むことで、結合の優先度を変えることができる。  
*:* をトークン間に挟むと、両隣のトークンの結合を強めることができる。*:* の数が増えるほど結合の優先度は高くなる。*:* や *::* 等は左結合である  
- a b:c  
  - (a (b c))  
- a b : c : d  
  - (a ((b c) d))  
- a b : c :: d  
  - (a (b (c d)))  

*$* をトークンの間に挟むと、両隣のトークンの結合を弱めることができる。また、*$* は **右結合** である。（これは専らifのための糖衣構文である）  

- a $ b c  
  - (a (b c))  
- a $ b c $ d e   
  - (a ((b c) (d e)))  

以上の規則に従い、例文を()を使って書き直すと以下のようになる。（単に左結合を示しているだけの括弧は省略した）  

```  
empty x = equal x Nil ;  
join x y =   
    if (empty x) y (push (head x) (join (tail x) y)) ;  
drop x y =   
    if (empty x) y (drop (tail x) (tail y)) ;  
match x y =  
    if (empty x) True  
  ( if (empty y) Nil  
  ( if (equal (head x) (head y)) (match (tail x) (tail y))  
       Nil )) ;
quine = replace program ".." program ;  

program = "kunt dat li karta dat nee. jorn dat det li go kunt sa dat det ba druntu puski sa dat jorn sa nenki se dat sa det. farl dat det li go kunt sa dat det ba farl nenki sa dat nenki sa det. mapt dat det li go kunt sa dat yaa ba go kunt sa det nee ba go karta sa puski se dat sa puski se det mapt sa nenki se dat sa nenki se det nee. bast dat det dit li go kunt sa dit nee ba go kunt sa dat dit ba go mapt sa dat sa dit jorn sa det sa bast se dat se det se farl so dat so dit ba druntu puski sa dit bast sa dat sa det sa nenki se dit. quin li bast prog "".."" prog. prog li ""..""." ;  
```  

複数の引数をとる関数に値を渡すと、その関数の一つ目の引数にその値を渡し、引数に（元の関数の）二つ目以降の引数をとる、新たな関数が返される（カリー化）。  

以下のような組み込み関数や値がある。（純Lispを参考にした）。  
*True* は真を表す。  
*Nil* は空リストや偽を表す。  
*equal* は、第一引数と第二引数が同じ値だった場合は *True* を返し、異なる値だった場合は *Nil* を返す。  
*head* は第一引数（リスト）の先頭要素を返す  
*tail* は第二引数（リスト）の先頭以外のリストを返す  
*push* は第一引数（リスト）の先頭に第二引数を追加したリストを返す  
*if* は第一引数が *True* だった場合には第二引数を、 *Nil* だった場合には第三引数を返す。  

文字列はダブルクオーテーション（"）で挟むことで表現される。文字列は文字のリストであり、headやpushなどの関数で操作をすることができる。  
文字列中のダブルクオーテーションは、ダブルクオーテーションを二つ並べることで表現する（エスケープ文字）。それ以外の（改行などの）エスケープ文字はない。  
文字リテラルはないので、文字列リテラルとheadを使って代用する。  

リストは型の概念がなく、文字やリストを同じリストの中に入れることができる。  

冒頭の例文をHaskell風の記法に直すと以下のようになる。  

```  
-- xが空リストか否か  
empty x = equal x Nil  
-- リストxとリストyを結合する  
join x y  
  | empty x = y  
  | otherwise = push (head x) (join (tail x) y)  
-- xの要素の数だけyの要素を先頭から落としたもの  
drop x y =  
  | empty x = y  
  | otherwise = drop (tail x) (tail y)  
-- xがyの先頭と一致するか  
match x y  
  | empty x = True  
  | empty y = Nil  
  | equal (head x) (head y) = match (tail x) (tail y)  
  | otherwise = Nil  
-- aからbへxの中を全て置換  
replace a b x  
  | empty x = Nil  
  | empty a = x  
  | match a x = join b (replace a b (drop a x))  
  | otherwise = push (head x) (replace a b (tail x))  
quine = replace program ".." program

program = "kunt dat li karta dat nee. jorn dat det li go kunt sa dat det ba druntu puski sa dat jorn sa nenki se dat sa det. farl dat det li go kunt sa dat det ba farl nenki sa dat nenki sa det. mapt dat det li go kunt sa dat yaa ba go kunt sa det nee ba go karta sa puski se dat sa puski se det mapt sa nenki se dat sa nenki se det nee. bast dat det dit li go kunt sa dit nee ba go kunt sa dat dit ba go mapt sa dat sa dit jorn sa det sa bast se dat se det se farl so dat so dit ba druntu puski sa dit bast sa dat sa det sa nenki se dit. quin li bast prog \"..\" prog. prog li \"..\"." ;
```  

こうして、program（文中ではprog）の定義中に表れる..をprogram自体で置換することによって、quine関数（文中ではquin）は、元のプログラムと同じ文字列を出力することができる。


## 作りたかった創世神話の仕様  

言語(Eval)関数は第一引数に環境文字列（プログラム全体を示す文字列）を、第二引数に式を取り、以上の文法に従って式を評価し、式に対応する値を返す。  
例えば第一引数に冒頭の例文全体を与え、第二引数に"midj"を渡すと、"axyzef"を返す。  
式を評価する際、基本は遅延評価を行うが、一部の組み込み関数（if関数の第一引数など）は渡された時点で計算をする。  
また、メモ化（引数と結果の対応を保存し、二回目以降の計算を省略すること）は行わない。  

神話(Quine)関数は引数を取らず、プログラム自身を示す文字列を返す。  
Quine関数は冒頭のように、プログラム自体に対応する部分を置換することで実装できる。  


## 途中まで書いた実装  

まずHaskellを使いEval関数を実装し、後に私の言語に翻訳する計画だった（予めHaskellでEvalを作っておけば、それを使ったデバッグもできるので）。  
しかし、Haskellには型の制約があること、私がHaskellでのアルゴリズムに慣れていなかったことによりで、Eval関数の実装が終わらなかった。  
また、翻訳の作業量が想定していたより多くなりそうだった（haskellの糖衣構文を外し、prerudeの関数を再定義する必要があった）こともあり、創世神話全文の制作を諦め、文法を公開するのみとなった。EvalとQuineを両方実装できないと課題達成にはならないので、無念の限りである。  

以下にHaskellで作りかけたEvalの実装を書いておく（このまま実行はできないはず）。  
作れなかった部分は文字列リテラルを考慮した字句解析、リスト、$を取り入れた結合、α変換（仮引数名が衝突しないように置換する処理）の実装など。  
また、Exprは使わなくても同じものが実装できる気がする。  

```  
data Thunk = Thunk Thunk | Apply Thunk Thunk |  
    Pre ([(String, Thunk)] -> Thunk -> Thunk) | Lamda String Thunk | Variable String | Expr [Thunk]  
instance Show Thunk where  
  show (Thunk thunk) = "(Thunk " ++ (show thunk) ++ ")"  
  show (Apply func arg) = "(Apply " ++ (show func) ++ (show arg) ++ ")"  
  show (Value value) = "(Value " ++ show value ++ ")"  
  show (Pre _) = "Pre"  
  show (Lamda paramName value) = "(Lamda " ++ paramName ++ " -> " ++ show value ++ ")"  
  show (Expr expr) = show expr  
  show (Variable name) = "(Variable " ++ name ++ ")"  

-- インタプリタ  
interpreter env expr =   
  eval (parseEnv (lexer env)) (Expr (parseExpr (lexer expr)))  

-- 環境と式を受け、式を評価する。  
eval :: [(String, Thunk)] -> Thunk -> Thunk  
eval env (Thunk value)  
  = eval env value  
eval env (Apply (Pre func) arg)  
  = func env arg  
eval env (Apply (Lamda paramName value) arg)  
  = eval env (replaceParam paramName arg value)  
eval env (Apply func arg)  
  = eval env (Apply (eval env func) arg)  
eval env (Value value)  
  = Value value  
eval env (Pre func)  
  = Pre func  
eval env (Lamda param value)  
  = Lamda param value  
eval env (Variable global)  
  = eval env (search env global)  
eval env (Expr expr)  
  = eval env (makeApply expr)  

-- 環境を検索して値を返す  
search :: [(String, Thunk)] -> String -> Thunk  
search ((key, thunk): env) target | key == target = thunk | otherwise = search env target  

-- ラムダの中を再帰的に検索して、仮引数を使っている部分を実引数に置き換える  
replaceParam :: String -> Thunk -> Thunk -> Thunk  
replaceParam paramName arg (Thunk thunk)  
  = Thunk (replaceParam paramName arg thunk)  
replaceParam paramName arg (Apply func value)  
  = Apply (replaceParam paramName arg func) (replaceParam paramName arg value)  
replaceParam paramName arg (Value value)  
  = Value value  
replaceParam paramName arg (Pre func)  
  = Pre func  
replaceParam paramName arg (Lamda paramName2 thunk)  
  = Lamda paramName2 (replaceParam paramName arg thunk)  
replaceParam paramName arg (Variable name)  
  | name == paramName = arg | otherwise = Variable name  
replaceParam paramName arg (Expr expr)  
  = replaceParam paramName arg (makeApply expr)  

-- 関数適用をカリー化  
makeApply thunks = foldl makeApplySingle (head thunks) (tail thunks)  

makeApplySingle x (Expr []) = x  
makeApplySingle x (Expr expr) = Apply x (makeApply expr)  
makeApplySingle x y = Apply x y  

-- 関数定義をカリー化  
makeLamda :: [String] -> Thunk -> Thunk  
makeLamda paramNames thunk = foldr Lamda thunk paramNames  


-- 与えられたトークン列を関数定義のリストに分割  
parse x = map (filter (/= [])) (map (split ",") (filter (/= []) (split "." x)))  

-- 環境(関数定義のリスト)をパース  
parseEnv x = map parseDefine (parse x)  

-- 関数定義(関数名、引数リスト、式)を(関数名, ラムダ)に変換  
parseDefine x = (head (head x), makeLamda (tail (head x)) (Expr (parseExpr (head (tail x)))))  

-- 与えられたプログラムをトークン列に分割  
lexer s = filter (/= "") (split ' ' s)  

-- xをaで分割  
split _ [] = [[]]  
split a x  
  | head x == a = [] : split a (tail x)  
  | otherwise = (head x : head (split a (tail x))) : tail (split a (tail x))  

-- トークン列から式の木を構築する  
parseExpr [] = []  
parseExpr [x] = [parseToken x]  
parseExpr (x:y:xs)  
  | head y == ':' = conbine (parseToken x) (parseExpr xs) y  
  | otherwise = (parseToken x) : (parseExpr (y:xs))  

-- cの強度(長さ)でaをbの先頭にくっ付ける  
conbine a (b:bs) [] = a:b:bs  
conbine a ((Expr b):bs) (':':c) = (Expr (conbine a b c)) : bs  
conbine a (b:bs) (':':c) = (Expr (conbine a [b] c)) : bs  


-- トークンをThunkに変換する  
parseToken "equal" = preEqual  
parseToken "head" = preHead  
parseToken "tail" = preTail  
parseToken "push" = prePush  
parseToken "if" = preIf  
parseToken s  
  | 'A' <= head s && head s <= 'Z' = Variable s  
  | 'a' <= head s && head s <= 'z' = Variable s  
  | otherwise = Value (read s)  

preEqual = undefined  
preHead = undefined  
preTail = undefined  
prePush = undefined  
preIf = undefined  
```