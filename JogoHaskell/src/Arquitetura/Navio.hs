module Arquitetura.Navio (Navio(..), naviosDefault, Orientacao(..)) where
import Data.IntMap (delete)
import Arquitetura.Tabuleiro

data Navio = Navio {
    tipo :: String,
    tamanho :: Int
 } deriving (Eq, Show)

naviosDefault :: [Navio]
naviosDefault = 
    [ Navio "Porta Aviões" 5,
      Navio "Couraçado" 4,
      Navio "Cruzador 1" 3,
      Navio "Cruzador 2" 3,
      Navio "Submarino 1" 2,
      Navio "Submarino 2" 2
    ]

data Orientacao = H | V deriving (Eq, Show)

--Precisa dar uma olhada para ver se uma função map ou algo do tipo vai ser necessário para garantir a checagem de todas as posições envolvidas
verificarOrientValida :: Navio -> Coordenada -> Orientacao -> Bool
verificarOrientValida navio (x,y) orient = 
  let tam = tamanho navio
  in case orient of
       H -> coordenadaValida ([(x + i, y) | i <- [0..tam - 1]])
       V -> coordenadaValida ([(x, y + i) | i <- [0..tam - 1]])

naviosDisponiveis :: [Navio] -> Int -> String
naviosDisponiveis [] _ = ""
naviosDisponiveis (n:ns) i = tipo n ++ " [" ++ "Tamanho:" ++ tamanho n ++ "] " ++ " (" ++ show i ++ ") " ++ naviosDisponiveis ns (i+1) 

