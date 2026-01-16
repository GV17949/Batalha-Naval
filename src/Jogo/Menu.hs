
{-# LANGUAGE ScopedTypeVariables #-}

module Jogo.Menu where

main :: IO()
main = do
    menuPrincipal

--A cara por assim dizer do menu do jogo no momento, com o passar do desenvolvimento a gante tenta deixar ela um pouco mais agradável
--claro a função jogar ainda não foi implementadaa mas ao ser é só substituir o "COMEÇAR JOGO" com a chamada da função
menuPrincipal :: IO()
menuPrincipal = do
    putStrLn "\nBEM VINDO!"
    putStrLn "\nEscolha uma opção:\n"
    putStrLn "(1) Jogar"
    putStrLn "(2) Tutorial"
    putStrLn "(3) Sair"
    putStr "> "

    option <- getLine

    case option of
        "1" -> putStrLn "COMEÇAR O JOGO"
        "2" -> tutorial
        "3" -> putStrLn "Adeus!"
        _ -> putStrLn "OPÇÃO INVÁLIDA"

--Por enquanto só esta aqui como placeholder, vou escrever algo mais apropriado depois
tutorial :: IO()
tutorial = do
    putStrLn "O jogo começa com o jogador sendo encarregado de escalar os seus navios em alguma posição válida dentro do seu tabuleiro de 81 espaços e o seu objetivo é simples, destruir todos os navios do seu oponente antes que ele destrua os seus"
    menuPrincipal

