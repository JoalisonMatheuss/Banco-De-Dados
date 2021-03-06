CREATE TABLE Departamento (
    ID_Depto    NUMERIC(2)      NOT NULL,
    NomeDepto   VARCHAR(30)   NOT NULL,
    ID_Gerente  NUMERIC(4)      NOT NULL,
    CONSTRAINT pk_depto PRIMARY KEY (ID_Depto),
    CONSTRAINT uk_nome UNIQUE (NomeDepto)
);

CREATE TABLE Funcionario (
    ID_Func     NUMERIC(4)     NOT NULL,
    NomeFunc    VARCHAR(30)  NOT NULL,
    Endereco    VARCHAR(50)  NOT NULL,
    DataNasc    DATE          NOT NULL,
    Sexo        CHAR(1)       NOT NULL,
    Salario     NUMERIC(8,2)   NOT NULL,
    ID_Superv   NUMERIC(4)         NULL,
    ID_Depto    NUMERIC(2)     NOT NULL,
    CONSTRAINT pk_func PRIMARY KEY (ID_Func),
    CONSTRAINT ck_sexo CHECK (Sexo='M' or Sexo='F')
);

CREATE TABLE Projeto (
    ID_Proj       NUMERIC(4)     NOT NULL,
    NomeProj      VARCHAR(30)  NOT NULL,
    Localizacao   VARCHAR(30)      NULL,
    ID_Depto      NUMERIC(2)     NOT NULL,
    CONSTRAINT pk_proj PRIMARY KEY (ID_Proj),
    CONSTRAINT uk_nomeProj UNIQUE (NomeProj)
);

CREATE TABLE Dependente (
    ID_Dep       NUMERIC(6)     NOT NULL,
    ID_Func      NUMERIC(4)     NOT NULL,
    NomeDep      VARCHAR(30)  NOT NULL,
    DataNasc     DATE          NOT NULL,
    Sexo         CHAR(1)       NOT NULL,
    Parentesco   CHAR(15)          NULL,
    CONSTRAINT pk_depend PRIMARY KEY (ID_Dep, ID_Func),
    CONSTRAINT ck_sexo_dep CHECK (Sexo='M' or Sexo='F')
);

CREATE TABLE Trabalha (
    ID_Func    NUMERIC(4)     NOT NULL,
    ID_Proj    NUMERIC(4)     NOT NULL,
    NumHoras   NUMERIC(6,1)       NULL,
    CONSTRAINT pk_trab PRIMARY KEY (ID_Func,ID_Proj)
);

INSERT INTO Funcionario
VALUES (1,'Joao Silva','R. Guaicui, 175','01/02/55','M',500,2,1);
INSERT INTO Funcionario
VALUES (2,'Frank Santos','R. Gentios, 22','02/02/66','M',1000,8,1);
INSERT INTO Funcionario
VALUES (3,'Alice Pereira','R. Curitiba, 11','15/05/70','F',700,4,3);
INSERT INTO Funcionario
VALUES (4,'Junia Mendes','R. Espirito Santos, 123','06/07/76','F',1200,8,3);
INSERT INTO Funcionario
VALUES (5,'Jose Tavares','R. Irai, 153','07/10/75','M',1500,2,1);
INSERT INTO Funcionario
VALUES (6,'Luciana Santos','R. Irai, 175','07/10/60','F',600,2,1);
INSERT INTO Funcionario
VALUES (7,'Maria Ramos','R. C. Linhares, 10','01/11/65','F',1000,4,3);
INSERT INTO Funcionario
VALUES (8,'Jaime Mendes','R. Bahia, 111','25/11/60','M',2000,NULL,2);

INSERT INTO Departamento
VALUES (1,'Pesquisa',2);
INSERT INTO Departamento
VALUES (2,'Administracao',8);
INSERT INTO Departamento
VALUES (3,'Construcao',4);

INSERT INTO Dependente
VALUES (1,2,'Luciana','05/11/90','F','Filha');
INSERT INTO Dependente
VALUES (2,2,'Paulo','11/11/92','M','Filho');
INSERT INTO Dependente
VALUES (3,2,'Sandra','05/12/96','F','Filha');
INSERT INTO Dependente
VALUES (4,4,'Mike','05/11/97','M','Filho');
INSERT INTO Dependente
VALUES (5,1,'Max','11/05/79','M','Filho');
INSERT INTO Dependente
VALUES (6,1,'Rita','07/11/85','F','Filha');
INSERT INTO Dependente
VALUES (7,1,'Bety','15/12/60','F','Esposa');

INSERT INTO Projeto
VALUES (1,'ProdX','Savassi',1);
INSERT INTO Projeto
VALUES (2,'ProdY','Luxemburgo',1);
INSERT INTO Projeto
VALUES (3,'ProdZ','Centro',1);
INSERT INTO Projeto
VALUES (10,'Computacao','C. Nova',3);
INSERT INTO Projeto
VALUES (20,'Organizacao','Luxemburgo',2);
INSERT INTO Projeto
VALUES (30,'N. Beneficios','C. Nova',1);

INSERT INTO Trabalha
VALUES (1,1,32.5);
INSERT INTO Trabalha
VALUES (1,2,7.5);
INSERT INTO Trabalha
VALUES (5,3,40.0);
INSERT INTO Trabalha
VALUES (6,1,20.0);
INSERT INTO Trabalha
VALUES (6,2,20.0);
INSERT INTO Trabalha
VALUES (2,2,10.0);
INSERT INTO Trabalha
VALUES (2,3,10.0);
INSERT INTO Trabalha
VALUES (2,10,10.0);
INSERT INTO Trabalha
VALUES (2,20,10.0);
INSERT INTO Trabalha
VALUES (3,30,30.0);
INSERT INTO Trabalha
VALUES (3,10,10.0);
INSERT INTO Trabalha
VALUES (7,10,35.0);
INSERT INTO Trabalha
VALUES (7,30,5.0);
INSERT INTO Trabalha
VALUES (4,20,15.0);
INSERT INTO Trabalha
VALUES (8,20,NULL);

ALTER TABLE Funcionario
ADD CONSTRAINT fk_func_depto FOREIGN KEY (ID_Depto) REFERENCES Departamento (ID_Depto);

ALTER TABLE Funcionario
ADD CONSTRAINT fk_func_superv FOREIGN KEY (ID_Superv) REFERENCES Funcionario (ID_Func);

ALTER TABLE Departamento
ADD CONSTRAINT fk_depto_func FOREIGN KEY (ID_Gerente) REFERENCES Funcionario (ID_Func);

ALTER TABLE Projeto
ADD CONSTRAINT fk_proj_depto FOREIGN KEY (ID_Depto) REFERENCES Departamento (ID_Depto);

ALTER TABLE Dependente
ADD CONSTRAINT fk_dep_func FOREIGN KEY (ID_Func) REFERENCES Funcionario (ID_Func) ON DELETE CASCADE;

ALTER TABLE Trabalha
ADD CONSTRAINT fk_trab_func FOREIGN KEY (ID_Func) REFERENCES Funcionario (ID_Func) ON DELETE CASCADE;

ALTER TABLE Trabalha
ADD CONSTRAINT fk_trab_proj FOREIGN KEY (ID_Proj) REFERENCES Projeto (ID_Proj) ON DELETE CASCADE;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--a)
CREATE VIEW func_dept as
SELECT F.NomeFunc as "Nome Func",F.Endereco as "Endereço" FROM Funcionario F
INNER JOIN Departamento D
on(D.ID_Depto = F.ID_Depto)
where (NomeDepto = 'Pesquisa');
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--b)
CREATE VIEW Func_Supervisor as
SELECT F.NomeFunc as "Nome Func", S.NomeFunc as "Nome Supervisor"  FROM Funcionario F
INNER JOIN Funcionario S
ON(S.ID_Superv = F.ID_Func);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--c)
CREATE VIEW func_salario as
SELECT DISTINCT f.NomeFunc as "Nome Func",f.Salario as "Salario" FROM Funcionario f
where(F.Endereco like'%Irai%');
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--d)
CREATE VIEW func_proj as
SELECT F.ID_Depto"ID Departamento", F.NomeFunc as "Nome do func", (F.Salario*0.10 + F.Salario) as "Salario com aumento" FROM Funcionario F
INNER JOIN Projeto P
ON(F.ID_Depto = P.ID_Depto)
WHERE(P.NomeProj = 'ProdX');
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--e)
CREATE VIEW Func_Dep_Proj as
SELECT F.NomeFunc as "Nome do Func" , D.NomeDepto "Nome do Departamento" , P.NomeProj as "Nome do Projeto" FROM Funcionario F
INNER JOIN Departamento D ON (F.ID_Depto = D.ID_Depto)
INNER JOIN Projeto P ON (P.ID_Depto = D.ID_Depto)
ORDER BY NomeDepto, NomeProj;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--f)
CREATE VIEW Func_Trabalha as
Select distinct F.NomeFunc as "Nome do Povo que trabalha com Joao", T.ID_Proj From Funcionario F
inner join Trabalha T
on(F.ID_Func = T.ID_Func)
where T.ID_Proj
in (Select P.ID_Proj as "ID Projeto" from Projeto P
inner join Funcionario F
on(F.ID_Depto = P.ID_Depto)
where (F.NomeFunc = 'Joao Silva'));
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--g)
CREATE VIEW Func_Dependentee as
select F.ID_Func as "ID Funcionario", F.NomeFunc as "Nome Funcionario", D.NomeDep as "Nome Depedente" from Funcionario F
inner join Dependente D
on(F.ID_Func = D.ID_Func)
where F.ID_Func
in (Select F.ID_Func From Funcionario F
Inner Join Dependente D
on(F.ID_Func = D.ID_Func)
Group by F.ID_Func, F.NomeFunc
Having COUNT(D.ID_Func) > 2
ORDER BY COUNT(D.ID_Func) DESC);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--h)
CREATE VIEW Soma_Media_Maximo_Minimo as
Select SUM(Salario) as "Soma", AVG(Salario) as "Media", Max(Salario) as "Maximo", Min(Salario) as "Minimo" from Funcionario F
inner join Departamento D
on(D.ID_Depto = F.ID_Depto)
where (NomeDepto = 'Pesquisa');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--i)
CREATE VIEW Supervisor as
select S.NomeFunc as "Nome de Supervisores", COUNT(S.NomeFunc) as "Quantidade de Supervisionados" from Funcionario S
inner join Funcionario F
on(F.ID_Func = S.ID_Superv)
Group By S.NomeFunc;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--j)
CREATE VIEW Projeto_Trabalha as
select P.NomeProj as "Nome do Projeto", COUNT(T.ID_Func) as "Quantidade de Funcionarios" From Projeto P
inner join Trabalha T
on(P.ID_Proj = T.ID_Proj)
Group By P.NomeProj;
