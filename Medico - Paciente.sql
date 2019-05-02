-- QUESTÃO 1)

create table Medico(
CRM varchar(60) PRIMARY KEY,
nome varchar(60),
especialidade varchar(60)
);

create table SetorMedico(
codSetor integer PRIMARY KEY,
CRM varchar(60) REFERENCES Medico
);


create table Setor(
codSetor integer PRIMARY KEY,
nome varchar(60),
supervisor varchar(60) REFERENCES Medico
);

create table Paciente(
codPaciente integer PRIMARY KEY,
nome varchar(60),
dataNascimento date
);

create table Atendimento(
codAtendimento integer PRIMARY KEY,
data date,
valor integer,
tipo varchar(60),
atendAnterior integer REFERENCES Atendimento,
CRM varchar(60) REFERENCES Medico,
codPaciente integer REFERENCES Paciente
);

create table TelefoneMedico(
telefone integer PRIMARY KEY,
CRM varchar(60) REFERENCES Medico 
);


-- QUESTÃO 2)

insert into Medico 
values('1234', 'João', 'Pediatra'),
('5678', 'Maria', 'Cirugião'),
('9012', 'Carlos', 'dermatologista');

insert into SetorMedico
values(1, '1234'),
(2, '5678'),
(3, '9012');

insert into Setor
values(1, 'pediatria', '1234'),
(2, 'CD', '5678'),
(3, 'Ala de Cirurgia', '9012');

insert into Paciente
values(100, 'Maria', '2002-04-10'),
(200, 'Boaz', '2002-02-01'),
(300, 'Dri', '2001-12-13');

insert into Atendimento
values(001, '2019-02-20',105,'Pediatria', null ,'1234', 100),
(002, '2019-05-09', 80, 'Cirurgico', 001, '5678', 200),
(003, '2019-04-04',90,'Demartologico', 002, '9012', 300);

insert into TelefoneMedico
values(999345678, '1234'),
(999123456, '5678'),
(991123456, '9012');

-- QUESTÃO 3)

SELECT codPaciente from Paciente where nome = 'Maria';

-- QUESTÃO 4)

SELECT CRM, especialidade from Medico where nome = 'João';

-- QUESTÃO 5)

SELECT (valor*0.15)+valor as Novo from Atendimento;

-- QUESTÃO 6)

SELECT m.nome
from Medico m
inner join Setor s
on(m.CRM = s.supervisor) where s.nome = 'pediatria';

-- QUESTÃO 7)

SELECT nome from Setor where supervisor = '9012';

-- QUESTÃO 8)

SELECT telefone from TelefoneMedico where CRM = '1234';


