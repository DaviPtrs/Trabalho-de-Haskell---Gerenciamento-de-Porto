{--
tc-CC-davipetris-jairomarcos.hs                                                                               
  _____ ____      _    ____    _    _     _   _  ___    ____  ____   ___   ____       _ 
 |_   _|  _ \    / \  | __ )  / \  | |   | | | |/ _ \  |  _ \|  _ \ / _ \ / ___|     / |
   | | | |_) |  / _ \ |  _ \ / _ \ | |   | |_| | | | | | |_) | |_) | | | | |  _ _____| |
   | | |  _ <  / ___ \| |_) / ___ \| |___|  _  | |_| | |  __/|  _ <| |_| | |_| |_____| |
   |_| |_| \_\/_/   \_\____/_/   \_\_____|_| |_|\___/  |_|   |_| \_\\___/ \____|     |_|

                  DAVI DE SOUZA PETRIS e JAIRO MARCOS OLIVEIRA MOUTINHO
                                        06/2018


            Para mudar o conjunto de exemplos, troque o modulo (Options) para:
                    Options0(padrão), Options1, Options2 ou Options3
--}

import Options0
import Tipos
import UtilFuncs(getFstPosXS,sortTupXS,insordTup,getElemTupXS,intervaloFechado,maiorTupXS)

--Funções que retornam informações dada o lista
getNavio :: [Navio] -> Int -> Navio
getNavio listanavios = getElemTupXS listanavios navioId --Retorna o navio dado o id
getBerco :: [Berco] -> Int -> Berco
getBerco listabercos = getElemTupXS listabercos bercoId --Retorna o berço dado o id
--Retorna a fila de navios alocados dado o berço
--Retorna o tempo de atendimento dado o navio e o berço
getTempoAtend navio berco infoporto = (infoporto!!(idberco-1))!!(idnavio-1)
                                        where
                                            idberco = bercoId berco
                                            idnavio = navioId navio

--1) Atendido
atendido :: Navio -> Berco -> InfoPorto -> Bool
atendido navio berco infoporto = 
        dentroExpediente && compativelBerco && limiteNavio
    where
        limiteNavio = ((navioHorIni navio) + tempoAtendNavio)
                      <= (navioHorFnl navio)
        --Verifica se o navio chegou depois que o berço abriu
        dentroExpediente =  (expedienteBerco (navioHorIni navio))
            --Verifica se o tempo de atendimento 
            --não excede o fim do expediente do berço
            && (expedienteBerco ((navioHorIni navio) + tempoAtendNavio))
        -----------------------------------------------------  
        expedienteBerco = intervaloFechado (bercoHorAbt berco) 
                                           (bercoHorFech berco)
        --Verifica se existe possibilidade 
        --de atracação independente do horário
        compativelBerco = tempoAtendNavio /= 0 
        -----------------------------------------------------
        tempoAtendNavio = getTempoAtend navio berco infoporto



--2) Fila dos navios
--Organiza a lista de tuplas em ordem crescente usando 
--a hora de chegada de cada navio para realizar a comparação.
filaNavios :: [Navio] -> [Navio]
filaNavios listanavios = sortTupXS listanavios navioHorIni 



--3) Calculo de tempo de ociosidade do berço
--Subtrai, do tempo total de funcionamento do berço, 
--o tempo total de serviço dos navios
tempoOcioso :: Berco -> AlocadosBerco -> InfoPorto -> Integer
tempoOcioso berco alocadosberco infoporto = tempoTotal - tempoServico
    where
        tempoTotal = (bercoHorFech berco) - (bercoHorAbt berco)
        -------------------------------------------------------
        tempoServico = sum [getTempoAtend navio berco infoporto 
                            | navio <-naviosAlocados]
        -------------------------------------------------------
        naviosAlocados = snd alocadosberco

--4)Berço com maior tempo ocioso
--Pega o primeiro elemento (ID) da primeira tupla 
--da lista ordenada na função abaixo
bercoOcioso :: [Berco] -> [AlocadosBerco] -> InfoPorto -> Int
bercoOcioso listabercos alocadosbercoXS infoporto = 
    fst (maiorTupXS snd bercosOc)
    where
        bercosOc = listaTemposOciosos listabercos alocadosbercoXS infoporto 1

--coloca numa lista tuplas com o id do berço e seu tempo total ocioso
listaTemposOciosos :: 
     [Berco] -> [AlocadosBerco] -> InfoPorto -> Int -> [(Int, Integer)] 
listaTemposOciosos listabercos alocadosbercoXS infoporto idberco =
        if idberco > length listabercos then
            []
        else
            (idberco,(tempoOcioso berco alocadosberco infoporto))
            :(listaTemposOciosos 
                            listabercos alocadosbercoXS infoporto (idberco+1))
    where
        berco = getBerco listabercos idberco
        alocadosberco = alocadosbercoXS!!(idberco-1)



--5) lista de navios alocados que podem ser atendidos
naviosCandidatosBerco :: [Berco] -> [Navio] -> InfoPorto -> [(Int,[Navio])]
naviosCandidatosBerco listabercos listanavios infoporto = 
    naviosCandidatosBercoCalc listabercos listanavios infoporto 1 


--Adiciona um navio na lista caso ele satisfaça
--a função atendido para determinado berço
naviosCandidatosBercoCalc :: 
    [Berco] -> [Navio] -> InfoPorto -> Int -> [(Int,[Navio])]
naviosCandidatosBercoCalc listabercos listanavios infoporto idberco = 
        -- Caso o ID do berco seja maior que 
        --a quantidade de elementos na listabercos, a recursão para.                    
        if idberco > length listabercos then
            []           
        else 
            --Recursão para sempre adicionar 1 ao ID do berço 
            --e listar todos os navios que podem ser atendidos nele
            candidatosXS 
            ++ naviosCandidatosBercoCalc 
                listabercos listanavios infoporto (idberco +1)      
    where
        candidatosXS = 
            [(idberco,
            [navio | navio <- listanavios, atendido navio berco infoporto]
            )] 
        berco = listabercos!!(idberco-1)
                                                       


--6) Caso possível, insere, numa lista de navios alocados 
--   num dado berço, o navio dado como entrada.
insereNavioBerco :: 
    Navio -> AlocadosBerco -> InfoPorto -> (Berco,Integer,[Navio])
insereNavioBerco navio alocadosberco infoporto
        | null fila = navioSozinho
        --Verifica se o navio pode ser atendido
        | (atendido navio berco infoporto) && existeJanela = 
        (berco,totalCarga,filaBerco)
        | otherwise = error "O navio não pôde ser inserido na fila deste berço"
    where
        navioSozinho = (berco,(navioCarga navio),[navio])
        --------------------------------------------------------------
        berco = fst alocadosberco
        --------------------------------------------------------------
        --Calcula o total de carga carregada nos navios da nova fila
        totalCarga = sum (map (navioCarga) filaBerco)
        --------------------------------------------------------------
        existeJanela = elem True janelas
        --Retorna uma lista com valores Bool para cada janela de tempo
        janelas =  [chkJanelas navio berco alocadosberco infoporto i 
                    | i<-[0..(length fila)]]
        --------------------------------------------------------------
        fila = snd alocadosberco --retorna a fila de navios do berço
        --Retorna a fila com o novo navio inserido
        filaBerco = insordTup (navio:fila) navioHorIni


-- Dada uma fila de navios num berço checa se existem 
-- janelas de tempo para atender um outro navio
chkJanelas :: Navio -> Berco -> AlocadosBerco -> InfoPorto -> Int -> Bool
chkJanelas navio berco alocadosberco infoporto i 
        --Checa se existe janela entre a abertura do berço 
        --e o atendimento do primeiro navio
        | i == 0 = primeiraJanela > navioAtend 
        --Checa se existe janela entre o atendimento dos navios
        | i < ((length fila)) = janelaEntreNavios > navioAtend
        --Checa se existe janela entre o atendimento 
        --do último da fila e o fechamento do berço
        | i == ((length fila)) = ultimaJanela > navioAtend
    where
        primeiraJanela = (navioHorIni (fila!!i)) - aberturaBerco
        janelaEntreNavios = (navioHorIni (fila!!i)) - navioAntTempo
        ultimaJanela = fechamentoBerco - navioAntTempo
        ---------------------------------------------------------------
        --Calcula o tempo de atendimento do navio anterior ao comparado
        navioAntTempo = (navioHorIni (fila!!(i-1))) + 
                        getTempoAtend (fila!!(i-1)) berco infoporto
        --Dá a hora de abertura do berço
        aberturaBerco = bercoHorAbt (fst alocadosberco) 
        -- Dá a hora de fechamento do berço
        fechamentoBerco = bercoHorFech (fst alocadosberco)
        --Dá o tempo de carregamento do navio a ser atendido
        navioAtend = getTempoAtend navio berco infoporto 
        ---------------------------------------------------------------
        fila = snd alocadosberco --Dá a fila dos navios dado o berço



--7) Tempo de espera de um navio no berço
esperaNavio :: Navio -> AlocadosBerco -> InfoPorto -> Integer
esperaNavio navio alocadosberco infoporto= 
        if chkNavioAlocado then 
            if tempoEspera >= 0 then
                0
            else
                abs (tempoEspera)
        else
            msgErro
    where
                    --verifica se o navio foi o primeiro a ser atendido
        tempoEspera = 
            if posNavio == 0 then 
                0
            else 
                --tempo de chegada do navio dado
                (navioHorIni (naviosAlocados!!posNavio)) 
                --Tempo de atendimento do navio anterior
                - ((getTempoAtend navioAnt berco infoporto)
                --tempo de chegada do navio anterior
                + (navioHorIni navioAnt))
        -------------------------------------------------------------
        --verifica se o navio foi alocado no berço
        chkNavioAlocado = elem navio naviosAlocados
        berco = fst alocadosberco
        --tupla do navio anterior ao analisado
        navioAnt = naviosAlocados!!(posNavio-1)
        --posição do navio na lista do berço
        posNavio = getFstPosXS navio naviosAlocados 
        naviosAlocados = snd alocadosberco
        -------------------------------------------------------------
        msgErro = error ("O navio " ++ show(idnavio) 
                         ++ " não foi alocado no berco "
                         ++ show(idberco) ++ ".")
                        where
                            idnavio = navioId navio
                            idberco = bercoId (fst alocadosberco)



--8) Constroi nova alocação de navios nos berços

constroiAlocacaoBerco :: 
    Berco -> [Navio] -> InfoPorto -> (Berco, Integer, [(Int,Integer,Integer)])              
constroiAlocacaoBerco berco listaord infoporto = 
        (berco, totalCarga, alocados)
    where
        --Retorna uma lista de navios que podem
        --ser alocados (resposta da questão 5)
        candidatosXS = naviosCandidatosBerco [berco] listaord infoporto
        --Dá a soma das cargas dos lista alocados
        totalCarga = 
            sum (map (navioCarga) (map ((getNavio listaord)) idsAlocados))
        idsAlocados = (map (\(a,_,_) -> a) alocados)
            --sum (map (\(_,_,carga) -> carga) alocados)
        ---------------------------------------------------------------
        alocados = fazAlocacao berco bercoAbt (navios) infoporto
        bercoAbt = bercoHorAbt berco   
        navios = (snd (head candidatosXS))                       


fazAlocacao :: 
    Berco -> Integer -> [Navio] -> InfoPorto -> [(Int, Integer, Integer)]
fazAlocacao berco proxHor proxNavios infoporto =
        trataNavios proxNavios
    where
        trataNavios [] = []
        trataNavios (navio:xs) = 
                if podeAtender then -- caso possa ser atendido
                -- o navio será inserido numa lista e a função roda de novo para
                -- o próximo navio
                 (idnavio,horAtend,horFinal) : (fazAlocacao 
                                                berco horFinal xs infoporto)
                -- caso não possa, o navio é descartado e a função continua
                -- procurando por navios que satisfaçam as condições
                else
                    fazAlocacao berco proxHor xs infoporto
            where
                idnavio = navioId navio
                -- Verifica se o navio pode ser atendido, com base no horário
                -- em seu horário de chegada + seu tempo de atendimento
                -- e a hora em que precisa sair do porto.
                podeAtender = horFinal <= bercoFech &&
                              horFinal <= (navioHorFnl navio)
                --Dá a hora de saída do navio do berço
                horFinal = horAtend + tempoAtendNavio
                --Dá a hora em que o navio será de fato atendido
                horAtend = max proxHor (navioHorIni navio)
                tempoAtendNavio = getTempoAtend navio berco infoporto
        ------------------------------------------------------------------------
        bercoAbt = bercoHorAbt berco
        bercoFech = bercoHorFech berco

--------------------------------------------------------------------------------