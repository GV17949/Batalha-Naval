module Jogo.Navio (Navio(..), naviosDefault, OrientacaoNavio(..)) where

data Navio = Navio {
    tipo :: String,
    tamanho :: Int
 }

naviosDefault :: [Navio]
naviosDefault = 
    [ Navio "portaAvioes" 5,
      Navio "couraçado" 4,
      Navio "cruzador1" 3,
      Navio "cruzador2" 3,
      Navio "submarino1" 2,
      Navio "submarino2" 2
    ]

data OrientacaoNavio = H | V deriving (Eq, Show)

