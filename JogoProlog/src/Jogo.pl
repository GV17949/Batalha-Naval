comecar_jogo :-
	menu.

tamanho_tabuleiro(10).

% Aguá "~"
espaco(0).

% Navio 'N'
espaco(1).

% Acerto 'O'
espaco(2).

% Erro 'X'
espaco(3).

exibir_espaco(0, "~").

exibir_espaco(1, "N").

exibir_espaco(2, "O").

exibir_espaco(3, "X").

criar_tabuleiro(Tabuleiro) :-
	tamanho_tabuleiro(N),
	length(Linha, N),
	maplist(=(0), Linha),
	length(Tabuleiro, N),
	maplist(=(Linha), Tabuleiro).

navios([
	navio("Porta Aviões", 5),
	navio("Encouraçado", 4),
	navio("Cruzador 1", 3),
	navio("Cruzadro 2", 3),
	navio("Submarino 1", 2),
	navio("Submarino 2", 2)
]).


menu :- 
	writeln(" Bem-vindo ao Batalha-Naval!"),
	
	nl,
	writeln(" (1) Jogar"),
	writeln(" (2) Tutorial"),
	writeln(" (3) Sair"),
	nl,
	
	write(" >"),

	read_line_to_string(user_input, Opcao),
	case(Opcao).

case("1") :-
	write(" Jogo ainda em desenvolvimento"),
	nl,
	desenhar_tabuleiro(Tabuleiro_Usr),
	menu.


case("2") :-
	tutorial,
	menu.

case("3") :-
	nl,
	write(" Obrigado por jogar!"),
	halt.

case(_) :-
	nl,	
	write(" Opção inválida. Tente novamente"),
	menu.

tutorial :-
	nl,
	writeln(" Bem vindo ao Batalha Naval! Nesse jogo o seu principal objetivo é afundar todas as embarcações do seu oponente."),
	writeln(" Ao começar o jogo você tera em sua visão dois tabuleiros 10x10 definido em intervalos de 0 a 9 da seguinte forma:"),
	writeln("    0  1  2  3  4  5  6  7  8  9              GLOSSÁRIO: "),
	writeln(" 0  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~              ~ -> ÁGUA "),
	writeln(" 1  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~              N -> NAVIO "),
	writeln(" 2  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~              X -> NAVIO ACERTADO "),
	writeln(" 3  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~              O -> ESPAÇO ACERTADO VAZIO "),
	writeln(" 4  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"),
	writeln(" 5  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"),
	writeln(" 6  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"),
	writeln(" 7  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"),
	writeln(" 8  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"),
	writeln(" 9  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~"),
	writeln(" O tabuleiro a esquerda é o seu no qual você poderá colocar os seus navios e o tabuleiro a direita é o do seu oponente,"),
	writeln(" para alocar as suas embarcações basta fornecer a linha (x) e a coluna (y) que você deseja colocar a primeira parte dela seguida"),
	writeln(" da orientação (Vertical ou Horizontal) que você deseja que ela tome, caso você decida que quer o navio na horizontal a coordenada"),
	writeln(" fornecida anteriormente será a primeira parte do navio e as demais partes serão posicionadas a direita dessa coordenada no tabuleiro,"),
	writeln(" caso você decida posicionar o seu navio na vertical a coordenada obtida ainda será a primeira parte posicionada porém as demais partes"),
	writeln(" serão colocadas abaixo da coordenada inicial."),
	writeln(" Após a etapa de alocação dos navios o jogador terá acesso a opção de atirar no tabuleiro do seu oponente em determinada coordenada"),
	writeln(" em seguida ele receberá um feedback se o tiro foi ou não certeiro (ou seja se ele acertou alguma embarcação) e ele passará a vez para"),
	writeln(" oponente e a prioridade de ataque ficará alternando desse modo até que uma das partes afunde todos os navios presentes no tabuleiro inimigo"),
	nl.

desenhar_tabuleiro(Tabuleiro_Usr) :-
 tamanho_tabuleiro(T),
    T1 is T - 1,
    % Cabeçalho eixo X
    write('   '), forall(between(0, T1, I), format('~d  ', [I])),
    write('     '),
    write('   '), forall(between(0, T1, I), format('~d  ', [I])),
    nl,
    % Linhas com eixo Y
    forall(between(0, T1, I),
           (   % coordenada Y do jogador
               format('~|~t~d~2+ ', [I]),
               nth0(I, TabJog, LinhaJog),
               maplist(exibir_espaco, LinhaJog, SimbolosJog),
               atomic_list_concat(SimbolosJog, ' ', LinhaJogStr),
               write(LinhaJogStr),
               write('      '),
               nl
           )),
    nl.	

:- menu.

