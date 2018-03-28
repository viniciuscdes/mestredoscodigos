----------------------------------------------------
----------------------------------------------------
-- Perguntas
----------------------------------------------------
----------------------------------------------------

1) Crie um modelo de dados contendo pelo menos 10 tabelas, sendo que pelo menos uma tabela deve conter chave composta; Criar ligações entre as tabelas com relacionamentos MxN e 1xN, mencionando no relacionamento o tipo de tratamento que será tomado quando um registro da tabela mestre for excluido. Mencione tambem no DDL os cuidados tomados com normalização e com a criação de indices;

2) Realize 5 consultas no modelo de dados criado no item 1, realizando pelo menos uma das seguintes operações: Union, Intersect, Minus, e utilizando pelo menos 3 tipos diferentes de joins;

3) Criar uma query hierarquica, ordenando os registros por uma coluna específica;

4) Extrair um relatório do modelo de dados criado no item 1, utilizando 3 funções de agregação diferentes, e filtrando por pelo menos uma função agregadora;

5) Sintetize o relatório criado no item 4 dentro de uma View Materializada;

8) Criar uma função que valide um tipo de dado comparando o formato com uma Expressão Regular; Crie uma trigger que não permita a inserção/alteração do registro com base na validação da função criada;

9) Criar uma JOB que execute diariamente uma procedure que atualize os dados de uma visão materializada com base nas informações do dia anterior;

----
part. II

6) Otimize a consulta do item 4, detalhando as analises do plano de execução inicial e a cada modificação, e utilizando hints caso o banco de dados suportar;

7) Criar um trigger que, ao realizar um INSERT em uma view composta por pelo menos 3 tabelas, realize inserção em uma outra tabela dentro do banco de dados;

10) Crie uma package que armazene as informações do usuário logado, e que registre as operações que o mesmo realizou na sessão;

11) Crie uma query analítica extraindo informações relevantes dentro modelo do criado no item 1;

12) Crie um tipo de dado, composto por pelo menos 2 atributos, e crie o DDL que altere o modelo de dados do item 1 para utiliza-lo;

13) Realize a carga de pelo menos 500.000 registros, utilizando bulk operations, gerando a massa de dados através do cross join entre algumas tabelas do modelo do criado no item 1, utilizando o tipo de dados criado no item 12;

14) Crie uma tabela utilizando particionamento de dados, e explique no DDL a motivação e beneficios do particionamento realizado;

15) Utilize paralelismo para otimizar a criação de um indice na tabela criada no item 13;

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
  id int(11) NOT NULL AUTO_INCREMENT,
  nome_cidade varchar(255) NOT NULL,
  estado_Id int(11) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_cidade_id (id),
  KEY fk_cidade_estado_id_idx (estado_Id),
  CONSTRAINT fk_cidade_estado_id FOREIGN KEY (estado_Id) REFERENCES estados (id) ON DELETE NO ACTION ON UPDATE NO ACTION
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
  data_criacao     datetime     DEFAULT NULL,
  ultima_alteracao datetime     DEFAULT NULL,
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
  data_criacao   datetime DEFAULT NULL,
  ultima_criacao datetime DEFAULT NULL,
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
  email            varchar(100) NOT NULL,
  status           varchar(1) NOT NULL DEFAULT 'A' COMMENT 'A - Ativo / C - Cancelado',
  data_criacao     datetime DEFAULT NULL,
  ultima_alteracao datetime DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_cliente_id (id),
  KEY fk_cliente_categoria_id_idx (categoria_id),
  CONSTRAINT fk_cliente_categoria_id FOREIGN KEY (categoria_id) REFERENCES categorias (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE fornecedores (
  id               int(11)      NOT NULL AUTO_INCREMENT,
  razao_social     varchar(255) NOT NULL,
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
  cpf              varchar(255) NOT NULL,
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
  data_criacao     datetime DEFAULT NULL,
  ultima_alteracao datetime DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY pk_tipoprodutos_id (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela de tipo de produtos';

CREATE TABLE produtos (
  id               int(11) NOT NULL AUTO_INCREMENT,
  descricao        varchar(255) NOT NULL,
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
  fornecedor_id int(11) NOT NULL,
  produto_id    int(11) NOT NULL,
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
  cliente_id       int(11) NOT NULL,
  vendedor_id      int(11) NOT NULL,
  vencimento       date NOT NULL,
  valor_orcamento  double(10,2) DEFAULT NULL,
  valor_desconto   double(10,2) DEFAULT NULL,
  status           varchar(1) DEFAULT 'O' COMMENT 'O - Orcamento / C - Cancelada / V - Venda',
  data_criacao     datetime DEFAULT NULL,
  ultima_alteracao datetime DEFAULT NULL,
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
  data_criacao     datetime DEFAULT NULL,
  ultima_alteracao datetime DEFAULT NULL,
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
  data_criacao     datetime DEFAULT NULL,
  ultima_alteracao datetime DEFAULT NULL,
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
  ultima_alteracao datetime DEFAULT NULL,
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
--  o padrão utilizado na criação do nomes das triggers foi
--    de colocar o profexo tri_ seguido do nome da tabela e o sufixo _bi ou _bu idicando o evento da trigger
----------------------------------------------------
----------------------------------------------------

DELIMITER ;;
CREATE TRIGGER tri_categorias_bi  
BEFORE INSERT ON  categorias  FOR EACH ROW
BEGIN
	set new.data_criacao = now();
END;;
DELIMITER ;


DELIMITER ;;
CREATE TRIGGER tri_categorias_bu 
BEFORE UPDATE ON  categorias  FOR EACH ROW
BEGIN
	set new.data_criacao = now();
END;;
DELIMITER ;

 

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
	set new.ultima_alteracao = now();
END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_enderecos_bi  
BEFORE INSERT ON  enderecos  FOR EACH ROW
BEGIN
set new.data_criacao = now();
END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_enderecos_bu 
BEFORE UPDATE ON  enderecos  FOR EACH ROW
BEGIN
set new.ultima_alteracao = now();

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
CREATE TRIGGER tri_itensorcamentos_bi  
BEFORE INSERT ON  itens_orcamentos  FOR EACH ROW
BEGIN
set new.data_criacao = now();
 END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_itensorcamentos_bu 
BEFORE UPDATE ON  itens_orcamentos  FOR EACH ROW
BEGIN
 set new.ultima_alteracao = now();
END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_itensvendas_bi  
BEFORE INSERT ON  itens_vendas  FOR EACH ROW
BEGIN
	set new.data_criacao = now();
 END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_itensvendas_bu 
BEFORE UPDATE ON  itens_vendas  FOR EACH ROW
BEGIN
 set new.ultima_alteracao = now();
END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_orcamentos_bi  
BEFORE INSERT ON  orcamentos  FOR EACH ROW
BEGIN
	set new.data_criacao = now();
END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER tri_orcamentos_bu  
BEFORE UPDATE ON  orcamentos  FOR EACH ROW
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
CREATE TRIGGER tri_tipoprodutos_bi  
BEFORE INSERT ON  tipo_produtos  FOR EACH ROW
BEGIN
set new.data_criacao = now();

END;;
DELIMITER ;


DELIMITER ;;
CREATE TRIGGER tri_tipoprodutos_bu  
BEFORE UPDATE ON  tipo_produtos  FOR EACH ROW
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
set new.ultima_alteracao = now();

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
          SUM(valor_comissao)      'COMISSÃO TOTAL'
     FROM vendedores, comissoes, vendas
    WHERE vendedores.id      = comissoes.vendedor_id
      AND comissoes.venda_id = vendas.id
      AND vendedores.id      = vendas.vendedor_id
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
--------------------------------------------------------------------------------- 