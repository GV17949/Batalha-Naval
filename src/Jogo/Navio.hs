module Jogo.Navio (Navio(..), naviosDefault, Orientacao(..)) where
import Data.IntMap (delete)

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

naviosDisponiveis :: [Navio] -> Int -> String
naviosDisponiveis [] _ = ""
naviosDisponiveis (n:ns) i = tipo n ++ " (" ++ show i ++ ") " ++ naviosDisponiveis ns (i+1) 

