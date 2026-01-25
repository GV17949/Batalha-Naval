-- Navio - N
-- Água  - .
-- Hit   - X
-- Miss  - O

-- import System.Random.Stateful (uniformRM, globalStdGen)

data Navio = Navio {
    tipo :: String,
    tamanho :: Int
 } deriving (Eq, Show)

type Coordenada = (Int, Int)

data Orientacao = H | V deriving (Eq, Show)

type Tabuleiro = [[Int]]

criarTabuleiro :: Tabuleiro
criarTabuleiro = replicate boardSize (replicate boardSize 0)

boardSize :: Int
boardSize = 10

naviosDefault :: [Navio]
naviosDefault =
    [ Navio "Porta Aviões" 5,
      Navio "Encouraçado" 4,
      Navio "Cruzador" 3,
      Navio "Submarino" 2
    ]

coordValida :: Coordenada -> Bool
coordValida (x,y) = x >= 0 && x < boardSize && y >= 0 && y < boardSize

showElemento :: Int -> Char
showElemento n
  | n == 0 = '.'
  | n == 1 = 'N'
  | n == 2 = 'X'
  | n == 3 = 'O'

showTabuleiro :: Tabuleiro -> String
showTabuleiro tabuleiro = unlines [ [ showElemento (tabuleiro !! y !! x) | x <- [0..boardSize - 1] ] | y <- [0..boardSize - 1] ]

checkOrientValida :: Navio -> Coordenada -> Orientacao -> Bool
checkOrientValida navio (x,y) orient =
  let tam = tamanho navio
  in case orient of
       H -> all coordValida ([(x + i, y) | i <- [0..tam - 1]])
       V -> all coordValida ([(x, y + i) | i <- [0..tam - 1]])

main :: IO()
main = do menuPrincipal

menuPrincipal :: IO()
menuPrincipal = do
    putStrLn "Bem-vindo ao Batalha Naval!"
    putStrLn "Escolha uma opção:"
    putStrLn "(1) Jogar"
    putStrLn "(2) Índice de navios e tamanhos"
    putStrLn "(3) Sair"
    putStrLn "> "
    opcao <- getLine
    case opcao of
        "1" -> iniciarJogo
        "2" -> do
            putStrLn "Porta Aviões - 5"
            putStrLn "Encouraçado - 4"
            putStrLn "Cruzador - 3"
            putStrLn "Submarino - 2"
            menuPrincipal
        "3" -> putStrLn "Obrigado por jogar!"
        _   -> do
            putStrLn "Opção inválida. Tente novamente."
            menuPrincipal

atualizaIndice :: Tabuleiro -> Coordenada -> Int -> Tabuleiro
atualizaIndice tabuleiro (x,y) val =
  take y tabuleiro ++
  [take x (tabuleiro !! y) ++ [val] ++ drop (x + 1) (tabuleiro !! y)] ++
  drop (y+1) tabuleiro

putNavio :: Tabuleiro -> Navio -> IO Tabuleiro
putNavio tabuleiro navio = do
    putStrLn ("Posicione o " ++ tipo navio ++ " (tamanho " ++ show (tamanho navio) ++ ").")
    coord <- getCoordenada
    putStrLn "Orientação (H para horizontal, V para vertical): "
    orientStr <- getLine
    let orient = if orientStr == "H" then H else V
    if checkOrientValida navio coord orient && checkOverlap tabuleiro navio coord orient
      then do
        putStrLn "Navio posicionado com sucesso!"
        return (posicionarNavio tabuleiro navio coord orient)
      else do
        putStrLn "Posição inválida para o navio."
        putNavio tabuleiro navio

putNavioManual :: Tabuleiro -> Navio -> Coordenada -> Orientacao -> IO Tabuleiro
putNavioManual tabuleiro navio coord orient =
    if checkOrientValida navio coord orient && checkOverlap tabuleiro navio coord orient
      then do
        return (posicionarNavio tabuleiro navio coord orient)
      else do
        return tabuleiro

posicionarNavio :: Tabuleiro -> Navio -> Coordenada -> Orientacao -> Tabuleiro
posicionarNavio tabuleiro navio (x,y) orient =
  let tam = tamanho navio
      coords = case orient of
                 H -> [(x + i, y) | i <- [0..tam - 1]]
                 V -> [(x, y + i) | i <- [0..tam - 1]]
  in addSegmentoNavio tabuleiro coords

addSegmentoNavio :: Tabuleiro -> [Coordenada] -> Tabuleiro
addSegmentoNavio tabuleiro [] = tabuleiro
addSegmentoNavio tabuleiro (coord:coords) =
  addSegmentoNavio (atualizaIndice tabuleiro coord 1) coords

getCoordenada :: IO Coordenada
getCoordenada = do
    putStrLn "Coordenada x: "
    xStr <- getLine
    putStrLn "Coordenada y: "
    yStr <- getLine
    let x = read xStr :: Int
    let y = read yStr :: Int
    if not (coordValida (x,y))
      then do
        putStrLn "Coordenadas inválidas. Tente novamente."
        getCoordenada
      else
      return (x,y)

checkOverlap :: Tabuleiro -> Navio -> Coordenada -> Orientacao -> Bool
checkOverlap tabuleiro navio (x,y) orient =
  let tam = tamanho navio
      coords = case orient of
                 H -> [(x + i, y) | i <- [0..tam - 1]]
                 V -> [(x, y + i) | i <- [0..tam - 1]]
  in all (\(cx,cy) -> (tabuleiro !! cx !! cy) == 0) coords

iniciarJogo :: IO()
iniciarJogo = do
    let tabuleiroUsr = criarTabuleiro
    let tabuleiroCpu = criarTabuleiro
    putStrLn (showTabuleiro tabuleiroUsr)
    tabuleiroUsr <- putNavio tabuleiroUsr (head naviosDefault)
    putStrLn (showTabuleiro tabuleiroUsr)
    tabuleiroUsr <- putNavio tabuleiroUsr (naviosDefault !! 1)
    putStrLn (showTabuleiro tabuleiroUsr)
    tabuleiroUsr <- putNavio tabuleiroUsr (naviosDefault !! 2)
    putStrLn (showTabuleiro tabuleiroUsr)
    tabuleiroUsr <- putNavio tabuleiroUsr (naviosDefault !! 3)
    -- Configuração automática do tabuleiro da CPU (fixo por simplicidade)
    tabuleiroCpu <- putNavioManual tabuleiroCpu (head naviosDefault) (0,0) H
    tabuleiroCpu <- putNavioManual tabuleiroCpu (naviosDefault !! 1) (2,2) V
    tabuleiroCpu <- putNavioManual tabuleiroCpu (naviosDefault !! 2) (5,5) H
    tabuleiroCpu <- putNavioManual tabuleiroCpu (naviosDefault !! 3) (7,7) V
    putStrLn "Lógica do jogo ainda em desenvolvimento."