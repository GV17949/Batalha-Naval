# Batalha Naval: Haskell & Prolog 🚢💥

Este diretório contém as implementações do jogo Batalha Naval desenvolvidas para a disciplina de Paradigmas de Linguagens de Programação (PLP), referente ao período 2025.2 do curso de Ciência da Computação da Universidade Federal de Campina Grande (UFCG).

O projeto foi proposto pelo professor Ricardo Santos de Oliveira e tem como objetivo principal a aplicação prática dos conceitos de programação funcional e lógica.

## Sobre o Projeto

O jogo busca simular as mecânicas tradicionais do Batalha Naval clássico em ambiente de terminal, focando em:

- **Posicionamento de Navios:** Alocação estratégica das embarcações no tabuleiro.

- **Alternância de Turnos:** Lógica de jogo baseada em rodadas entre jogador e máquina.

- **Sistema de Ataques:** Verificação de coordenadas e feedback de acerto ou não.

- **Condição de Vitória:** Verificação automática de quando todos os navios de um oponente foram afundados.

- **Interface I/O:** Interação fluida via entrada e saída padrão.


## Tecnologias e Paradigmas

O projeto está dividido em duas versões principais:

- **Haskell (Paradigma Funcional):** Explora a imutabilidade, funções de alta ordem, tipos de dados algébricos e a gestão de estado através de recursão.

- **Prolog (Paradigma Lógico):** Foca em fatos, regras e unificação para gerenciar o tabuleiro e as condições de jogo.

## Comparativo de Implementação: Haskell vs. Prolog

Neste projeto, o Batalha Naval foi o laboratório para explorar como diferentes paradigmas resolvem o mesmo problema.

| Característica | **Haskell (Paradigma Funcional)** | **Prolog (Paradigma Lógico)** |
| :--- | :--- | :--- |
| **Abordagem** | Baseada na aplicação de funções puras e transformações de dados. | Baseada em fatos, regras e prova de teoremas. |
| **Estado do Jogo** | Passado explicitamente como argumentos em funções recursivas. | Gerido via unificação de variáveis em predicados. |
| **Fluxo de Controle** | Definido por recursão e Casamento de Padrões (*Pattern Matching*). | Definido pelo mecanismo de busca e *Backtracking*. |
| **Validação** | Uso de tipos e funções booleanas. | Uso de predicados que "provam" se uma jogada é válida. |
| **Condição de Vitória** | Funções de alta ordem que processam as listas do tabuleiro. | Lógica de primeira ordem com quantificadores (`forall`). |
| **Interface (I/O)** | Gerida rigorosamente dentro da interface `IO`. | Realizada através de predicados de efeito colateral (`write`, `read`). |



## 🎓 Alunos

- Ana Lívia Costa Celestino Santos
- Gabriel Victor Santos Lima
- João Victor Muniz Cabral
- Luis Henrique Araújo Ramos
