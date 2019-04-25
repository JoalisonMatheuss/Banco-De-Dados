create table Cliente(

    cpf integer PRIMARY KEY,

    nome varchar(60),

    dtNas date

);

create table Modelo(

    codMod integer PRIMARY KEY,

    Desc_2 varchar(40)

);

create table Veiculo(

    placa varchar(9) PRIMARY KEY,

    modelo_codMod integer REFERENCES Modelo,

    Cliente_cpf integer REFERENCES Cliente,
    
    cor varchar(20),
    
    ano integer 

);

create table Patio(

    num integer PRIMARY KEY,

    ender varchar(40),

    capacidade integer

);

create table Estaciona(

    cod_Estaciona integer PRIMARY KEY,

    patio_num integer REFERENCES Patio,

    veiculo_placa varchar(8) REFERENCES Veiculo,

    dtEntrada date,

    dtSaida date,

    hsEntrada varchar(10),

    hsSaida varchar(10)

);

insert into Cliente

Values (10187300445,'Jooj','10-03-2002'),
(10187300145,'Malaquias','10-03-2005');

insert into Modelo

values(023, 'Up');

insert into Veiculo

values('QJH-1230',023,10187300445,'Vermelho',2000),
('QJH-1236',023,10187300145,'Vermelho',2001);

insert into Patio

values(1,'Terrio',5);

insert into Estaciona

values (0, 1, 'QJH-1230', '25-04-2019', '25-04-2019', '12:00','00:00'),
(1, 2, 'QJH-1236', '25-04-2018', '25-04-2018', '12:00','00:00');

--Questão 1)

select placa, nome from Veiculo, Cliente;

--Questão 2)

select cpf, nome from Cliente, Veiculo where placa LIKE '%0';

-- Questão 3)

select placa, cor from Veiculo, Estaciona where cod_Estaciona = 1;

--Questão 4)

select placa, ano from Veiculo where ano >= 2000;

--Questão 5)

select ender, dtEntrada, dtSaida from Patio, Estaciona, Veiculo where veiculo_placa LIKE  '%6'; 

--Questão 6)

select count(cor) AS 'Qtd de Veiculos de cor verde' from veiculo, Estaciona

--Questão 7)

select *from Veiculo, Modelo where codMod = 1;

--Quesstão 8)

select placa, hsEntrada, hsSaida from Veiculo, Estaciona where cor = 'Vermelho';

--Questão 9)

select count() from 

--Questão 10)

select placa, nome, Desc_2 from Cliente, Veiculo, Modelo;
