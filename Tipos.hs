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

--MÓDULO QUE DEFINE TIPOS DE DADOS A SEREM APLICADOS OU RETORNADOS--

module Tipos where

type Berco = (Int,Integer,Integer)
type Navio = (Int,Integer,Integer,Integer)
type TempoAtendimento = Integer
type InfoPorto = [[TempoAtendimento]]
type AlocadosBerco = (Berco,[Navio])

navioId (id,horIni,horFnl,carga) = id
navioHorIni (id,horIni,horFnl,carga) = horIni
navioHorFnl (id,horIni,horFnl,carga) = horFnl
navioCarga (id,horIni,horFnl,carga) = carga

bercoId (id,horAbt,horFech) = id
bercoHorAbt (id,horAbt,horFech) = horAbt 
bercoHorFech (id,horAbt,horFech) = horFech
