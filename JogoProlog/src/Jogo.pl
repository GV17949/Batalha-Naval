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
	navio("Submarino 2", 2),
])


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
	write(" Jogo ainda em desenvolvimento").


case("2") :-
	write(" Tutorial a ser escrito").

case("3") :-
	nl,
	write(" Obrigado por jogar!"),
	halt.

case(_) :-
	nl,	
	write(" Opção inválida. Tente novamente"),
	menu.

:- menu.

