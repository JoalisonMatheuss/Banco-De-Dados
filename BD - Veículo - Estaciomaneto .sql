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

    cor varchar(20)

);



create table Patio(

    num integer PRIMARY KEY,

    ender varchar(40),

    capacidade integer

);


create table Estaciona(

    cod integer PRIMARY KEY,

    patio_num integer REFERENCES Patio,

    veiculo_placa varchar(8) REFERENCES Veiculo,

    dtEntrada varchar(10),

    dtSaida varchar(10),

    hsEntrada varchar(10),

    hsSaida varchar(10)

);



insert into Cliente

Values(10187300445,'Jooj',10/03/2002);



insert into Modelo

values(023, 'Up');



insert into Veiculo

values('QJH-1234',023,10187300445,'Vermelho');



insert into Patio

values(1,'Terrio',5);



insert into Estaciona

values(01, 1, 'QJH-1234', '25/04/2019', '25/04/2019', '12:00','00:00');



select *from Cliente;

select *from Modelo;

select *from Veiculo;

select *from Patio;

select *from Estaciona