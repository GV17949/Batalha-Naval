comecar_jogo :-
	menu.

tamanho_tabuleiro(10).

espaco(0).  % Água "~"
espaco(1).  % Navio 'N'
espaco(2).  % Acerto 'X'
espaco(3).  % Erro 'O'

exibir_espaco_usr(0, "~").
exibir_espaco_usr(1, "N").
exibir_espaco_usr(2, "X").
exibir_espaco_usr(3, "O").

exibir_espaco_cpu(0, "~").
exibir_espaco_cpu(1, "N").
exibir_espaco_cpu(2, "X").
exibir_espaco_cpu(3, "O").

criar_tabuleiro(Tabuleiro) :-
	tamanho_tabuleiro(N),
	length(Linha, N),
	maplist(=(0), Linha),
	length(Tabuleiro, N),
	maplist(=(Linha), Tabuleiro).


navio(1, ("Porta Aviões", 5)).
navio(2, ("Encouraçado", 4)).
navio(3, ("Cruzador 1", 3)).
navio(4, ("Cruzador 2", 3)).
navio(5, ("Submarino 1", 2)).
navio(6, ("Submarino 2", 2)).
navios([1, 2, 3, 4, 5, 6]).


menu :- 
	writeln("Bem-vindo ao Batalha-Naval!"),
	
	nl,
	writeln(" (1) Jogar"),
	writeln(" (2) Tutorial"),
	writeln(" (3) Sair"),
	nl,
	
	write("> "),

	read_line_to_string(user_input, Opcao),
	case(Opcao).

	case("1") :-
		write("Jogo ainda em desenvolvimento"),
	nl,
    criar_tabuleiro(Tab_Usr),
    criar_tabuleiro(Tab_Cpu),
	desenhar_tabuleiro(Tab_Usr, Tab_Cpu),
    obter_espaco(Tab_Usr, (3,2), V),
    write(V),
    nl,
    atualiza_espaco(Tab_Usr, (3,2), 1, New_Tab_Usr),
    desenhar_tabuleiro(New_Tab_Usr, Tab_Cpu),
    obter_espaco(New_Tab_Usr, (3,2), V2),
    write(V2),
    nl,
    gera_navio((2,2), horizontal, 5, PosicoesH),
    writeln(PosicoesH),
    gera_navio((2,2), vertical, 5, PosicoesV),
    writeln(PosicoesV),
    valida_pos(PosicoesH, Tab_Usr, P1),
    writeln(P1),
    gera_navio((6,2), vertical, 5, PosicoesV2),
    writeln(PosicoesV2),
    valida_pos(PosicoesV2, Tab_Usr, P2),
    writeln(P2),
	menu.

	case("2") :-
		tutorial,
		menu.

	case("3") :-
		nl,
		write("Obrigado por jogar!"),
	    	nl,
		halt.

	case("4") :-
		writeln("Caso 4"),
		criar_tabuleiro(Tab_Base),
		criar_tabuleiro(Tab_Cpu),
		obter_coord(Tab_Base, 5, Tab_Usr),
		desenhar_tabuleiro(Tab_Usr, Tab_Cpu),
		obter_coord(Tab_Usr, 4, New_Tab_Usr),
		desenhar_tabuleiro(New_Tab_Usr, Tab_Cpu),
		halt.

	case("5") :-
        posicionar_navios.

	case(_) :-
		nl,	
		write("Opção inválida. Tente novamente"),
		nl,
		menu.


posicionar_navios :-
    criar_tabuleiro(Tab_base),
    criar_tabuleiro(Tab_cpu_base),
    posicionar_cpu(Tab_cpu_base, Tab_cpu),
    desenhar_tabuleiro(Tab_base, Tab_cpu),
    nl,
    writeln("Posicione o Porta Aviões (tamanho 5)"),
    nl,
    obter_coord(Tab_base, 5, Tab_Usr1),
    nl,
    desenhar_tabuleiro(Tab_Usr1, Tab_cpu),
    nl,
    writeln("Posicione o Encouraçado (tamanho 4)"),
    nl,
    obter_coord(Tab_Usr1, 4, Tab_Usr2),
    nl,
    desenhar_tabuleiro(Tab_Usr2, Tab_cpu),
    nl,
    writeln("Posicione o Cruzador (tamanho 3)"),
    nl,
    obter_coord(Tab_Usr2, 3, Tab_Usr3),
    nl,
    desenhar_tabuleiro(Tab_Usr3, Tab_cpu),
    nl,
    writeln("Posicione o Submarino (tamanho 2)"),
    nl,
    obter_coord(Tab_Usr3, 2, Tab_Usr4),
    nl,
    desenhar_tabuleiro(Tab_Usr4, Tab_cpu),
    nl,
    !.

posicionar_cpu(Tab_In, Tab_Out) :-
    posicionar_navios_cpu(Tab_In, (0,0), horizontal, 5, Tab_temp1),
    posicionar_navios_cpu(Tab_temp1, (2,3), vertical, 4, Tab_temp2),
    posicionar_navios_cpu(Tab_temp2, (5,5), horizontal, 3, Tab_temp3),
    posicionar_navios_cpu(Tab_temp3, (1,7), vertical, 2, Tab_Out).


posicionar_navios_cpu(Tab_In, (X,Y), Orient, Size, Tab_Out) :-
    gera_navio((X,Y), Orient, Size, Posicoes),
    put_navio(Tab_In, Posicoes, Tab_Out).

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

desenhar_tabuleiro(Tab_Usr, Tab_Cpu) :-
    maplist(print_linha(), Tab_Usr, Tab_Cpu).

print_linha(Tab1, Tab2) :-
    print_espacos_usr(Tab1),
    write('     '),
    print_espacos_cpu(Tab2),
    nl.

print_espacos_usr([X]) :-
    exibir_espaco_usr(X, S),
    write(S).
print_espacos_usr([X|R]) :-
    exibir_espaco_usr(X, S),
    write(S),
    print_espacos_usr(R).

print_espacos_cpu([X]) :-
    exibir_espaco_cpu(X, S),
    write(S).
print_espacos_cpu([X|R]) :-
    exibir_espaco_cpu(X, S),
    write(S),
    print_espacos_cpu(R).

coord_valida((X,Y)) :-
    integer(X),
    integer(Y),
    tamanho_tabuleiro(N),
    X >= 0, X < N,
    Y >= 0, Y < N.

obter_espaco(Tab, (X,Y), Valor) :-
    nth0(X, Tab, Linha),
    nth0(Y, Linha, Valor).

atualiza_espaco(Tab_In, (X,Y), Valor, Tab_Out) :-
    nth0(X, Tab_In, Linha_In, Resto_Linhas),
    atualiza_index(Y, Valor, Linha_In, Linha_Out),
    nth0(X, Tab_Out, Linha_Out, Resto_Linhas).

atualiza_index(Index, Valor, Lista_In, Lista_Out) :-
    nth0(Index, Lista_In, _, Rest),
    nth0(Index, Lista_Out, Valor, Rest).

gera_navio((X,Y), vertical, Size, Posicoes) :-
    End_X is X + Size - 1,
    findall((Xi,Y), between(X, End_X, Xi), Posicoes).

gera_navio((X,Y), horizontal, Size, Posicoes) :-
    End_Y is Y + Size - 1,
    findall((X,Yi), between(Y, End_Y, Yi), Posicoes).

valida_pos(Posicoes, Tab, true) :-
    forall(member(Coord, Posicoes),
           (coord_valida(Coord),
            obter_espaco(Tab, Coord, V),
            V =:= 0)).

valida_pos(_Posicoes, _Tab, false).

obter_coord(Tab_In, Size, Tab_Out) :-
    writeln("Coordenada X:"),
    write("> "),
    read_line_to_string(user_input, X_Str),
    number_string(X, X_Str),
    writeln("Coordenada Y:"),
    write("> "),
    read_line_to_string(user_input, Y_Str),
    number_string(Y, Y_Str),
    (coord_valida((X,Y)) -> obter_orient(Tab_In, (X,Y), Size, Tab_Out)
        ; retry_ob_coord(Tab_In, Size, Tab_Out)).
retry_ob_coord(Tab_In, Size, Tab_Out) :-
    writeln("Coordenada inválida. Tente novamente"),
    obter_coord(Tab_In, Size, Tab_Out).

obter_orient(Tab_In, (X,Y), Size, Tab_Out) :-
    writeln("Orientação (H para horizontal, V para vertical):"),
    write("> "),
    read_line_to_string(user_input, S),
    string_upper(S, Orient),
    case_orientacao(Orient, Tab_In, (X,Y), Size, Tab_Out).

case_orientacao("H", Tab_In, (X,Y), Size, Tab_Out) :-
    gera_navio((X,Y), horizontal, Size, Posicoes),
    valida_pos(Posicoes, Tab_In, Resultado),
    (Resultado -> put_navio(Tab_In, Posicoes, Tab_Out) ;
        retry_ob_orient(Tab_In, (X,Y), Size, Tab_Out)).
case_orientacao("V", Tab_In, (X,Y), Size, Tab_Out) :-
    gera_navio((X,Y), vertical, Size, Posicoes),
    valida_pos(Posicoes, Tab_In, Resultado),
    (Resultado -> put_navio(Tab_In, Posicoes, Tab_Out) ;
        retry_ob_orient(Tab_In, (X,Y), Size, Tab_Out)).
case_orientacao(_, Tab_In, (X,Y), Size, Tab_Out) :-
    retry_ob_orient(Tab_In, (X,Y), Size, Tab_Out).

retry_ob_orient(Tab_In, (X,Y), Size, Tab_Out) :-
    writeln("Orientação inválida. Tente novamente"),
    obter_orient(Tab_In, (X,Y), Size, Tab_Out).

put_navio(Tab_In, [], Tab_In).
put_navio(Tab_In, [(X,Y)|Tail], Tab_Out) :-
    atualiza_espaco(Tab_In, (X,Y), 1, New_Tab),
    put_navio(New_Tab, Tail, Tab_Out), !.

:- menu.
