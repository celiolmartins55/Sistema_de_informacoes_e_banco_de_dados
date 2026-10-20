-- Recupere o nome e o salário de todos os empregados
select enome, salario
FROM empregado;

-- Recupere o nome e o salário de todos os empregados do sexo feminino.
select enome, salario
FROM empregado
WHERE sexo = 'F';

-- Recupere o nome e o salário de todos os empregados do sexo feminino e que ganham salário maior que R$ 10.000,00.
select enome, salario
FROM empregado
WHERE sexo = 'F' and salario > 10000;

-- Recupere a quantidade de empregados.
select COUNT(*) as quantidade_empregados
from empregado;

-- Recupere o maior salário, o menor salário e a média salarial da empresa.
select MAX(salario), min(salario), avg(salario)
from empregado;

-- Recupere o nome e o salário de todos os empregados que trabalham em Marketing 
SELECT enome, salario
from empregado, departamento
WHERE cdep=codigo and dnome = 'marketing';

-- Recupere o CPF dos empregados que possuem alguma tarefa.
SELECT DISTINCT e.cpf
from empregado e, tarefas f
where e.cpf = f.cpf
8)
-- Recupere o CPF dos empregados que não possuem alguma tarefa.
SELECT DISTINCT e.cpf
from empregado e
where e.cpf not in (SELECT f.cpf from tarefas f)
9)
-- Recupere o nome dos empregados que possuem alguma tarefa. 
select DISTINCT enome
from empregado e, tarefas tf
where e.cpf = tf.cpf;

-- Recupere o nome dos empregados que não possuem tarefa.
SELECT DISTINCT e.nome
from empregado e
where e.cpf not in (SELECT f.cpf from tarefas;

-- Recupre o CPF dos empregados que possuem pelo menos uma tarefa com mais de 30 horas.
select e.cpf
from empregado e, tarefas tf
where e.cpf=tf.cpf and horas > 30;


-- Recupre o nome dos empregados que possuem pelo menos uma tarefa com mais de 30 horas.
select e.enome
from empregado e, tarefas tf
where e.cpf=tf.cpf and horas > 30;

-- Recupere para cada departamento o seu nome e o nome do seu gerente
select dnome, enome as gerente_nome
from departamento d, empregado e 
where cpf = gerente;

-- Recupere o CPF de todos os empregados que trabalham em Pesquisa ou que diretamente gerenciam um empregado que trabalha em Pesquisa.
select e.cpf
FROM empregado e, departamento d 
where (cdep=d.codigo and dnome= 'pesquisa') OR (cpf = gerente AND dnome='pesquisa');

-- Recupere o nome e a cidade dos projetos que envolvem (contêm) pelo menos um empregado que trabalha mais de 30 horas nesse projeto.
SELECT DISTINCT pnome, cidade
FROM projeto pp, tarefas tf
WHERE pp.pcodigo = tf.pcodigo AND horas>30;

-- Recupere o nome e a data de nascimento dos gerentes de cada departamento. 
SELECT enome, nasc
FROM empregado e, departamento d
where gerente=cpf;

--Recupere o nome e o endereço de todos os empregados que trabalham para o departamento “Pesquisa”.
SELECT enome, endereco
FROM empregado e, departamento d
where cdep=d.codigo and dnome='pesquisa';

-- Para cada projeto localizado em Icapuí, recupere o código do projeto, o nome do departamento que o controla e o nome do seu gerente.
SELECT pcodigo, dnome, enome as gerente_nome
from projeto pp, empregado e, departamento d
where cidade='Icapui'  AND pp.cdep = d.codigo and gerente= cpf;

-- Recupere o nome e o sexo dos empregados que são gerentes. 
SELECT enome, sexo
from empregado, departamento
where cpf = gerente;

-- Recupere o nome e o sexo dos empregados que não são gerentes. 
SELECT enome, sexo
from empregado
where cpf not in (SELECT gerente from departamento) 
