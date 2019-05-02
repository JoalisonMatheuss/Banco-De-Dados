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
values(1, 'Up'),
(022, 'Gol');

insert into Veiculo
values('QJH-1230',1,10187300445,'Vermelho',2000),
('QJH-1236',022,10187300145,'Vermelho',2001);

insert into Patio
values(1,'Terrio',5),
(2, 'Terrio', 6);

insert into Estaciona
values (0, 1, 'QJH-1230', '25-04-2019', '25-04-2019', '12:00','00:00'),
(1, 2, 'QJH-1236', '25-04-2018', '25-04-2018', '12:00','00:00');

-- QUESTÃO 1)

select v.placa, c.nome 
from  Cliente c
inner join Veiculo v
on (c.cpf = v.Cliente_cpf);

-- QUESTÃO 2)

select c.cpf, c.nome
from Cliente c
inner join Veiculo v
on ( v.placa LIKE '%0') where c.cpf = v.Cliente_cpf;

-- QUESTÃO 3)

select v.placa, v.cor
from Veiculo v
inner join Estaciona e
on(v.placa = e.Veiculo_placa) where e.cod_Estaciona = 1;

-- QUESTÃO 4)

select v.placa, v.ano, m.Desc_2
from Veiculo v
inner join Modelo m 
on (m.codMod = v.modelo_codMod) where v.ano >= 2000;

-- QUESTÃO 5)

select p.ender, e.dtEntrada, e.dtSaida
from Patio p
inner join Estaciona e
on (p.num = e.patio_num)
inner join Veiculo v
on (v.placa = e.veiculo_placa) where v.placa LIKE '%6';

-- QUESTÃO 6)


-- QUESTÃO 7)

select c.nome, v.placa
from Cliente c
inner join Veiculo v 
on ( c.cpf = v.Cliente_cpf)
inner join Modelo m
on (m.codMod = v.modelo_codMod) where m.codMod = 1;

-- QUESTÃO 8)

select v.placa, e.hsEntrada, e.hsSaida
from Veiculo v
inner join Estaciona e
on(v.placa = e.Veiculo_placa) where v.cor = 'Vermelho';

-- QUESTÃO 9)

-- QUESTÃO 10)
select v.placa, c.nome, m.Desc_2
from Cliente c
inner join Veiculo v
on(c.cpf = v.Cliente_cpf)
inner join Modelo m
on(m.codMod = v.modelo_codMod);

