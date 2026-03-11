# 🛳️ BATALHA NAVAL EM PROLOG

Implementação do jogo Batalha Naval, desenvolvido inteiramente em Prolog, como parte da disciplina Paradigmas de Linguagens de Programação da Universidade Federal de Campina Grande (UFCG), sob orientação do professor Ricardo Santos de Oliveira.

O jogo é executado no terminal e aplica os conceitos do paradigma lógico, explorando o motor de inferência, unificação, retrocesso (backtracking) e recursão, a fim de reproduzir a lógica clássica do jogo de tabuleiro de forma declarativa.

# Objetivo do Projeto

O objetivo principal é consolidar os conhecimentos do paradigma lógico estudados em sala de aula para:

  - Desenvolver a inteligência e a mecânica de um jogo utilizando Prolog.

  - Modelar o estado do tabuleiro e as regras de combate através de predicados e fatos.
  
  - Aplicar a lógica de primeira ordem para validação de vitórias e ataques.

# Tecnologias Utilizadas

- SWI-Prolog – Interpretador e ambiente de desenvolvimento para a linguagem Prolog.

- Terminal – Interface de entrada e saída de dados via user_input.

- Built-ins e Bibliotecas:

        maplist/3 – Para manipulação e exibição de matrizes (tabuleiros).

        findall/3 e between/3 – Para geração dinâmica de coordenadas e posicionamento de navios.

        forall/2 – Para verificação lógica de condições de vitória e integridade de posições.

# Conceitos de Paradigma Lógico Aplicados

Diferente da versão funcional, esta implementação foca em:

- **Unificação:** Utilizada para traduzir os estados numéricos do tabuleiro em representações visuais (~, N, X, O).

- **Base de Fatos:** Definição estática das propriedades dos navios e tamanhos do tabuleiro.

- **Recursão e Acumuladores:** Utilizados para o preenchimento de listas e processamento de jogadas.

- **Predicados Declarativos:** A condição de vitória não é um "loop de contagem", mas sim uma prova lógica da ausência de navios intactos no tabuleiro.

# Como Executar o Projeto
Pré-requisitos:

    SWI-Prolog instalado (comando swipl).

Passo a Passo:

    Acesse a pasta do projeto:
    Bash

    cd Batalha-Naval/JogoProlog/src

    Inicie o interpretador com o arquivo do jogo:
    Bash

    swipl -s Jogo2.pl

    Inicie a execução:
    Dentro do console do Prolog (identificado pelo prompt ?-), digite:
    Prolog

    ?- comecar_jogo.

# Licença

Este projeto está licenciado sob a BSD 3-Clause License. Consulte o arquivo LICENSE para mais informações.
