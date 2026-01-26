main :: IO()
main = do menuPrincipal

menuPrincipal :: IO()
menuPrincipal = do
    putStrLn "Bem-vindo ao Batalha Naval!"
    putStrLn "\nEscolha uma opção:"
    putStrLn "(1) Jogar"
    putStrLn "(2) Tutorial"
    putStrLn "(3) Sair"
    putStr "> "
    opcao <- getLine
    case opcao of
        "1" -> iniciarJogo
        "2" -> tutorial
        "3" -> putStrLn "\nObrigado por jogar!"
        _   -> do
            putStrLn "Opção inválida. Tente novamente."
            menuPrincipal


tutorial :: IO()
tutorial = do
    putStrLn "\nBem vindo ao Batalha Naval! Nesse jogo o seu principal objetivo é afundar todas as embarcações do seu oponente."
    putStrLn "Ao começar o jogo você tera em sua visão dois tabuleiros 10x10 definido em intervalos de 0 a 9 da seguinte forma:"
    putStrLn "   0  1  2  3  4  5  6  7  8  9              GLOSSÁRIO: "
    putStrLn "0  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~              ~ -> ÁGUA " 
    putStrLn "1  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~              N -> NAVIO "
    putStrLn "2  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~              X -> NAVIO ACERTADO "
    putStrLn "3  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~              O -> ESPAÇO ACERTADO VAZIO "
    putStrLn "4  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"
    putStrLn "5  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"
    putStrLn "6  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"
    putStrLn "7  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"
    putStrLn "8  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"
    putStrLn "9  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"
    putStrLn "O tabuleiro a esquerda é o seu no qual você poderá colocar os seus navios e o tabuleiro a direita é o do seu oponente,"
    putStrLn "para alocar as suas embarcações basta fornecer a linha (x) e a coluna (y) que você deseja colocar a primeira parte dela seguida"
    putStrLn "da orientação (Vertical ou Horizontal) que você deseja que ela tome, caso você decida que quer o navio na horizontal a coordenada"
    putStrLn "fornecida anteriormente será a primeira parte do navio e as demais partes serão posicionadas a direita dessa coordenada no tabuleiro,"
    putStrLn "caso você decida posicionar o seu navio na vertical a coordenada obtida ainda será a primeira parte posicionada porém as demais partes"
    putStrLn "serão colocadas abaixo da coordenada inicial."
    putStrLn "Após a etapa de alocação dos navios o jogador terá acesso a opção de atirar no tabuleiro do seu oponente em determinada coordenada"
    putStrLn "em seguida ele receberá um feedback se o tiro foi ou não certeiro (ou seja se ele acertou alguma embarcação) e ele passará a vez para"
    putStrLn "oponente e a prioridade de ataque ficará alternando desse modo até que uma das partes afunde todos os navios presentes no tabuleiro inimigo\n"
    menuPrincipal




iniciarJogo :: IO()
iniciarJogo = do
    let tabuleiroUsr = criarTabuleiro
    let tabuleiroCpu = criarTabuleiro
    putStrLn (showTabuleiro tabuleiroUsr tabuleiroCpu)

    tabuleiroUsr <- putNavio tabuleiroUsr (head naviosDefault)
    putStrLn (showTabuleiro tabuleiroUsr tabuleiroCpu)

    tabuleiroUsr <- putNavio tabuleiroUsr (naviosDefault !! 1)
    putStrLn (showTabuleiro tabuleiroUsr tabuleiroCpu)

    tabuleiroUsr <- putNavio tabuleiroUsr (naviosDefault !! 2)
    putStrLn (showTabuleiro tabuleiroUsr tabuleiroCpu)

    tabuleiroUsr <- putNavio tabuleiroUsr (naviosDefault !! 3)
    putStrLn (showTabuleiro tabuleiroUsr tabuleiroCpu)

    tabuleiroUsr <- putNavio tabuleiroUsr (naviosDefault !! 4)
    putStrLn (showTabuleiro tabuleiroUsr tabuleiroCpu)

    tabuleiroUsr <- putNavio tabuleiroUsr (naviosDefault !! 5)
    putStrLn (showTabuleiro tabuleiroUsr tabuleiroCpu)

    -- Configuração automática do tabuleiro da CPU (fixo por simplicidade)
    tabuleiroCpu <- putNavioManual tabuleiroCpu (head naviosDefault) (0,0) H
    tabuleiroCpu <- putNavioManual tabuleiroCpu (naviosDefault !! 1) (2,2) V
    tabuleiroCpu <- putNavioManual tabuleiroCpu (naviosDefault !! 2) (5,5) H
    tabuleiroCpu <- putNavioManual tabuleiroCpu (naviosDefault !! 3) (7,7) V
    tabuleiroCpu <- putNavioManual tabuleiroCpu (naviosDefault !! 4) (1,7) V
    tabuleiroCpu <- putNavioManual tabuleiroCpu (naviosDefault !! 5) (7,4) H

    jogoLoop tabuleiroUsr tabuleiroCpu

jogoLoop :: Tabuleiro -> Tabuleiro -> IO()
jogoLoop tabuleiroUsr tabuleiroCpu = do
    putStrLn "\nSua vez de atirar!"
    boardCpu <- makeShot tabuleiroCpu
    putStrLn (showTabuleiro tabuleiroUsr boardCpu)
    if checkVictory boardCpu
      then putStrLn "\nParabéns! Você venceu!"
      else do
        putStrLn "\nVez da CPU..."
        boardUsr <- makeShotCpu tabuleiroUsr
        putStrLn (showTabuleiro boardUsr boardCpu)
        if checkVictory boardUsr
          then putStrLn "\nA CPU venceu! Tente novamente."
          else jogoLoop boardUsr boardCpu

checkVictory :: Tabuleiro -> Bool
checkVictory board = all (all (\x -> x /= 1)) board

makeShotCpu :: Tabuleiro -> IO Tabuleiro
makeShotCpu tabuleiro = do
    let coord = gerarCoordenada tabuleiro
    let resultado = checkHit tabuleiro coord
    case resultado of
      2 -> do
        putStrLn ("\nCPU acertou na coordenada " ++ show coord ++ "!")
        return (atualizaIndice tabuleiro coord 2)
      3 -> do
        putStrLn ("\nCPU errou na coordenada " ++ show coord ++ ".")
        return (atualizaIndice tabuleiro coord 3)

-- Apenas prova de conceito: gera a primeira coordenada válida no tabuleiro
gerarCoordenada :: Tabuleiro -> Coordenada
gerarCoordenada tabuleiro = head [ (x,y) | x <- [0..boardSize - 1], y <- [0..boardSize - 1], (obterCoord (x,y) tabuleiro == 0 || obterCoord (x,y) tabuleiro == 1) ]

makeShot :: Tabuleiro -> IO Tabuleiro
makeShot tabuleiro = do
    coord <- getCoordenada
    let resultado = checkHit tabuleiro coord
    case resultado of
      -1 -> do
        putStrLn "\nPosição já atacada. Tente novamente."
        makeShot tabuleiro
      2 -> do
        putStrLn "\nAcertou!"
        return (atualizaIndice tabuleiro coord 2)
      3 -> do
        putStrLn "\nErrou!"
        return (atualizaIndice tabuleiro coord 3)

checkHit :: Tabuleiro -> Coordenada -> Int
checkHit tabuleiro (x,y)
  | obterCoord (x,y) tabuleiro == 2 || obterCoord (x,y) tabuleiro == 3  = -1 -- Posição já atacada
  | obterCoord (x,y) tabuleiro == 1                                     = 2  -- Hit
  | otherwise                                                           = 3  -- Miss

atualizaIndice :: Tabuleiro -> Coordenada -> Int -> Tabuleiro
atualizaIndice tabuleiro (x,y) val =
  take x tabuleiro ++
  [take y (tabuleiro !! x) ++ [val] ++ drop (y + 1) (tabuleiro !! x)] ++
  drop (x + 1) tabuleiro

putNavio :: Tabuleiro -> Navio -> IO Tabuleiro
putNavio tabuleiro navio = do
    putStrLn ("\nPosicione o " ++ tipo navio ++ " (tamanho " ++ show (tamanho navio) ++ ").")
    coord <- getCoordenada
    orient <- getOrient

    if checkOverlap tabuleiro navio coord orient
      then do
        putStrLn "\nNavio posicionado com sucesso!"
        return (posicionarNavio tabuleiro navio coord orient)
      else do
        putStrLn "\nPosição inválida para o navio."
        putNavio tabuleiro navio

putNavioManual :: Tabuleiro -> Navio -> Coordenada -> Orientacao -> IO Tabuleiro
putNavioManual tabuleiro navio coord orient =
    if checkOverlap tabuleiro navio coord orient
      then do
        return (posicionarNavio tabuleiro navio coord orient)
      else do
        return tabuleiro

posicionarNavio :: Tabuleiro -> Navio -> Coordenada -> Orientacao -> Tabuleiro
posicionarNavio tabuleiro navio (x,y) orient =
  let tam = tamanho navio
      coords = case orient of
                 V -> [(x + i, y) | i <- [0..tam - 1]]
                 H -> [(x, y + i) | i <- [0..tam - 1]]
  in addSegmentoNavio tabuleiro coords

addSegmentoNavio :: Tabuleiro -> [Coordenada] -> Tabuleiro
addSegmentoNavio tabuleiro [] = tabuleiro
addSegmentoNavio tabuleiro (coord:coords) =
  addSegmentoNavio (atualizaIndice tabuleiro coord 1) coords

getCoordenada :: IO Coordenada
getCoordenada = do
    putStrLn "Coordenada x: "
    putStr "> "
    xStr <- getLine
    putStrLn "Coordenada y: "
    putStr "> "
    yStr <- getLine
    let x = read xStr :: Int
    let y = read yStr :: Int
    if not (coordValida (x,y))
      then do
        putStrLn "Coordenadas inválidas. Tente novamente."
        getCoordenada
      else
      return (x,y)

getOrient :: IO Orientacao
getOrient = do
  putStrLn "Orientação (H para horizontal, V para vertical): "
  putStr "> "
  orientStr <- getLine
  case orientStr of
    "H" -> return H
    "h" -> return H
    "V" -> return V
    "v" -> return V
    _ -> do
      putStrLn "Orientação Inválida. Tente novamente"
      getOrient

checkOverlap :: Tabuleiro -> Navio -> Coordenada -> Orientacao -> Bool
checkOverlap tabuleiro navio (x,y) orient =
  let tam = tamanho navio
      coords = case orient of
                 V -> [(x + i, y) | i <- [0..tam - 1]]
                 H -> [(x, y + i) | i <- [0..tam - 1]]
  in all (\(cx,cy) -> (tabuleiro !! cx !! cy) == 0) coords

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
      Navio "Cruzador 1" 3,
      Navio "Cruzador 2" 3,
      Navio "Submarino 1" 2,
      Navio "Submarino 2" 2
    ]

coordValida :: Coordenada -> Bool
coordValida (x,y) = x >= 0 && x < boardSize && y >= 0 && y < boardSize

showElemento :: Int -> Char
showElemento n
  | n == 0 = '~'
  | n == 1 = 'N'
  | n == 2 = 'X'
  | n == 3 = 'O'

showElementoEncoberto :: Int -> Char
showElementoEncoberto n
  | n == 0 = '~'
  | n == 1 = '~'
  | n == 2 = 'X'
  | n == 3 = 'O'

showTabuleiro :: Tabuleiro -> Tabuleiro -> String
showTabuleiro boardUsr boardCpu = unlines [ [ showElemento (boardUsr !! y !! x) | x <- [0..boardSize - 1] ] ++ "    " ++ [ showElementoEncoberto (boardCpu !! y !! x) | x <- [0..boardSize - 1] ] | y <- [0..boardSize - 1] ]

obterCoord :: Coordenada -> Tabuleiro -> Int
obterCoord (x,y) board =
    (board !! x) !! y