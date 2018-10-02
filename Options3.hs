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
module Options3 where

import Tipos (Berco,Navio)
      
listaNavios::[Navio]
listaNavios = [(1,5,16,50), (2,6,20,90), (3,3,12,34), (4,4,22,12), (5,11,20,160)]
listaBercos::[Berco]
listaBercos = [(1,4,20), (2,3,18)]
infoPorto = [[1, 3, 4, 12, 6], [2, 3, 1, 2, 5]]
naviosAlocadosBerco1::(Berco,[Navio])
naviosAlocadosBerco2::(Berco,[Navio])
naviosAlocadosBerco1 = ((1,4,20), [(4,4,22,12), (5,11,20,160)])
naviosAlocadosBerco2 = ((2,3,18), [(3,3,12,34), (1,5,16,50)])
naviosAlocadosBerco = [naviosAlocadosBerco1, naviosAlocadosBerco2]

