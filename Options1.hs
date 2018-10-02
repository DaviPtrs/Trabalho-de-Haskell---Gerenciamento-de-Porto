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
module Options1 where

import Tipos (Berco,Navio)
    
listaNavios::[Navio]
listaNavios = [(1,5,6,15), (2,3,14,27), (3,2,15,120), (4,4,23,70), (5,4,23,80),(6,18,20,50)]
listaBercos::[Berco]
listaBercos = [(1,4,20), (2,3,23), (3,1,10)]
infoPorto = [[1, 6, 4, 3, 2, 0], [2, 0, 1, 0, 5, 2], [3, 2, 8, 1, 0, 3]]
naviosAlocadosBerco1::(Berco,[Navio])
naviosAlocadosBerco2::(Berco,[Navio])
naviosAlocadosBerco3::(Berco,[Navio])
naviosAlocadosBerco1 = ((1,4,20), [(4,4,23,50), (5,4,23,80)])
naviosAlocadosBerco2 = ((2,3,23), [])
naviosAlocadosBerco3 = ((3,1,10), [(2,3,14,30)])
naviosAlocadosBerco = [naviosAlocadosBerco1, naviosAlocadosBerco2, naviosAlocadosBerco3]