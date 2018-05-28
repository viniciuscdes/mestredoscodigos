----------------------------------------------------
----------------------------------------------------
-- Perguntas
----------------------------------------------------
----------------------------------------------------
  -- [ENTREGA I]

1) Crie um modelo de dados contendo pelo menos 10 tabelas, sendo que pelo menos uma tabela deve conter chave composta; Criar ligações entre as tabelas com relacionamentos MxN e 1xN, mencionando no relacionamento o tipo de tratamento que será tomado quando um registro da tabela mestre for excluido. Mencione tambem no DDL os cuidados tomados com normalização e com a criação de indices;

2) Realize 5 consultas no modelo de dados criado no item 1, realizando pelo menos uma das seguintes operações: Union, Intersect, Minus, e utilizando pelo menos 3 tipos diferentes de joins;

3) Criar uma query hierarquica, ordenando os registros por uma coluna específica;

4) Extrair um relatório do modelo de dados criado no item 1, utilizando 3 funções de agregação diferentes, e filtrando por pelo menos uma função agregadora;

5) Sintetize o relatório criado no item 4 dentro de uma View Materializada;

8) Criar uma função que valide um tipo de dado comparando o formato com uma Expressão Regular; 
Crie uma trigger que não permita a inserção/alteração do registro com base na validação da função criada;

9) Criar uma JOB que execute diariamente uma procedure que atualize os dados de uma visão materializada com base nas informações do dia anterior;


----------------------------------------------------
----------------------------------------------------

-- [ENTREGA II]
  
7) Criar um trigger que, ao realizar um INSERT em uma view composta por pelo menos 3 tabelas, realize inserção em uma outra tabela dentro do banco de dados; 

11) Crie uma query analítica extraindo informações relevantes dentro modelo do criado no item 1;

12) Crie um tipo de dado, composto por pelo menos 2 atributos, e crie o DDL que altere o modelo de dados do item 1 para utiliza-lo;


----------------------------------------------------
----------------------------------------------------

-- [ENTREGA III]


6) Otimize a consulta do item 4, detalhando as analises do plano de execução inicial e a cada modificação, e utilizando hints caso o banco de dados suportar;

10) Crie uma package que armazene as informações do usuário logado, e que registre as operações que o mesmo realizou na sessão;

13) Realize a carga de pelo menos 500.000 registros, utilizando bulk operations, gerando a massa de dados através do cross join entre algumas tabelas do modelo do criado no item 1, utilizando o tipo de dados criado no item 12;

14) Crie uma tabela utilizando particionamento de dados, e explique no DDL a motivação e beneficios do particionamento realizado;

15) Utilize paralelismo para otimizar a criação de um indice na tabela criada no item 13;

----------------------------------------------------
----------------------------------------------------

----------------------------------------------------
----------------------------------------------------
-- Criar o banco versão utilizada MySQL 5.7.12
----------------------------------------------------
----------------------------------------------------

CREATE DATABASE mestrecodigos;
 
----------------------------------------------------
----------------------------------------------------
-- Tabelas
----------------------------------------------------
----------------------------------------------------


CREATE TABLE paises (
  id int(11) NOT NULL AUTO_INCREMENT,
  nome_pais varchar(255) NOT NULL, 
  PRIMARY KEY (id),
  UNIQUE KEY pk_pais_id (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE estados (
  id          int(11) NOT NULL AUTO_INCREMENT,
  nome_estado varchar(255) NOT NULL,
  pais_id     int(11) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_estado_id (id),
  KEY fk_pais_estado_id_idx (pais_id),
  CONSTRAINT fk_pais_estado_id FOREIGN KEY (pais_id) REFERENCES paises (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE cidades (
  id          int(11) NOT NULL AUTO_INCREMENT,
  nome_cidade varchar(255) NOT NULL,
  estado_Id   int(11) NOT NULL,
  pais_id     int(11) NOT NULL,
  PRIMARY KEY (id),
   UNIQUE KEY pk_cidade_id (id),
          KEY fk_cidade_estado_id_idx (estado_Id),
          KEY fk_cidade_pais_id_idx (pais_id),
   CONSTRAINT fk_cidade_estado_id 
  FOREIGN KEY (estado_Id) REFERENCES estados (id) 
 ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT  fk_cidade_pais_id 
 FOREIGN KEY  (pais_id) REFERENCES  paises (id) 
ON DELETE NO  ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE enderecos (
  id               int(11)      NOT NULL AUTO_INCREMENT,
  cep              varchar(30)  NOT NULL COMMENT 'cep do endereço',
  tipo_logradouro  varchar(1)   DEFAULT NULL,
  logradouro       varchar(100) DEFAULT NULL,
  endereco         varchar(255) NOT NULL,
  bairro           varchar(100) DEFAULT NULL,
  complemento      varchar(255) DEFAULT NULL,
  pais_id          int(11)      NOT NULL,
  estado_id        int(11)      NOT NULL,
  cidade_id        int(11)      NOT NULL,
  PRIMARY KEY (id,cep),
  UNIQUE KEY pk_endereco_id (id),
  UNIQUE KEY uk_endereco_cep (cep),
  KEY fk_endereco_pais_id_idx (pais_id),
  KEY fk_endereco_cidade_id_idx (cidade_id),
  KEY fk_endereco_estado_id_idx (estado_id),
  CONSTRAINT fk_endereco_cidade_id FOREIGN KEY (cidade_id) REFERENCES cidades (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_endereco_estado_id FOREIGN KEY (estado_id) REFERENCES estados (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_endereco_pais_id FOREIGN KEY (pais_id) REFERENCES paises (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabela de endereco	';


CREATE TABLE categorias (
  id             int(11) NOT NULL AUTO_INCREMENT,
  descricao      varchar(100) NOT NULL,
  status         varchar(1) NOT NULL DEFAULT 'A' COMMENT 'A - Ativo / C - Cancelada',
  PRIMARY KEY (id),
  UNIQUE KEY pk_categoria_id (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Categoria de clientes';


CREATE TABLE clientes (
  id               int(11) NOT NULL,
  razao_social     varchar(255) NOT NULL,
  nome_fantasia    varchar(255) DEFAULT NULL,
  tipo_pessoa      int(11) DEFAULT NULL,
  cpf_cnpj         varchar(40) NOT NULL,
  categoria_id     int(11) DEFAULT NULL,
  status           varchar(1) DEFAULT 'A' COMMENT 'A - Ativo / C - Cancelado',
  email            varchar(100) NOT NULL,
  data_criacao     datetime DEFAULT NULL,
  ultima_alteracao datetime DEFAULT NULL,
  telefone         json DEFAULT NULL,
  telefonelocais   varchar(40) GENERATED ALWAYS AS (json_keys(telefone)) STORED,
  PRIMARY KEY (id),
  UNIQUE KEY pk_cliente_id (id),
  KEY fk_cliente_categoria_id_idx (categoria_id),
  KEY fk_clientes_locais_idx (telefonelocais),
  CONSTRAINT fk_clientes_locais FOREIGN KEY (telefonelocais) REFERENCES locaistelefone (listalocais) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE fornecedores (
  id               int(11)      NOT NULL AUTO_INCREMENT,
  razao_social     varchar(255) DEFAULT NULL,
  nome_fantasia    varchar(255) DEFAULT NULL,
  endereco_id      int(11)      DEFAULT NULL,
  status           varchar(1)   NOT NULL DEFAULT 'A' COMMENT 'A - Ativo / C - Cancelado ',
  data_criacao     datetime     DEFAULT NULL,
  ultima_alteracao datetime     DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_fornecedores_id (id),
  KEY fk_fornecedor_endereco_id_idx (endereco_id),
  CONSTRAINT fk_fornecedor_endereco_id FOREIGN KEY (endereco_id) REFERENCES enderecos (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE vendedores (
  id               int(11) NOT NULL AUTO_INCREMENT,
  nome             varchar(255) NOT NULL,
  cpf              varchar(255) DEFAULT NULL,
  comissao         float NOT NULL,
  gerente_id       INT(11) NOT NULL,
  data_criacao     datetime DEFAULT NULL,
  ultima_alteracao datetime DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_vendedor_id (id),
  KEY fk_vendedor_gerente_id_idx (gerente_id),
  CONSTRAINT fk_vendedor_gerente_id FOREIGN KEY (gerente_id) REFERENCES vendedores (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tipo_produtos (
  id               int(11) NOT NULL AUTO_INCREMENT,
  descricao        varchar(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_tipoprodutos_id (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela de tipo de produtos';

CREATE TABLE produtos (
  id               int(11) NOT NULL AUTO_INCREMENT,
  descricao        varchar(255) DEFAULT NULL,
  tipo_produto_id  int(11) NOT NULL,
  observacao       text,
  status           varchar(1) DEFAULT 'A' COMMENT 'A - Ativo / C - Cancelado',
  data_criacao     datetime DEFAULT NULL,
  ultima_alteracao datetime DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_produto_id (id),
  KEY fk_produto_tipoproduto_id_idx (tipo_produto_id),
  CONSTRAINT fk_produto_tipoproduto_id FOREIGN KEY (tipo_produto_id) REFERENCES tipo_produtos (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE produtos_fornecedores (
  id            int(11) NOT NULL AUTO_INCREMENT,
  fornecedor_id int(11) DEFAULT NULL,
  produto_id    int(11) DEFAULT NULL,
  valor         double(10,2) NOT NULL,
  data_vigente  datetime NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_produtofornecedor (id),
  KEY fk_produtofornecedor_fornecedor_id_idx (fornecedor_id),
  KEY fk_produtofornecedor_produto_id_idx (produto_id),
  CONSTRAINT fk_produtofornecedor_fornecedor_id FOREIGN KEY (fornecedor_id) REFERENCES fornecedores (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_produtofornecedor_produto_id FOREIGN KEY (produto_id) REFERENCES produtos (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE orcamentos (
  id               int(11) NOT NULL AUTO_INCREMENT,
  cliente_id       int(11) DEFAULT NULL,
  vendedor_id      int(11) DEFAULT NULL,
  vencimento       date DEFAULT NULL,
  valor_orcamento  double(10,2) DEFAULT NULL,
  valor_desconto   double(10,2) DEFAULT NULL,
  status           varchar(1) DEFAULT 'O' COMMENT 'O - Orcamento / C - Cancelada / V - Venda',
  PRIMARY KEY (id),
  UNIQUE KEY pk_orcamento_id (id),
  KEY fk_orcamento_cliente_id_idx (cliente_id),
  KEY fk_oracamento_vendedor_id_idx (vendedor_id),
  CONSTRAINT fk_oracamento_vendedor_id FOREIGN KEY (vendedor_id) REFERENCES vendedores (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_orcamento_cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


CREATE TABLE itens_orcamentos (
  id               int(11) NOT NULL AUTO_INCREMENT,
  orcamento_id     int(11) DEFAULT NULL,
  fornecedor_id    int(11) DEFAULT NULL,
  produto_id       int(11) DEFAULT NULL,
  quantidade       int(11) DEFAULT NULL,
  valor_unitario   double(10,2) DEFAULT NULL,
  desconto         double(10,2) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_itemorcamento_id (id),
  KEY fk_itemorcamento_orcamento_id_idx (orcamento_id),
  KEY fk_itemorcamento_produto_id (produto_id),
  KEY fk_itemorcamento_fornecedor_id_idx (fornecedor_id),
  CONSTRAINT fk_itemorcamento_fornecedor_id FOREIGN KEY (fornecedor_id) REFERENCES fornecedores (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_itemorcamento_orcamento_id FOREIGN KEY (orcamento_id) REFERENCES orcamentos (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_itemorcamento_produto_id FOREIGN KEY (produto_id) REFERENCES produtos (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE vendas (
  id               int(11) NOT NULL AUTO_INCREMENT,
  orcamento_id     int(11) DEFAULT NULL,
  cliente_id       int(11) NOT NULL,
  vendedor_id      int(11) DEFAULT NULL,
  valor_venda      double(10,2) DEFAULT NULL,
  desconto         double(10,2) DEFAULT NULL,
  status_entrega   varchar(1) NOT NULL DEFAULT 'O' COMMENT 'O - Confirmado / V - Enviado / E - Entregue / C - Cancelado ',
  data_pagamento   datetime DEFAULT NULL,
  data_entrega     datetime DEFAULT NULL,
  data_criacao     datetime DEFAULT NULL,
  data_alteracao   datetime DEFAULT NULL,
  ultima_alteracao datetime DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_venda_id (id),
  KEY fk_venda_orcamento_id_idx (orcamento_id),
  KEY fk_venda_cliente_id_idx (cliente_id),
  KEY fk_venda_vendedor_id_idx (vendedor_id),
  CONSTRAINT fk_venda_cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_venda_orcamento_id FOREIGN KEY (orcamento_id) REFERENCES orcamentos (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_venda_vendedor_id FOREIGN KEY (vendedor_id) REFERENCES vendedores (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE itens_vendas (
  id               int(11) NOT NULL AUTO_INCREMENT,
  venda_id         int(11) NOT NULL,
  fornecedor_id    int(11) DEFAULT NULL,
  produto_id       int(11) NOT NULL,
  valor_unitario   double(10,2) NOT NULL,
  quantidade       double(10,2) NOT NULL,
  desconto         double(10,2) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_itemvenda_id (id),
  KEY fk_itemvenda_produto_id_idx (produto_id),
  KEY fk_itemvenda_venda_id_idx (venda_id),
  CONSTRAINT fk_itemvenda_produto_id FOREIGN KEY (produto_id) REFERENCES produtos (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_itemvenda_venda_id FOREIGN KEY (venda_id) REFERENCES vendas (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='				';


CREATE TABLE comissoes (
  id               int(11) NOT NULL AUTO_INCREMENT,
  venda_id         int(11) NOT NULL,
  vendedor_id      int(11) NOT NULL,
  valor_comissao   double(10,2) NOT NULL,
  data_pagamento   date DEFAULT NULL,
  status           varchar(1) NOT NULL DEFAULT 'G' COMMENT 'G - Gerada / A - Em Analise / P - Paga / C - Cancelada',
  data_criacao     datetime DEFAULT NULL,
  data_alteracao   datetime DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_comissao_id (id),
  KEY fk_comissao_venda_id_idx (venda_id),
  KEY fk_comissao_vendedor_id_idx (vendedor_id),
  CONSTRAINT fk_comissao_venda_id FOREIGN KEY (venda_id) REFERENCES vendas (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_comissao_vendedor_id FOREIGN KEY (vendedor_id) REFERENCES vendedores (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

 

----------------------------------------------------
----------------------------------------------------
-- Triggers.sql
----------------------------------------------------
----------------------------------------------------

 

DELIMITER ;;
CREATE TRIGGER tri_comissoes_bi  
BEFORE INSERT ON  comissoes  FOR EACH ROW
BEGIN
   set new.data_criacao = now();
END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_comissoes_bu 
BEFORE UPDATE ON  comissoes  FOR EACH ROW
BEGIN
	set new.data_alteracao = now();
END;;
DELIMITER ;
 

DELIMITER ;;
CREATE TRIGGER tri_fornecedores_bi  
BEFORE INSERT ON  fornecedores  FOR EACH ROW
BEGIN
set new.data_criacao = now();
 
END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_fornecedores_bu 
BEFORE UPDATE ON  fornecedores  FOR EACH ROW
BEGIN
set new.ultima_alteracao = now();

END;;
DELIMITER ;
   

DELIMITER ;;
CREATE TRIGGER tri_produtos_bi  
BEFORE INSERT ON  produtos  FOR EACH ROW
BEGIN
	set new.data_criacao = now();
END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_produtos_bu  
BEFORE UPDATE ON  produtos  FOR EACH ROW
BEGIN
set new.ultima_alteracao = now();
END;;
DELIMITER ;
 
DELIMITER ;;
CREATE TRIGGER tri_vendas_bi  
BEFORE INSERT ON  vendas  FOR EACH ROW
BEGIN
set new.data_criacao = now();

END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_vendas_bu  
BEFORE UPDATE ON  vendas  FOR EACH ROW
BEGIN
set new.data_alteracao = now();

END;;
DELIMITER ;


DELIMITER ;;
CREATE TRIGGER tri_vendedores_bi  
BEFORE INSERT ON  vendedores  FOR EACH ROW
BEGIN
set new.data_criacao = now();

END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_vendedores_bu
BEFORE UPDATE ON  vendedores  FOR EACH ROW
BEGIN
set new.ultima_alteracao = now();

END;;
DELIMITER ;

----------------------------------------------------
----------------------------------------------------
-- RESPOSTAS
----------------------------------------------------
---------------------------------------------------- 

 
-- total de comissao por vendedor 
   SELECT vendedores.nome    'VENDEDOR  ', SUM(vendas.valor_venda) 'TOTAL VENDAS', 
          vendedores.comissao'COMISSAO %', SUM(valor_comissao)      'COMISSÃO TOTAL'
     FROM vendedores, comissoes, vendas
    WHERE vendedores.id = comissoes.vendedor_id
      AND comissoes.venda_id = vendas.id
      AND vendedores.id = vendas.vendedor_id
 GROUP BY comissoes.vendedor_id
 ORDER BY 1;

-- Vendedores que não realizaram vendas 
   SELECT vendedores.* 
     FROM vendedores  
LEFT JOIN vendas 
       ON vendedores.id = vendas.vendedor_id
    WHERE vendas.vendedor_id IS NULL;
  
-- Clientes que realizaram compras
SELECT clientes.razao_social, vendas.data_criacao
  FROM clientes
  JOIN vendas
    ON clientes.id = vendas.cliente_id
 ORDER BY 1,2;
    
-- Produtos que foram vendidos e não foram	
    SELECT itens_vendas.venda_id, produtos.descricao
      FROM itens_vendas
RIGHT JOIN produtos
        ON itens_vendas.produto_id = produtos.id;
 
-- Quantidade de produtos vendidos
SELECT produtos.descricao, COUNT(produto_id)
  FROM produtos, itens_vendas
 WHERE produtos.id = itens_vendas.produto_id
 GROUP BY(produtos.id);
 
 
-- Vendedores que fizeram e não fizeram vendas
   SELECT DISTINCT vendedores.nome ,'FEZ VENDAS'
	 FROM vendedores, comissoes
	WHERE vendedores.id = comissoes.vendedor_id
UNION ALL
   SELECT DISTINCT vendedores.nome ,'NÃO FEZ VENDAS'
     FROM vendedores  
LEFT JOIN vendas 
       ON vendedores.id = vendas.vendedor_id
    WHERE vendas.vendedor_id IS NULL 
 ORDER BY 2,1;
   
-- Relatório de vendas   
   SELECT vendedores.nome         'VENDEDOR  ', 
          COUNT(vendas.id)        'QUANTIDADE DE VENDAS',
		  SUM(vendas.valor_venda) 'TOTAL R$ VENDAS', 
          vendedores.comissao     'COMISSAO %', 
		  SUM(valor_comissao)     'COMISSÃO TOTAL', 
		  AVG(vendas.valor_venda) 'TOTAL R$ MÉDIO DAS VENDAS',
		  MAX(vendas.valor_venda) 'MAIOR VENDA',
		  MIN(vendas.valor_venda) 'MENOR VENDA'
     FROM vendedores, comissoes, vendas
    WHERE vendedores.id      = comissoes.vendedor_id
      AND comissoes.venda_id = vendas.id
      AND vendedores.id      = vendas.vendedor_id
 GROUP BY comissoes.vendedor_id
 ORDER BY 1; 
 
-- Query hierarquica
    SELECT g.nome AS 'Gerente',
           v.nome AS 'Vendedor' 
      FROM vendedores v
INNER JOIN vendedores g 
        ON g.id = v.gerente_id
  ORDER BY g.nome; 
 
 


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
                            -- [EXERCÍCIO 06] -- 
--------------------------------------------------------------------------------- 
                        
  EXPLAIN SELECT /*+ MAX_EXECUTION_TIME(1000) */
          vendedores.nome         'VENDEDOR  ', 
          COUNT(vendas.id)        'QUANTIDADE DE VENDAS',
		  SUM(vendas.valor_venda) 'TOTAL R$ VENDAS', 
          vendedores.comissao     'COMISSAO %', 
		  
		  SUM(valor_comissao)     'COMISSÃO TOTAL', 
		  AVG(vendas.valor_venda) 'TOTAL R$ MÉDIO DAS VENDAS',
		  MAX(vendas.valor_venda) 'MAIOR VENDA',
		  MIN(vendas.valor_venda) 'MENOR VENDA'
     FROM vendedores, comissoes, vendas
    WHERE vendedores.id      = comissoes.vendedor_id
      AND comissoes.venda_id = vendas.id
      AND vendedores.id      = vendas.vendedor_id
 GROUP BY comissoes.vendedor_id
 ORDER BY 1;                          
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
                            -- [EXERCÍCIO 07 ] --
---------------------------------------------------------------------------------
  -- create view
  
CREATE VIEW view_produtos_vendas 
    AS (SELECT vendas.valor_venda 'valor_venda',
               produtos.descricao 'produto',
               fornecedores.razao_social 'fornecedor',
               produtos.tipo_produto_id 'tipo_produto'
          FROM produtos, vendas, itens_vendas, fornecedores, tipo_produtos
         WHERE vendas.id = itens_vendas.venda_id
           AND produtos.id = itens_vendas.produto_id
           AND itens_vendas.fornecedor_id = fornecedores.id
           AND produtos.tipo_produto_id = tipo_produtos.id);
  
  
  -- create insert na view

    
    INSERT INTO view_produtos_vendas(produto, tipo_produto)
     VALUES ('Novo Produto', 2);
      
  
  -- create trigger
    -- a cada novo produto inserido na tabela produtos, é inserido o mesmo produto para todos os fornecedores na tabela 'produtos_fornecedores' 
DELIMITER ;;  
CREATE TRIGGER produtos_vendas_ai 
AFTER INSERT ON produtos FOR EACH ROW
BEGIN

  DECLARE done         INT DEFAULT FALSE;
  DECLARE idnewproduto INT default 0;
  DECLARE idfornecedor INT default 0;
  
  DECLARE busca_fornecedor cursor for 
   SELECT id
     FROM fornecedores;
  
  DECLARE CONTINUE HANDLER FOR NOT found SET done = TRUE;     
  
  SET idnewproduto = new.id;
  
   OPEN busca_fornecedor;
   
     fornecedor: LOOP
     
      FETCH busca_fornecedor INTO idfornecedor;
      
         IF done THEN
      LEAVE fornecedor;
	 END IF;
     
     INSERT INTO produtos_fornecedores (produto_id, fornecedor_id, valor, data_vigente)
          VALUES (idnewproduto, idfornecedor, 0, now() );
     
     END LOOP fornecedor;
        CLOSE busca_fornecedor;

END;;
DELIMITER ;



---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
                            -- [EXERCÍCIO 08] -- 
---------------------------------------------------------------------------------   
-- Function validar email do cliente (expressão regular)
drop function valida_email;

DELIMITER $$
CREATE FUNCTION valida_email(email VARCHAR(100))
  RETURNS VARCHAR(1)
BEGIN
  DECLARE validacao VARCHAR(1);
  
  SELECT email NOT REGEXP '^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$' INTO validacao; 

  RETURN validacao;
   
END;
$$
DELIMITER ;

-- Trigger para validar o email no insert 
DELIMITER ;;
CREATE  TRIGGER tri_clientes_bi  
BEFORE INSERT ON  clientes  FOR EACH ROW
BEGIN
   DECLARE msg_erro VARCHAR(255);
   
   IF (NEW.email IS NOT NULL) and (valida_email(NEW.email) = '1') THEN
	 SET msg_erro = "FORMATO DO EMAIL INCORRETO";
	 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_erro;
   END IF;
    
   SET NEW.data_criacao = now();
END;;
DELIMITER ;

-- Trigger para validar o email no update 
DELIMITER ;;
CREATE TRIGGER tri_clientes_bu 
BEFORE UPDATE ON  clientes  FOR EACH ROW
BEGIN
   DECLARE msg_erro VARCHAR(255);
   
   IF (NEW.email IS NOT NULL) and (valida_email(NEW.email) = '1') THEN
	 SET msg_erro = "FORMATO DO EMAIL INCORRETO";
	 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg_erro;
   END IF;
    
   SET NEW.ultima_alteracao = now(); 
END;;
DELIMITER ;


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
                            -- [EXERCÍCIO 09 ] --
---------------------------------------------------------------------------------
-- INICIO VIEW JOB PROCEDURE 
-- view materializada
-- Uma solução para view materializada no mysql 

create table relatorio_vendedores as (
   SELECT vendedores.nome         'VENDEDOR  ', 
          COUNT(vendas.id)        'QUANTIDADE DE VENDAS',
		  SUM(vendas.valor_venda) 'TOTAL R$ VENDAS', 
          vendedores.comissao     'COMISSAO %', 
		  SUM(valor_comissao)     'COMISSÃO TOTAL', 
		  AVG(vendas.valor_venda) 'TOTAL R$ MÉDIO DAS VENDAS',
		  MAX(vendas.valor_venda) 'MAIOR VENDA',
		  MIN(vendas.valor_venda) 'MENOR VENDA'
     FROM vendedores, comissoes, vendas
    WHERE vendedores.id = comissoes.vendedor_id
      AND comissoes.venda_id = vendas.id
      AND vendedores.id = vendas.vendedor_id
 GROUP BY comissoes.vendedor_id
 ORDER BY 1); 

-- Criacao de indice para a tabela 
ALTER TABLE relatorio_vendedores ADD UNIQUE 
	  INDEX idx_relatoriovendedor_nome(nome);

-- Criação da view para a tabela do relatorio
CREATE VIEW view_relatorio_vendedores 
    AS (SELECT * FROM relatorio_vendedores);

		  
-- cria uma procedure para atualizar os dados da view com registros criados no dia anterior
DROP PROCEDURE atualiza_relatorio;

DELIMITER $$

CREATE PROCEDURE atualiza_relatorio (
    OUT rv INT
)
BEGIN

  TRUNCATE TABLE relatorio_vendedores;

  INSERT INTO relatorio_vendedores
	   SELECT vendedores.nome         , 
			  COUNT(vendas.id)       ,
			  SUM(vendas.valor_venda)  , 
			  vendedores.comissao     , 
			  SUM(valor_comissao)      , 
			  AVG(vendas.valor_venda)  ,
			  MAX(vendas.valor_venda)  ,
			  MIN(vendas.valor_venda)  
		 FROM vendedores, comissoes, vendas
		WHERE vendedores.id = comissoes.vendedor_id
		  AND comissoes.venda_id = vendas.id
		  AND vendedores.id = vendas.vendedor_id
		  AND DATE(data_criacao) = DATE_SUB(DATE(NOW()), INTERVAL 1 DAY) 
	 GROUP BY comissoes.vendedor_id
	 ORDER BY 1;

  SET rv = 0;
END;
$$

DELIMITER ;

-- habilitando eventos agendados
set global event_scheduler = on;

-- criando um evento agendado (job) para executar a procedure e atualizar a view
-- irá atualizar a view a cada 1 hora

drop event processa_atualizacao_relatorio;

DELIMITER $$
 create event processa_atualizacao_relatorio
	   on schedule every 1 day starts CURRENT_TIMESTAMP 
	   do 
	     begin		           
		   call atualiza_relatorio(@rv);
		 end 
$$
DELIMITER ;

-- /FIM VIEW JOB PROCEDURE 
-------------------------------------------------------------------------------
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
                            -- [EXERCÍCIO 10 ] --
--------------------------------------------------------------------------------- 
-- Os logs são armazenados na tabela padão do MySQL "mysql.general_log".
--

-- Habilitando o log automático
SET GLOBAL general_log = 1;

-- Habilitar log nas tabelas
SET GLOBAL log_output  = 'table';



-- select para consultar o usuário
SELECT USER(),CURRENT_USER();


-- select para consultar o log
SELECT 
    *  
FROM 
    mysql.general_log
WHERE   argument  NOT LIKE '%localhost%' 
    and argument  NOT LIKE '%SET NAMES%' 
    and argument  NOT LIKE '%mysql%'
    and argument  NOT LIKE '%SHOW%' 
    and argument  NOT LIKE '%EVENT_SCHEMA%' 
    and argument  NOT LIKE '%SET%' 
    and argument  NOT LIKE 'SELECT current_user()'
    AND argument  NOT LIKE 'set autocommit=1'
	AND argument  NOT LIKE '%USE%'
    AND argument  NOT LIKE 'SET SQL_SAFE_UPDATES=1'
    AND argument  NOT LIKE 'SELECT CONNECTION_ID()'   
    AND argument  NOT LIKE 'SET CHARACTER SET utf8'  
    AND argument  NOT LIKE 'SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ'
    and argument  <>  ''

	



---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
                            -- [EXERCÍCIO 11 ] --
---------------------------------------------------------------------------------
 
 SELECT    vendedores.nome     ' VENDEDOR   ', 
           vendas.id           ' COD. VENDA ',
		   vendas.valor_venda  ' R$ VENDAS  ', 
           vendedores.comissao ' COMISSAO % ',
		   case
				when status = 'G' then 'Gerada'
				when status = 'P' then 'Paga'
				when status = 'C' then 'Cancelada'
				when status = 'A' then 'Em Análise'
           else 'Não Gerada'
           end as status,
           if(status = 'P', comissoes.data_pagamento, 'não processada') 'Pagamento Comissão', 
		   valor_comissao      'COMISSÃO ', 
           vendas.data_criacao 'DATA VENDA'
     FROM  vendedores, comissoes, vendas
    WHERE  vendedores.id      = comissoes.vendedor_id
      AND  comissoes.venda_id = vendas.id
      AND  vendedores.id      = vendas.vendedor_id
 ORDER BY  1; 

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
                            -- [EXERCÍCIO 12 ] --
---------------------------------------------------------------------------------

  -- Como o MySQL não suporta a criação de tipos de dados, eu fiz esse exercicio inserindo um campo do tipo JSON para armazenar os telefones de um cliente. Também criei uma tabela para inserir os tipos de telefones permitidos serem enseridos nesse campo.

  -- campo que irá armazenar os telefones
  
ALTER TABLE clientes 
        ADD telefone json DEFAULT NULL;

  -- campo que irá guardar o tipo dos telefone adicionados no campo telefone 
  
ALTER TABLE clientes 
        ADD telefonelocais varchar(40) GENERATED ALWAYS 
         AS (json_keys(telefone)) STORED;

  -- tabela para armazenar os tipos de locais do telefone permitidos inserir no campo telefone
  
CREATE TABLE locaistelefone (
  listalocais varchar(40) NOT NULL,
  PRIMARY KEY (listalocais)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
  -- inserts para popular a tabela dos tipos permitidos de locais de telefones  
insert into locaistelefone
values('["celular", "residencia"]');
insert into locaistelefone
values('["celular"]');
insert into locaistelefone
values('["residencia"]');
insert into locaistelefone
values('["trabalho", "celular", "residencia"]');
insert into locaistelefone
values('["trabalho", "celular"]');
insert into locaistelefone
values('["trabalho", "residencia"]');
insert into locaistelefone
values('["trabalho"]');


  -- Foreign Key na coluna 'telefonelocais' para restrigir os tipos de locais
ALTER TABLE clientes 
        ADD FOREIGN KEY (telefonelocais) 
            REFERENCES locaistelefone (listalocais);

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
                            -- [EXERCÍCIO 13 ] --
---------------------------------------------------------------------------------

SET autocommit=0;

CREATE TABLE tabela_cross_join AS (
	SELECT clientes.razao_social, 
		   clientes.telefone, 
		   telefonelocais, 
		   valor_venda,  
		   valor_unitario, 
		   produtos.descricao
	  FROM clientes 
	 CROSS JOIN (locaistelefone) 
	 CROSS JOIN (vendas)
	 CROSS JOIN (itens_vendas)
	 CROSS JOIN (produtos)  
	 CROSS JOIN (tipo_produtos)
	 CROSS JOIN (vendedores)
	 CROSS JOIN (fornecedores)
	 CROSS JOIN (produtos_fornecedores)
	 ORDER BY RAND()
 LIMIT 500000 );
 
 COMMIT;

SET autocommit=1;
 
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
                            -- [EXERCÍCIO 14 ] --
---------------------------------------------------------------------------------
-- Quando você tem uma tabela com muitos registros no MySQL, as buscas podem se
--  tornar extremamente lentas. Uma forma de otimizar a velocidade de suas  
--  buscas pode ser particionar a tabela.
-- Quando uma tabela é particionada, é como se você tivesse várias tabelinhas 
-- menores que, juntas, compõem a tabela completa.

-- Tabela que separa a logistica por região 

CREATE TABLE logistica (
  id                 INT(11)      NOT NULL AUTO_INCREMENT,
  razao_social       VARCHAR(255) NOT NULL,
  email              VARCHAR(255) DEFAULT NULL,
  contato            VARCHAR(255) DEFAULT NULL,
  regiao_atendimento VARCHAR(2)   NOT NULL,
  KEY UK_ID (id)
)
PARTITION BY LIST  COLUMNS(regiao_atendimento) 
(PARTITION regiao_sul VALUES IN ('RS','SC','PR') ,
 PARTITION regiao_sudeste VALUES IN ('SP','RG','MG','ES') ,
 PARTITION regiao_centro_oeste VALUES IN ('MT','MS','GO','DF'),
 PARTITION regiao_norte VALUES IN ('AC','AM','RO','RR','PA','AP','TO') ,
 PARTITION regiao_nordeste VALUES IN ('MA','PI','CE','RN','PB','PE','AL','SE','BA') );

INSERT INTO logistica
VALUES(1, 'LOGISTICA LONDRINA LTDA', 'contato@logldn.com.br', 'Bruna', 'PR');
INSERT INTO logistica
VALUES(2, 'LOGISTICA CURITIBA LTDA', 'contato@logctb.com.br', 'Vitória', 'PR');
INSERT INTO logistica
VALUES(3, 'LOGISTICA MARINGÁ LTDA', 'contato@logmga.com.br', 'Cicinho', 'PR');
INSERT INTO logistica
VALUES(4, 'LOGISTICA FLORIANÓPOLIS LTDA', 'contato@logfrp.com.br', 'Daniel', 'SC');
INSERT INTO logistica
VALUES(5, 'LOGISTICA SÃO PAULO LTDA', 'contato@logsp.com.br', 'Thomas', 'SP');
INSERT INTO logistica
VALUES(6, 'LOGISTICA BELÉM LTDA', 'contato@logpa.com.br', '', 'PA');
INSERT INTO logistica
VALUES(7, 'LOGISTICA RIO DE JANEIRO LTDA', 'contato@logrj.com.br', '', 'RJ');
INSERT INTO logistica
VALUES(8, 'LOGISTICA SALVADOR LTDA', 'contato@logba.com.br', 'Hector', 'BA');
 
	SELECT count(*) FROM logistica WHERE regiao_atendimento in ('PR','SC','SP');
 
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
                            -- [EXERCÍCIO 15 ] --
---------------------------------------------------------------------------------

-- não da para fazer esse paralelismo somente com o mysql 
-- uma alteranativa seria utilizar o lock para otimizar a criação de indice

LOCK TABLE tabela_cross_join WRITE;
ALTER TABLE tabela_cross_join ADD INDEX (valor_unitario, descricao);
UNLOCK TABLE;


--- se fosse no oracle
explain plan for create index tabela_cross_join_idx1 on tabela_cross_join(valor_unitario, descricao) parallel (degree 4);
