CREATE TABLE Equipe(
  IdEquipe INTEGER NOT NULL,
  Nome VARCHAR(60) NOT NULL,
  Estado CHAR(2) NOT NULL,
  Tipo VARCHAR(12) NOT NULL,
  Saldo_gols SMALLINT DEFAULT 0,

  CONSTRAINT equipe_pk PRIMARY KEY(IdEquipe),
  CONSTRAINT equipe_un UNIQUE(Nome),
  CONSTRAINT equipe_ck CHECK(Tipo IN ('Profissional', 'Amador'))
);

CREATE TABLE Joga(
  IdEquipe1 INTEGER NOT NULL,
  IdEquipe2 INTEGER NOT NULL,
  Classico CHAR(5) NOT NULL,

  CONSTRAINT joga_pk PRIMARY KEY(IdEquipe1, IdEquipe2),
  CONSTRAINT joga_fk1 FOREIGN KEY(IdEquipe1) REFERENCES Equipe(IdEquipe) ON DELETE CASCADE,
  CONSTRAINT joga_fk2 FOREIGN KEY(IdEquipe2) REFERENCES Equipe(IdEquipe) ON DELETE CASCADE,
  CONSTRAINT joga_ck CHECK(Classico IN ('TRUE','FALSE'))
);

CREATE TABLE Partida(
  IdEquipe1 INTEGER NOT NULL,
  IdEquipe2 INTEGER NOT NULL,
  Data DATE NOT NULL,
  Gols_Equipe1 SMALLINT DEFAULT 0,
  Gols_Equipe2 SMALLINT DEFAULT 0,
  Local VARCHAR(150),

  CONSTRAINT partifa_pk PRIMARY KEY(IdEquipe1, IdEquipe2, Data),
  CONSTRAINT partida_fk FOREIGN KEY(IdEquipe1, IdEquipe2) REFERENCES Joga(IdEquipe1, IdEquipe2) ON DELETE CASCADE,
  CONSTRAINT partida_ck1 CHECK (Gols_Equipe1 >= 0),
  CONSTRAINT partida_ck2 CHECK (Gols_Equipe2 >= 0)
);

CREATE TABLE Jogador(
  RG NUMERIC(9) NOT NULL,
  Nome VARCHAR(60) NOT NULL,
  Data_nasc DATE NOT NULL,
  Naturalidade VARCHAR(100) DEFAULT 'Sao Paulo',
  IdEquipe INTEGER NOT NULL,

  CONSTRAINT jogadpor_pk PRIMARY KEY(RG),
  CONSTRAINT jogador_un UNIQUE(Nome),
  CONSTRAINT jogador_fk FOREIGN KEY(IdEquipe) REFERENCES Equipe(IdEquipe) ON DELETE CASCADE
);

CREATE TABLE Posicao_jogador(
  Jogador NUMERIC(9) NOT NULL,
  Posicao VARCHAR(60) NOT NULL,

  CONSTRAINT posicao_pk PRIMARY KEY(Jogador,Posicao),
  CONSTRAINT posicao_fk FOREIGN KEY(Jogador) REFERENCES Jogador(RG) ON DELETE CASCADE
);

CREATE TABLE Diretor(
  IdEquipe INTEGER NOT NULL,
  Nome VARCHAR(60) NOT NULL,
  Sobrenome VARCHAR(60) NOT NULL,

  CONSTRAINT diretor_pk PRIMARY KEY(IdEquipe, Nome, Sobrenome),
  CONSTRAINT diretor_fk FOREIGN KEY(IdEquipe) REFERENCES Equipe(IdEquipe) ON DELETE CASCADE
);

CREATE TABLE Uniforme(
 IdUniforme SERIAL NOT NULL,

 IdEquipe INTEGER NOT NULL,
 Tipo CHAR(7) NOT NULL,
 Cor_principal VARCHAR(20) NOT NULL,

 CONSTRAINT uniforme_pk PRIMARY KEY(IdUniforme),
 CONSTRAINT uniforme_un UNIQUE(IdEquipe, Tipo),
 CONSTRAINT uniforme_fk FOREIGN KEY(IdEquipe) REFERENCES Equipe(IdEquipe) ON DELETE CASCADE,
 CONSTRAINT uniforme_ck CHECK(Tipo IN ('Titular','Reserva'))
);


ALTER TABLE uniforme DROP Cor_principal;

CREATE TABLE COR(
  Cor_id SMALLINT,
  Cor_nome VARCHAR(100),

  CONSTRAINT cor_pk PRIMARY KEY(Cor_id),
  CONSTRAINT cor_un UNIQUE(Cor_nome)
);

CREATE TABLE Cores_uniforme(
  IdUniforme INTEGER NOT NULL,
  Cor_id SMALLINT NOT NULL,

  CONSTRAINT cores_uniforme_pk PRIMARY KEY(IdUniforme, Cor_id),
  CONSTRAINT cores_equipe_fk FOREIGN KEY(IdUniforme) REFERENCES Uniforme(IdUniforme) ON DELETE CASCADE,
  CONSTRAINT cores_cor_fk FOREIGN KEY(Cor_id) REFERENCES COR(Cor_id) ON DELETE CASCADE
);




insert into Equipe values (1,'Sao Paulo',     'SP', 'Profissional', 8);
insert into Equipe values (2,'Palmeiras',     'SP', 'Profissional', 5);
insert into Equipe values (3, 'Santos',        'SP', 'Profissional', 0);
insert into Equipe values (4,'Corinthians',   'SP', 'Profissional', 6);
insert into Equipe values (5,'Paulistinha',   'SP', 'Amador',       1);
insert into Equipe values (6,'Ibate',         'SP', 'Amador',       0);
insert into Equipe values (7,'Cruzeiro',      'MG', 'Profissional', 2);
insert into Equipe values (8,'Atletico',      'MG', 'Profissional', 3);
insert into Equipe values (9,'Frutal',        'MG', 'Amador',       1);


insert into joga values (1,   2,   'TRUE');
insert into joga values (6,       5, 'FALSE');
insert into joga values (6,       9,      'TRUE');
insert into joga values (3,      4, 'FALSE');
insert into joga values (4, 2,   'TRUE');
insert into joga values (3,      1,    'FALSE');
insert into joga values (1,   4, 'TRUE');
insert into joga values (3,      2,   'FALSE');



insert into partida values (1, 2,   '15-May-2007',      2,0,'Morumbi');
insert into partida values (3, 1,   '15-May-2007',   1,0, 'Pacaembu');
insert into partida values (3,    2,   '06-jun-2007',0,1, 'Vila Belmiro');
insert into partida (idequipe1, idequipe2, data, local) values (6,     5, '25-May-2007','Luizao');
insert into partida (idequipe1, idequipe2, data, local) values (3,    4, '30-May-2007', 'Pacaembu');

insert into jogador values (111111111, 'Pele',      '01-May-1955', 'Sao Carlos', 3);
insert into jogador values (111111112, 'Garrincha', '01-Dec-1945', 'Sao Paulo', 6);
insert into jogador values (111111113, 'Muller',    '09-Sep-1960', 'Sao Caetano', 1);
insert into jogador values (111111114, 'Zeca',      '09-Sep-1980', 'Pradopolis', 9);
insert into jogador (rg, nome, Data_nasc, idequipe) values (111111115, 'Juca',  '09-Sep-1982', 2);


insert into posicao_jogador values (111111113, 'Atacante');
insert into posicao_jogador values (111111112, 'Zagueiro');
insert into posicao_jogador values (111111111, 'Centroavante');

insert into diretor values (1,   'Joao',    'da Silva');
insert into diretor values(2,   'Jose',    'Souza');
insert into diretor values(4, 'Tome',    'Sauza');
insert into diretor values(6,       'Manuel',  'Carlos');
insert into diretor values(5, 'Joaquim', 'Moura');

insert into uniforme values (DEFAULT, 1,   'Titular');
insert into uniforme values (DEFAULT, 1,   'Reserva');
insert into uniforme values (DEFAULT, 2,   'Titular');
insert into uniforme values (DEFAULT, 2,   'Reserva');
insert into uniforme values (DEFAULT, 4, 'Titular');
insert into uniforme values (DEFAULT, 4, 'Reserva');
insert into uniforme values (DEFAULT, 8, 'Titular');
insert into uniforme values (DEFAULT, 8, 'Reserva');
insert into uniforme values (DEFAULT, 9, 'Titular');
insert into uniforme values (DEFAULT, 9, 'Reserva');

insert into cor values(1,'azul');
insert into cor values(2,'verde');
insert into cor values(3,'vermelho');
insert into cor values(4,'amarelo');
insert into cor values(5,'anil');
insert into cor values(6,'magenta');
insert into cor values(7,'preto');
insert into cor values(8,'branco');

insert into cores_uniforme values(1,1);
insert into cores_uniforme values(1,2);
insert into cores_uniforme values(2,2);
insert into cores_uniforme values(2,3);
insert into cores_uniforme values(3,4);
insert into cores_uniforme values(4,1);
insert into cores_uniforme values(4,5);
insert into cores_uniforme values(5,1);
insert into cores_uniforme values(5,8);
insert into cores_uniforme values(6,7);
insert into cores_uniforme values(7,7);
insert into cores_uniforme values(7,2);
insert into cores_uniforme values(8,7);

/* Questão 7*/
-- a)
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; -- Nao permite leitura suja

SELECT * FROM Jogador j
INNER JOIN Equipe e
on(j.IdEquipe = e.IdEquipe)
where (RG = '111111111');

-- nada foi percebido pela outra transação., sem o COMMIT na transaço 2

COMMIT;

-- Com o COMMIT na transação 1, indicando o fim da transação



-- b)
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; -- Só permite leitura fanstama

SELECT * FROM Jogador j
INNER JOIN Equipe e
on(j.IdEquipe = e.IdEquipe)
where (RG = '111111111');

COMMIT;
-- A sessão 1 foi atualizada, por causa do fim da Transação



/*Questão 8*/
-- a)
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; -- Nao Permite Leitura Suja

SELECT * FROM Equipe;
-- Ao enserir dados na Transação 2 e dá o COMMIT, a Transação 1 vai receber uma nova Equipe
COMMIT;


-- b)
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- Nível máximo de isolamento, não permite nenhum problema de isolamento.

SELECT * FROM Equipe;

COMMIT;


/*Questão 9*/
-- a)
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE Jogador SET IdEquipe = 11 WHERE RG = '111111114';

COMMIT;

-- iv.  agora o que aconteceu na transação 2?
	-- Agora a transação dois 'DESBUGOU', Pode executar novos comandos novamente


-- b)
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE Jogador SET IdEquipe = 9 WHERE RG = '111111115';

COMMIT;

-- IV.  agora o que aconteceu na transação 2?
	-- Agora a transação dois pode executar comando novamente


-- c)
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE Jogador SET IdEquipe = 5 WHERE RG = '111111113';

ROLLBACK;

-- IV.  agora o que aconteceu na transação 2?
	-- Agora a transação dois pode executar comando novamente
