

**Recupere o nome e o salário de todos os empregados
    select enome, salario
    FROM empregado**

| enome    | salario  |
| -------- | -------- |
| chiquin  | 10000.00 |
| helenita | 12000.00 |
| pedrin   | 9000.00  |
| valtin   | 15000.00 |
| zulmira  | 12000.00 |
| zefinha  | 10000.00 |

---
**Recupere o nome e o salário de todos os empregados do sexo feminino.
    select enome, salario
    FROM empregado
    WHERE sexo = 'F'**

| enome    | salario  |
| -------- | -------- |
| helenita | 12000.00 |
| zulmira  | 12000.00 |
| zefinha  | 10000.00 |

---
**Recupere o nome e o salário de todos os empregados do sexo feminino e que ganham salário maior que R$ 10.000,00.**
    select enome, salario
    FROM empregado
    WHERE sexo = 'F' and salario > 10000;

| enome    | salario  |
| -------- | -------- |
| helenita | 12000.00 |
| zulmira  | 12000.00 |

---
**Recupere a quantidade de empregados.**
    select COUNT(*) as quantidade_empregados
    from empregado

| quantidade_empregados |
| --------------------- |
| 6                     |

---
**Recupere o maior salário, o menor salário e a média salarial da empresa.**
    select MAX(salario), min(salario), avg(salario)
    from empregado;

| max      | min     | avg                    |
| -------- | ------- | ---------------------- |
| 15000.00 | 9000.00 | 11333.3333333333333333 |

---
**Recupere o nome e o salário de todos os empregados que trabalham em Marketing** 
    SELECT enome, salario
    from empregado, departamento
    WHERE cdep=codigo and dnome = 'marketing';

| enome    | salario  |
| -------- | -------- |
| helenita | 12000.00 |
| pedrin   | 9000.00  |
| zefinha  | 10000.00 |

---
**recupere o CPF dos empregados que possuem alguma tarefa.**
    SELECT DISTINCT e.cpf
    from empregado e, tarefas f
    where e.cpf = f.cpf;

| cpf  |
| ---- |
| 1234 |
| 6543 |
| 3456 |
| 5678 |
| 4321 |
| 8765 |

---
**Recupere o CPF dos empregados que não possuem alguma tarefa.**
    SELECT DISTINCT e.cpf
    from empregado e
    where e.cpf not in (SELECT f.cpf from tarefas f);

There are no results to be displayed.

---
**Recupere o nome dos empregados que possuem alguma tarefa.** 
    select DISTINCT enome
    from empregado e, tarefas tf
    where e.cpf = tf.cpf;

| enome    |
| -------- |
| zefinha  |
| zulmira  |
| pedrin   |
| helenita |
| valtin   |
| chiquin  |

---
**Query #10**

    -- Recupere o nome dos empregados que não possuem tarefa.
    SELECT DISTINCT enome
    from empregado e
    where e.cpf not in (SELECT f.cpf from tarefas f);

There are no results to be displayed.

---
**Query #11**

    -- Recupre o CPF dos empregados que possuem pelo menos uma tarefa com mais de 30 horas.
    select e.cpf
    from empregado e, tarefas tf
    where e.cpf=tf.cpf and horas > 30;

| cpf  |
| ---- |
| 4321 |
| 5678 |
| 8765 |
| 6543 |

---
**Query #12**

    -- Recupre o nome dos empregados que possuem pelo menos uma tarefa com mais de 30 horas.
    select e.enome
    from empregado e, tarefas tf
    where e.cpf=tf.cpf and horas > 30;

| enome    |
| -------- |
| helenita |
| pedrin   |
| valtin   |
| zefinha  |

---
**Query #13**

    -- Recupere para cada departamento o seu nome e o nome do seu gerente
    select dnome, enome as gerente_nome
    from departamento d, empregado e 
    where cpf = gerente;

| dnome         | gerente_nome |
| ------------- | ------------ |
| pesquisa      | chiquin      |
| marketing     | zefinha      |
| administração | valtin       |

---
**Query #14**

    -- Recupere o CPF de todos os empregados que trabalham em Pesquisa ou que diretamente gerenciam um empregado que trabalha em Pesquisa.
    select e.cpf
    FROM empregado e, departamento d 
    where (cdep=d.codigo and dnome= 'pesquisa') OR (cpf = gerente AND dnome='pesquisa');

| cpf  |
| ---- |
| 1234 |
| 3456 |

---
**Query #15**

    -- Recupere o nome e a cidade dos projetos que envolvem (contêm) pelo menos um empregado que trabalha mais de 30 horas nesse projeto.
    SELECT DISTINCT pnome, cidade
    FROM projeto pp, tarefas tf
    WHERE pp.pcodigo = tf.pcodigo AND horas>30;

| pnome          | cidade       |
| -------------- | ------------ |
| Divulgação     | Morro Branco |
| Informatização | Fortaleza    |
| ProdutoB       | Icapui       |

---
**Query #16**

    -- Recupere o nome e a data de nascimento dos gerentes de cada departamento. 
    SELECT enome, nasc
    FROM empregado e, departamento d
    where gerente=cpf;

| enome   | nasc       |
| ------- | ---------- |
| chiquin | 1962-02-02 |
| zefinha | 1967-07-07 |
| valtin  | 1965-05-05 |

---
**Query #17**

    --Recupere o nome e o endereço de todos os empregados que trabalham para o departamento “Pesquisa”.
    SELECT enome, endereco
    FROM empregado e, departamento d
    where cdep=d.codigo and dnome='pesquisa';

| enome   | endereco |
| ------- | -------- |
| chiquin | rua 1, 1 |
| zulmira | rua 5, 5 |

---
**Query #18**

    -- Para cada projeto localizado em Icapuí, recupere o código do projeto, o nome do departamento que o controla e o nome do seu gerente.
    SELECT pcodigo, dnome, enome as gerente_nome
    from projeto pp, empregado e, departamento d
    where cidade='Icapui'  AND pp.cdep = d.codigo and gerente= cpf;

| pcodigo | dnome    | gerente_nome |
| ------- | -------- | ------------ |
| PB      | pesquisa | chiquin      |

---
**Query #19**

    -- Recupere o nome e o sexo dos empregados que são gerentes. 
    SELECT enome, sexo
    from empregado, departamento
    where cpf = gerente;

| enome   | sexo |
| ------- | ---- |
| chiquin | M    |
| zefinha | F    |
| valtin  | M    |

---
**Query #20**

    -- Recupere o nome e o sexo dos empregados que não são gerentes. 
    SELECT enome, sexo
    from empregado
    where cpf not in (SELECT gerente from departamento)

| enome    | sexo |
| -------- | ---- |
| helenita | F    |
| pedrin   | M    |
| zulmira  | F    |

---

[View on DB Fiddle](https://www.db-fiddle.com/)
