# Batalha Naval: Haskell & Prolog 🚢💥

Este diretório contém as implementações do jogo Batalha Naval desenvolvidas para a disciplina de Paradigmas de Linguagens de Programação (PLP), referente ao período 2025.2 do curso de Ciência da Computação da Universidade Federal de Campina Grande (UFCG).

O projeto foi proposto pelo professor Ricardo Santos de Oliveira e tem como objetivo principal a aplicação prática dos conceitos de programação funcional e lógica.

# 📌 Sobre o Projeto

O jogo busca simular as mecânicas tradicionais do Batalha Naval clássico em ambiente de terminal, focando em:

    Posicionamento de Navios: Alocação estratégica das embarcações no tabuleiro.

    Alternância de Turnos: Lógica de jogo baseada em rodadas entre jogador e máquina.

    Sistema de Ataques: Verificação de coordenadas e feedback de acerto ou não.

    Condição de Vitória: Verificação automática de quando todos os navios de um oponente foram afundados.

    Interface I/O: Interação fluida via entrada e saída padrão. 

    🛠️ Tecnologias e Paradigmas

O projeto está dividido em duas versões principais:

    Haskell (Paradigma Funcional): Explora a imutabilidade, funções de alta ordem, tipos de dados algébricos e a gestão de estado através de recursão.

    Prolog (Paradigma Lógico): Foca em fatos, regras e unificação para gerenciar o tabuleiro e as condições de jogo.

# 💜 Versão em Haskell

Certifique-se de ter o GHC (Glasgow Haskell Compiler) instalado.

      # Para compilar e rodar:
      ghc -o batalha_naval_haskell Main.hs
      ./batalha_naval_haskell
      
      # Ou apenas rodar via interpretador:
      runghc Main.hs

# 🦉 Versão em Prolog

Certifique-se de ter o SWI-Prolog instalado.

      # Iniciar o interpretador com o arquivo:
      swipl -s jogo.pl

      # Dentro do interpretador, inicie o jogo (exemplo):
      ?- jogar.

# 🎓 Alunos

- Ana Lívia Costa Celestino Santos
- Gabriel Victor Santos Lima
- João Victor Muniz Cabral
- Luis Henrique Araújo Ramos 
