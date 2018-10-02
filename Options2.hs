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

--MÓDULO QUE DEFINE OS EXEMPLOS--
module Options2 where

import Tipos (Berco,Navio)
    
listaNavios::[Navio]
listaNavios = [(1,7,15,10), (2,10,15,30), (3,9,17,30), (4,10,17,50), (5,16,22,20), (6,17,24,40)]
listaBercos::[Berco]
listaBercos = [(1,9,18)]
infoPorto = [[1, 3, 6, 4, 2, 3]]
naviosAlocadosBerco1::(Berco,[Navio])
naviosAlocadosBerco1 = ((1,9,18), [(2,10,15,30),(4,10,17,50)])
naviosAlocadosBerco = [naviosAlocadosBerco1]
