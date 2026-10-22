
-- Recuperar o nome do departamento com maior média salarial
select d.dnome 
from empregado e, departamento d
where d.codigo=e.cdep
group by d.dnome
having avg(salario) >= all (select avg(salario) from empregado  group by cdep);


-- Recuperar para cada departamento: o seu nome, o maior e o menor salário recebido  por empregados do departamento e a média salarial do departamento.
SELECT dnome, max(salario), MIN(salario), avg(salario)
from departamento, empregado
WHERE cdep=codigo
GROUP by dnome;
     
-- Recuperar para cada departamento: o seu nome, o nome do seu gerente, a quantidade de empregados, a quantidade de projetos do departamento e a quantidade de unidades do departamento
SELECT 
    d.DNome AS nome_departamento,
	ga.ENome AS nome_gerente,
    COUNT(DISTINCT e.cpf) AS quantidade_empregados,
    COUNT(DISTINCT pj.pcodigo) AS qtde_projetos,
    COUNT(DISTINCT u.dcodigo) as qtde_uni
FROM 
    departamento d
left JOIN 
    dunidade u oN d.codigo = u.dcodigo    
LEFT JOIN 
    empregado ga ON d.gerente = ga.cpf
    
LEFT JOIN 
    empregado e ON d.codigo = e.cdep
LEFT JOIN 
    projeto pj ON d.codigo = pj.cdep

group by
d.dnome, ga.enome;

-- Recuperar o nome do projeto que consome o maior número de horas.
SELECT
    p.pnome AS projeto
FROM
    projeto p
JOIN
    tarefas t ON p.pcodigo = t.pcodigo
GROUP BY
    p.pnome
ORDER BY
    sum(t.horas) DESC
LIMIT 1;

-- Recuperar o nome do projeto mais caro.
select p.pnome, SUM(salario) AS Maior_Salario
from projeto p, empregado e
where e.cdep = p.cdep
group by p.pnome
Order by Maior_salario DESC
limit 1;


-- Recuperar para cada projeto: o seu nome, o nome gerente do departamento que controla o projeto, a quantidade total de horas alocadas ao projeto, a quantidade de empregados alocados ao projeto e o custo mensal do projeto.
SELECT p.pnome, e.enome as gerente, sum(t.horas) as qtde_horas, 
COUNT (DISTINCT t.cpf) as qtde_empregados, sum(g.salario) as custo_mensal
from projeto p
left JOIN departamento d on p.cdep = d.codigo
left JOIN empregado e on d.gerente = e.cpf
left join tarefas t on t.pcodigo = p.pcodigo
left JOIN empregado g on t.cpf = g.cpf
GROUP by p.pnome, e.enome;

-- Recupere o nome dos gerentes que estão alocados em algum projeto (ou seja, possuem “alguma” tarefa em “algum” projeto). 
SELECT DISTINCT e.enome 
from empregado e 
INNER join departamento d on e.cpf = d.gerente
INNER join projeto p on p.cdep=d.codigo
INNER JOIN tarefas t on t.pcodigo=p.pcodigo;
 

-- Recuperar o nome dos empregados que participam de projetos que não são gerenciados pelo seu departamento. 
SELECT DISTINCT e.enome, codigo, t.cpf, p.pcodigo
from empregado e 
INNER JOIN departamento d on e.cdep=d.codigo
INNER join tarefas t on t.cpf=e.cpf
INNER JOIN projeto p on p.pcodigo=t.pcodigo
WHERE e.cdep!=p.cdep
ORDER by e.enome;

select e.enome AS Nome_empregado
from empregado e
inner join
tarefas t ON e.cpf = t.cpf
inner join
projeto p ON t.pcodigo = p.pcodigo
group by
e.cpf, e.enome
having
COUNT(DISTINCT p.pcodigo) = (select COUNT(*) from projeto);



-- Recuperar para cada funcionário (empregado): o seu nome, o seu salário e o nomedo seu departamento. O resultado deve estar em 
-- ordem decrescente de salário. Mostrar os empregados sem departamento e os departamentos sem empregados.
SELECT e.enome, e.salario, d.dnome
from empregado e
FULL join departamento d on d.codigo=e.cdep
ORDER by e.salario;

-- Recuperar para cada funcionário (empregado): o seu nome, o nome do seu chefe e o nome do gerente do seu departamento.
SELECT DISTINCT e.enome, e2.enome as chefe, e3.enome as gerente
FROM empregado e 
left JOIN empregado e2 on e2.cpf=e.chefe
LEFT JOIN departamento d on e.cdep=d.codigo
LEFT JOIN empregado e3 on e3.cpf=d.gerente;

-- Listar nome dos departamentos com média salarial maior que a média salarial da empresa
SELECT d.dnome, avg(salario)
from departamento d, empregado e 
WHERE e.cdep=d.codigo
GROUP by d.dnome
HAVING avg(salario) > (SELECT AVG(e2.salario) from empregado e2);


-- Listar todos os empregados que possuem salário maior que a média salarial de seus departamentos.
select e.enome AS nome_empregado
from
empregado e
inner join
departamento d ON e.cdep = d.codigo
where
e.salario > (select AVG(salario)
			from empregado e2
			where codigo = e2.cdep);


-- Listar os empregados lotados nos departamentos localizados em “Fortaleza”. 
SELECT DISTINCT e.enome
FROM empregado e
join departamento d on d.codigo=e.cdep
JOIN dunidade u on u.dcodigo=d.codigo 
WHERE u.dcidade='Fortaleza';

-- Listar nome de departamentos com empregados ganhando duas vezes mais que a média do departamento
select e.enome AS nome_empregado
from
empregado e
inner join
departamento d ON e.cdep = d.codigo
where
e.salario > (select AVG(salario)*2
			from empregado e2
			where codigo = e2.cdep);


-- Recuperar o nome dos empregados com salário entre R$ 700 e R$ 2800 
SELECT enome
FROM empregado
WHERE salario BETWEEN 700 and 2800;

-- Recuperar o nome dos departamentos que controlam projetos com mais de 50 empregados e que também controlam projetos com menos de 5 empregados.
SELECT d.dnome, COUNT(t.cpf)
FROM departamento d 
JOIN projeto p on d.codigo=p.cdep
JOIN tarefas t on t.pcodigo=p.pcodigo
GROUP by d.dnome
HAVING count(t.cpf)<5 or COUNT(t.cpf)>50





