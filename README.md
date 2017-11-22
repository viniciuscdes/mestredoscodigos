## ![mestre dos códigos](http://mestredoscodigos.com.br/wp-content/uploads/2017/03/mestre-dos-codigos-logotipo.png) Território SQL 

> O game Mestre dos Códigos é um projeto interno da DB1 Global Software, que vai levar os desenvolvedores a uma jornada épica. [Saiba Mais](http://mestredoscodigos.com.br/sobre-mestre-dos-codigos/).


| Entregas | Exercícios     |
|-- | -- |
| Entrega I  | 1, 2, 3, 4, 5, 8, 9          |
| Entrega II | 6, 7, 10, 11, 12, 13, 14, 15 |


# Exercícios 

**[01]** Crie um modelo de dados contendo pelo menos 10 tabelas, sendo que pelo menos uma tabela deve conter chave composta; Criar ligações entre as tabelas com relacionamentos MxN e 1xN, mencionando no relacionamento o tipo de tratamento que será tomado quando um registro da tabela mestre for excluido. Mencione tambem no DDL os cuidados tomados com normalização e com a criação de indices;

**[02]** Realize 5 consultas no modelo de dados criado no item 1, realizando pelo menos uma das seguintes operações: Union, Intersect, Minus, e utilizando pelo menos 3 tipos diferentes de joins;

**[03]** Criar uma query hierarquica, ordenando os registros por uma coluna específica;

**[04]** Extrair um relatório do modelo de dados criado no item 1, utilizando 3 funções de agregação diferentes, e filtrando por pelo menos uma função agregadora;

**[05]** Sintetize o relatório criado no item 4 dentro de uma View Materializada;

**[08]** Criar uma função que valide um tipo de dado comparando o formato com uma Expressão Regular; 
Crie uma trigger que não permita a inserção/alteração do registro com base na validação da função criada;

**[09]** Criar uma JOB que execute diariamente uma procedure que atualize os dados de uma visão materializada com base nas informações do dia anterior;


---

  
**[011]** Crie uma query analítica extraindo informações relevantes dentro modelo do criado no item 1;

**[012]** Crie um tipo de dado, composto por pelo menos 2 atributos, e crie o DDL que altere o modelo de dados do item 1 para utiliza-lo;

**[07]** Criar um trigger que, ao realizar um INSERT em uma view composta por pelo menos 3 tabelas, realize inserção em uma outra tabela dentro do banco de dados;

---


**[06]** Otimize a consulta do item 4, detalhando as analises do plano de execução inicial e a cada modificação, e utilizando hints caso o banco de dados suportar;
EXPLAIN SELECT ...
 
**[010]** Crie uma package que armazene as informações do usuário logado, e que registre as operações que o mesmo realizou na sessão;

**[013]** Realize a carga de pelo menos 500.000 registros, utilizando bulk operations, gerando a massa de dados através do cross join entre algumas tabelas do modelo do criado no item 1, utilizando o tipo de dados criado no item 12;
 
**[014]** Crie uma tabela utilizando particionamento de dados, e explique no DDL a motivação e beneficios do particionamento realizado;

**[015]** Utilize paralelismo para otimizar a criação de um indice na tabela criada no item 13;
 
----------------------------------------------------
----------------------------------------------------
-- Criar o banco versão utilizada MySQL 5.7.12
----------------------------------------------------
----------------------------------------------------

CREATE DATABASE mestrecodigos;