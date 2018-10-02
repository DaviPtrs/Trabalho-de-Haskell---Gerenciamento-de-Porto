{--
tc-CC-davipetris-jairomarcos.hs                                                                               
  _____ ____      _    ____    _    _     _   _  ___    ____  ____   ___   ____       _ 
 |_   _|  _ \    / \  | __ )  / \  | |   | | | |/ _ \  |  _ \|  _ \ / _ \ / ___|     / |
   | | | |_) |  / _ \ |  _ \ / _ \ | |   | |_| | | | | | |_) | |_) | | | | |  _ _____| |
   | | |  _ <  / ___ \| |_) / ___ \| |___|  _  | |_| | |  __/|  _ <| |_| | |_| |_____| |
   |_| |_| \_\/_/   \_\____/_/   \_\_____|_| |_|\___/  |_|   |_| \_\\___/ \____|     |_|

                  DAVI DE SOUZA PETRIS e JAIRO MARCOS OLIVEIRA MOUTINHO
                                        06/2018
--}

--MÓDULO QUE DEFINE FUNÇÕES GENÉRICAS ÚTEIS--
module UtilFuncs where

import Tipos


----------------------Ordena lista de elementos simples---------------
sortXS [] = []
sortXS [p] = [p]
sortXS (x:xs) = insord x (sortXS xs)

insord p [] = [p]
insord p (x:xs) = if p < x then 
                        p:(x:xs)
                    else 
                        x:(insord p (xs))

-----------------------Ordena listas de tuplas----------------------
sortTupXS [] elem = []
sortTupXS [p] elem = [p]
sortTupXS (x:xs) (elem) = insordTup  (x:(sortTupXS xs (elem))) (elem) 

menorTup t1 t2 item = (item t1) < (item t2) 

insordTup [p] (elem) = [p]
insordTup (p:x:xs) (elem) = if (menorTup p x (elem)) then 
                            p:x:xs
                        else 
                            x:(insordTup (p:xs) (elem))

------------------- pega o maior elemento de uma lista------------------
maior [x] = x
maior (x:xs) = max x (maior xs)

-----lista de tuplas
maiorTupXS _ [x] = x
maiorTupXS item (x:xs) = maiorTup (item) x (maiorTupXS item xs)  

maiorTup item t1 t2 = if (item t1) > (item t2) then t1 else t2


---------------------------quicksort definido---------------------------
quicksort [] = []
quicksort [x] = [x]
quicksort (x:xs) = (quicksort menor) ++ [x] ++ (quicksort maior)
                where
                    menor  = filter (< x) xs
                    maior = filter (>= x) xs
---------------------------Verifica se um X pertence a [a,b]-------------
intervaloFechado a b x = (x>=a) && (x<=b)

----------------Retorna um elemento de uma lista de tuplas ordenadas-------
getElemTupXS xs elem i | i>(length xsord) || i<=0 = error "Não existe este índice"
                       | otherwise = xsord!!(i-1)
                        where
                            xsord = sortTupXS xs elem
------------------Retorna a posição do item numa lista---------------------
getPosXS item xs = if elem (item) xs then
                      [i | i <- [0..(length xs-1)], (xs!!i)==(item)] 
                   else
                       error "Este elemento não está na lista"
---------------Retorna a primeira posição do item numa lista---------------
getFstPosXS item xs = head (getPosXS item xs)
---------------------------------------------------------------------------