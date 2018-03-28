insert into paises(id, nome_pais)
values(1, 'BRASIL');
insert into paises(id, nome_pais)
values(2, 'Estados Unidos);
 

INSERT INTO estados(id, nome_estado, pais_id)
values(1,PARANA,1);
INSERT INTO estados(id, nome_estado, pais_id)
values(2,SÃO PAULO,1);
INSERT INTO estados(id, nome_estado, pais_id)
values(3,BAHIA,1);
INSERT INTO estados(id, nome_estado, pais_id)
values(4,FLORIDA,2);
INSERT INTO estados(id, nome_estado, pais_id)
values(5,MIAMI,2);
INSERT INTO estados(id, nome_estado, pais_id)
values(6,ARIZONA,2);

insert into vendedor(id, nome)
values(1, 'VINICIUS', 5);
insert into vendedor(id, nome)
values(2, 'CARVALHO', 10);
insert into vendedor(id, nome)
values(3, 'THAIS', 10);

insert into tipo_produtos(descricao )
values('ELETRONICOS');
insert into tipo_produtos(descricao )
values('ESCRITORIO');



insert into clientes(id,razao_social, status)
values(1,'VINICIUS LTDA', 'A');
insert into clientes(id, status)
values(2,'CARVALHO LTDA', 'A');

insert into fornecedores(razao_social,status)
values('INFORMATICA LTDA', 'A');
insert into fornecedores(id,razao_social,status)
values('PAPELARIA LTDA', 'A');

insert into produtos(descricao)
values('COMPUTADOR');
insert into produtos(descricao)
values('CELULAR');
insert into produtos(descricao)
values('IMPRESSORA');
insert into produtos(descricao)
values('MONITOR');
insert into produtos(descricao)
values('CADERNO');
insert into produtos(descricao)
values('LAPIS');
insert into produtos(descricao)
values('BORRACHA');
insert into produtos(descricao)
values('CANETA');

INSERT into produtos_fornecedores(fornecedor_id, produto_id, valor, data_vigente)
values(1,1,500, now());
INSERT into produtos_fornecedores(fornecedor_id, produto_id, valor, data_vigente)
values(1,2,400, now());
INSERT into produtos_fornecedores(fornecedor_id, produto_id, valor, data_vigente)
values(1,3,300, now());
INSERT into produtos_fornecedores(fornecedor_id, produto_id, valor, data_vigente)
values(1,4,200, now());
INSERT into produtos_fornecedores(fornecedor_id, produto_id, valor, data_vigente)
values(2,5,50, now());
INSERT into produtos_fornecedores(fornecedor_id, produto_id, valor, data_vigente)
values(2,6,40, now());
INSERT into produtos_fornecedores(fornecedor_id, produto_id, valor, data_vigente)
values(2,7,30, now());
INSERT into produtos_fornecedores(fornecedor_id, produto_id, valor, data_vigente)
values(2,8,20, now());

insert into vendas(cliente_id, vendedor_id,valor_venda, status_entrega)
values(1,3,66,'O');

insert into vendas(cliente_id, vendedor_id,valor_venda, status)
values(1,1,900,'O');
insert into vendas(cliente_id, vendedor_id,valor_venda, status)
values(1,1,500,'O');

insert into vendas(cliente_id, vendedor_id,valor_venda, status)
values(2,2,90,'O');
insert into vendas(cliente_id, vendedor_id,valor_venda, status)
values(2,2,50,'O');

INSERT into itens_vendas(venda_id, fornecedor_id, produto_id, valor_unitario, quantidade)
values(1, 1, 1, 500, 1);
INSERT into itens_vendas(venda_id, fornecedor_id, produto_id, valor_unitario, quantidade)
values(1, 1, 2, 400, 1);

INSERT into itens_vendas(venda_id, fornecedor_id, produto_id, valor_unitario, quantidade)
values(2, 1, 3, 300, 1);
INSERT into itens_vendas(venda_id, fornecedor_id, produto_id, valor_unitario, quantidade)
values(2, 1, 4, 200, 1);

INSERT into itens_vendas(venda_id, fornecedor_id, produto_id, valor_unitario, quantidade)
values(3, 2, 5, 50, 1);
INSERT into itens_vendas(venda_id, fornecedor_id, produto_id, valor_unitario, quantidade)
values(3, 2, 6, 40, 1);

INSERT into itens_vendas(venda_id, fornecedor_id, produto_id, valor_unitario, quantidade)
values(4, 2, 7, 30, 1);
INSERT into itens_vendas(venda_id, fornecedor_id, produto_id, valor_unitario, quantidade)
values(4, 2, 8, 20, 1);


insert into comissoes(venda_id , vendedor_id, valor_comissao,status)
values(1, 1, 45, 'G');
insert into comissoes(venda_id , vendedor_id, valor_comissao,status)
values(2, 1, 25, 'G');

insert into comissoes(venda_id , vendedor_id, valor_comissao,status)
values(3, 2, '4,5', 'G');
insert into comissoes(venda_id , vendedor_id, valor_comissao,status)
values(4, 2, '2,5', 'G');


insert into comissoes(venda_id , vendedor_id, valor_comissao,status)
values(5, 3, '6.6', 'G');