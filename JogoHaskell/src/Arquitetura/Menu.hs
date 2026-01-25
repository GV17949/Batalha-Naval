module Arquitetura.Menu where
import GHC.Exception (getCallStack)

main :: IO()
main = do
    menuPrincipal

--A cara por assim dizer do menu do jogo no momento, com o passar do desenvolvimento a gante tenta deixar ela um pouco mais agradável
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
        "1" -> startGame
        "2" -> tutorial
        "3" -> putStrLn "Adeus!"
        _ -> putStrLn "OPÇÃO INVÁLIDA"

--Por enquanto só esta aqui como placeholder, vou escrever algo mais apropriado depois
tutorial :: IO()
tutorial = do
    putStrLn "O jogo começa com o jogador sendo encarregado de escalar os seus navios em alguma posição válida dentro do seu tabuleiro de 81 espaços e o seu objetivo é simples, destruir todos os navios do seu oponente antes que ele destrua os seus"
    menuPrincipal

startGame :: IO()
startGame = do
    putStrLn "Selecione a ordem que deseja colocar seus barcos no tabuleiro, eles estão em ordem decrescente de tamanho: " 
    setNavios
    --Depois de o jogador colocar os seus navios a CPU coloca os navios dela e o combate por fim se inicia
   
setNavios :: IO()
setNavios =
    putStrLn "Selecione a ordem que deseja colocar seus barcos no tabuleiro, eles estão em ordem decrescente de tamanho: "
    if (length naviosDefault != 0)
        then do putStr (naviosDisponiveis 1 naviosDefault)
                
                putStr ">"
        
                option <- readLn

                putStr "Em qual coordenada deseja posicionar o navio? (EX: 2 3)"

                coordenadaDesejada <- lerCoordenada

                putStr "Deseja posicionar o navio na vertical (V) ou na horizontal (H)?"
                
                orient <- lerOrientacao

                --Chamar desenharNavio com as informações para propriamente "desenhar" o navio no Tabuleiro
                --Repetir esse processo atraves de chamadas recursivas até naviosDefault estar vazio


--A função de posicionar propriamente os navios no tabuleiro com base nos dados obtidos em setNavios
--desenharNavio :: Tabuleiro

--Precisa checar para ver se esta funcionando corretamente
lerCoordenada :: IO Coordenada
lerCoordenada = do
    putStr ">"
   -- hFlush stdout
    coord <- getLine
    case words coord of
      [sx, sy] -> case (reads sx, reads sy) of
        ([(x,"")], [(y,"")]) ->
          if coordenadaValida (x,y)
          then return (x, y)
          else do
            putStrLn "Posição inválida. Tente novamente."
            lerCoordenada
        _ -> do
          putStrLn "Entrada inválida. Use dois números separados por espaço."
          lerCoordenada
      _ -> do
        putStrLn "Formato inválido. Tente novamente."
        lerCoordenada


--Precisa checar para ver se esse negócio funciona, isso tá mais para uma ideia do que uma implementação por si só
lerOrientacao :: IO Navio Coordenada Orientacao
lerOrientacao nav coord = do
    putStr ">"
    -- hFlush stdout
    orient <- getLine
    case orient of
        "H" -> verificarOrientValida nav coord H
        "V" -> verificarOrientValida nav coord V
        _ -> do
            putStrLn "Orientação invãlida. Tente novamente"
            lerOrientacao















    



