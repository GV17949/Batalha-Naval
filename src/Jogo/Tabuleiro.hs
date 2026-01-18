module Jogo.Tabuleiro (Coordenada, tamanhoTabuleiro, Tabuleiro, criarTabuleiro, obter, alterarEspaco) where

type Coordenada = (Int, Int)

tamanhoTabuleiro :: Int
tamanhoTabuleiro = 10

type Tabuleiro = [[Int]]

criarTabuleiro :: Tabuleiro
criarTabuleiro = replicate tamanhoTabuleiro (replicate tamanhoTabuleiro 0)

obter :: Coordenada -> Tabuleiro -> Maybe Int
obter (x,y) board =    
    if (x >= 0 && y >= 0) && (x < length board && y < length board)
        then Just ((board !! x) !! y)
        else Nothing

alterarEspaco :: Coordenada -> Int -> Tabuleiro -> Tabuleiro
alterarEspaco (x,y) novoEspaco board = 
    let linha = board !! x
        novaLinha = atualizaIndice y novoEspaco linha 
    in  atualizaIndice x novaLinha board

atualizaIndice :: Int -> x -> [x] -> [x]
atualizaIndice 0 novaInformacao (_:xs) = novaInformacao : xs
atualizaIndice n novaInformacao (x:xs) = x : atualizaIndice (n-1) novaInformacao xs
atualizaIndice _ _   []      = [] 