create table Ambulatorios(
numero_Amb int PRIMARY KEY,
andar int,
capacidade int
);

create table Medicos(
codigo_medico int PRIMARY KEY,
CPF int,
nome varchar(50),
idade int,
cidade varchar(50),
especialidade varchar(50),
numero_Amb int REFERENCES Ambulatorios(numero_Amb)
);

create table Pacientes(
codigo_paciente int PRIMARY KEY,
CPF int,
nome varchar(50),
idade int,
cidade varchar(50),
doenca varchar(50)
);

create table Consultas(
codigo_medico int REFERENCES Medicos(codigo_medico),
codigo_paciente int REFERENCES Paciente(codigo_paciente),
data_consulta date,
hora_consulta varchar(50)
);


insert into Ambulatorios values(100, 3, 10);
insert into Medicos values(10, 1111, 'Adailton', 19, 'Sape', 'Curar Corações', 100);
insert into Pacientes values(200, 2222, 'Pedro', 17, 1, 'beiras abertas vulgo diarreia');
insert into Consultas values(10, 200, '2020-03-12', '08:02');

create view Consulta_Medico_Pacinte 
as select medico.nome as "nome_medico", paciente.nome as "nome_paciente", consulta.hora_consulta 
from Medicos medico
inner join  Consultas consulta 
on (consulta.codigo_medico = medico.codigo_medico)
inner join Pacientes paciente 
on (consulta.codigo_paciente = paciente.codigo_paciente);


create view Consulta_Ambulatorio_Medico 
as select consulta.hora_consulta, ambulatorio.andar, medico.codigo_medico
from Medicos medico
inner join Ambulatorios ambulatorio
on(medico.codigo_medico = ambulatorio.numero_Amb)
inner join Consultas consulta
on(consulta.codigo_medico = medico.codigo_medico);

create view Medico_Consulta 
as select medico.nome, consulta.data_consulta, consulta.hora_consulta
from Medicos medico
left join Consultas consulta
on (medico.codigo_medico = consulta.codigo_medico);


create view Paciente_Medico_Ambulatorio
as select paci.idade, paci.doenca, med.nome, amb.numero_Amb
from Pacientes paci
inner join Medicos med
on(paci.doenca = med.especialidade)
inner join Ambulatorios amb
on(med.numero_Amb = amb.numero_Amb)