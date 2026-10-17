-- Recupere o nome e o salário de todos os empregados que trabalham em Marketing.
SELECT enome, salario
FROM empregado , departamento
WHERE cdep=codigo and dnome like 'marketing';

-- Recupere o CPF de todos os empregados que trabalham em Pesquisa ou que diretamente gerenciam um empregado que trabalha em Pesquisa.
SELECT cpf 
from empregado, departamento
where cdep = codigo and dnome = 'pesquisa'
UNION
SELECT chefe
from empregado, departamento
WHERE cdep=codigo and dnome = 'pesquisa';

-- Recupere o nome e a cidade dos projetos que envolvem (contêm) pelo menos um empregado que trabalha mais de 30 horas nesse projeto.
Select DISTINCT pnome, cidade 
from projeto, tarefas
WHERE horas > 30;

-- Recupere o nome e a data de nascimento dos gerentes de cada departamento
SELECT enome, nasc
from empregado, departamento
where gerente=cpf;

-- Recupere o nome e o endereço de todos os empregados que trabalham para o departamento “Pesquisa”
SELECT enome, endereco
from empregado, departamento
WHERE cdep = codigo and dnome='pesquisa';


-- Para cada projeto localizado em Icapuí, recupere o código do projeto, o nome do departamento que o controla e o nome do seu gerente.
select projeto.pcodigo as codigo_projeto , departamento.dnome as departamento, empregado.enome AS gerente
FROM projeto, departamento, empregado
WHERE projeto.cidade = 'Icapui' and projeto.cdep=departamento.codigo and departamento.gerente = cpf;

-- Recupere o nome e o sexo dos empregados que não são gerentes.
SELECT DISTINCT e.enome, e.sexo
from empregado e
where cpf not in (SELECT gerente 
                              from departamento d)





