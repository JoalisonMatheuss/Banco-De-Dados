CREATE TABLE Cliente(
CodCliente integer PRIMARY KEY,
Nome varchar(50)
);

CREATE TABLE Comanda(  --Vulgo Venda
 NumComanda integer PRIMARY KEY,
 ValorTotalVenda numeric(11,2),
 CodCliente integer REFERENCES Cliente(CodCliente)
);

CREATE TABLE Produto(
CodProduto integer PRIMARY KEY,
Custo numeric(11,2),
Descricao varchar(150),
Lucro numeric(11,2),
Preco numeric(11,2),
Nome varchar(50)
);


CREATE TABLE Item_Venda(
CodProduto integer REFERENCES Produto(CodProduto),
NumComanda integer REFERENCES Comanda(NumComanda),
ValorUnitario numeric(11,2),
Qtd integer
);

