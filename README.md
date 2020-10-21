# Grupo 3 - Desafio 2 - CNJ Inova

Somos o grupo 3, formado por:
- Antônio Vinícius (programação)
- Antônio Henrique (programação)
- Eduardo Côrtes (ciência de dados)
- Gabriel Reis (ciência de dados)
- João Gabriel (ciência de dados)
- Letícia Teixeira (direito) 

## O problema
Abordamos o desafio 2 do CNJ Inova, que traz o problema da inconsistência de dados do DataJud, decorrente da diversidade dos sistemas dos tribunais e erros e/ou omissões no preenchimento dos dados. Essa inconsistência dificulta muito qualquer tipo de análise, diagnóstico e implementação de medidas promotoras de celeridade e produtividade do judiciário brasileiro, daí a importância e enorme valor de uma solução para o problema apresentado. 


## O recorte 
Para desenvolver a solução, optamos por focar na justiça estadual, por ser a porta de entrada para o judiciário e a mais próxima da população. De forma a gerar resultados mais precisos e adaptáveis, restringimos ainda para Juizados Especiais, por possui uma grande diversidade de processos, partes e assuntos, resultando em um grande potencial de inconsistências nos dados. Mas a análise por ser alterada e adaptada para outros ramos e graus da justiça. 


## A solução 
Nossa solução envolve a aplicação de um algoritmo de *machine learning* não supervisionado, que atribui um *score* de inconsistência para os dados do DataJud. Os scores são, então, calculados e agrupados por tribunal, de maneira a chegar em uma pontuação geral e ranking final de inconsistência. 
O ranking foi pensado para dialogar com o Prêmio CNJ de Qualidade, com pontuações para os tribunais com menor *score* de inconsistência como incentivo para uma maior atenção na inserção correta de dados. 

## A tecnologia
Foi utilizado o R para toda a análise, por ser linguagem e software livres e para facilitar a utilização e integração pela equipe do CNJ, uma vez que foi dito em *live* que os estatísticos da instituição utilizam R. Foram usados diversos pacotes ao longo da análise, explicitados nos scrips e markdowns do repositório. Para o dashboard final, disponível em https://tukey.shinyapps.io/cnj_inconsistencias/, utilizamos Shiny, um pacote do R para aplicativos web interativos.
