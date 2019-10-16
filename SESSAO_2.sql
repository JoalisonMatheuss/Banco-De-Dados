-- 7)


BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE Jogador SET IdEquipe = 2 where RG = 111111111;

--o que aconteceu e por quê?  ==> A Sessão dois atualizou os dados da primeira

COMMIT;

--o que aconteceu e por quê?  ==> A Sessão dois atualizou os dados da primeira e foi confirmada na transação.



-- Leitura Fanstama.
BEGIN;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; 

UPDATE Jogador SET IdEquipe = 3 where RG = 111111111;

COMMIT;
------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 8)

-- a)

-- Aqui vai ocorrer uma leitura fantasma na outra sessao, onde ela irá inserir novos elementos
BEGIN;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

insert into Equipe values (12,'Fluminense',      'RJ', 'Profissional', -8);
rollback
COMMIT;




-- b)

-- Aqeui não vai acontecer a leitura fantasma, po SERIALIZABLE leva o isolamento ao maximo.
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

insert into Equipe values (12,'Fluminense',      'RJ', 'Profissional', -8);

COMMIT;
------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- 9)
--a)

BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 

UPDATE Jogador SET IdEquipe = 11 where RG = 111111112;
-- Deu erro na transação 2, buga o Servidor

-- Volta ao normal depois da transacção 1 ser confirmada



--b)
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE Jogador SET IdEquipe = 11 where RG = 111111112;



--c)
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE Jogador SET IdEquipe = 6 where RG = 111111113;
rollback
-- Bugou a transação dois