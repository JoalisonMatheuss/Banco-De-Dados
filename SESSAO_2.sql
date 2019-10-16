/*Questão 7*/
--a)

BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE Jogador SET IdEquipe = 6 WHERE RG = '111111111';
-- vi - O que aconteceu? A transação 2 foi atualizada, nada foi percebido pela outra transação.
COMMIT;
--viii - o que aconteceu e por quê? A seção dois foi atualizada, ocorrendo uma leitura não repetivel


-- b)
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

UPDATE Jogador SET IdEquipe = 5 WHERE RG = '111111111';
-- Nao foi atualizado na transição 1, transaçao 2 não encerrada
COMMIT;
-- Não foi atualizado na sessão 1, mesmo depois de encerrada, não ocorre Phantom read



/*Questão 8*/
-- a)
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Equipe VALUES (10,'Flamengo',        'RJ', 'Profissional',       40);
COMMIT;


-- b)
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

INSERT INTO Equipe VALUES (11,'Vasco',        'RJ', 'Profissional',       -10);

COMMIT;



/*Questão 9*/
--a)
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE Jogador SET IdEquipe = 11 WHERE RG = '111111114'
-- iii. O que acontece na transação 2? Porquê?
	-- A transação dois 'BUGOU', ficou impossibilitada de executar novos comandos, ficou em execução até ser executado o COMMIT na transação 1
COMMIT;



-- b)
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE Jogador SET IdEquipe = 9 WHERE RG = '111111115';
--iii. O que acontece na transação 2?
	--a sessao 2 ficou impossibilitada de executar novos comandos, em outras palavras a sessao 2 ficou em execucao ate que fosse executado um commit na sessao 1.
COMMIT;



-- c)
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE Jogador SET IdEquipe = 5 WHERE RG = '111111113';
--iii. O que acontece na transação 2?
	--a sessao 2 ficou impossibilitada de executar novos comandos, em outras palavras a sessao 2 ficou em execucao ate que fosse executado um commit na sessao 1.



