**Schema (PostgreSQL v18)**

    --empregado
    CREATE TABLE empregado (
    enome VARCHAR(25),
    cpf CHAR(4),
    endereco VARCHAR(50),
    nasc DATE,
    sexo CHAR(1),
    salario NUMERIC(10, 2),
    chefe VARCHAR(4),
    cdep INTEGER
    );
    INSERT INTO empregado (enome, cpf, endereco, nasc, sexo, salario, chefe, cdep)
    
    VALUES
    ('chiquin', '1234', 'rua 1, 1', '1962-02-02', 'M', 10000.00, '8765', 3),
    ('helenita', '4321', 'rua 2, 2', '1963-03-03', 'F', 12000.00, '6543', 2),
    ('pedrin', '5678', 'rua 3, 3', '1964-04-04', 'M', 9000.00, '6543', 2),
    ('valtin', '8765', 'rua 4, 4', '1965-05-05', 'M', 15000.00, NULL, 4),
    ('zulmira', '3456', 'rua 5, 5', '1966-06-06', 'F', 12000.00, '8765', 3),
    ('zefinha', '6543', 'rua 6, 6', '1967-07-07', 'F', 10000.00, '8765', 2);
    --departamento
    create TABLE departamento (
    dnome VARCHAR(40),
    codigo INTEGER,
    gerente CHAR(4)
    );
    INSERT INTO departamento (dnome, codigo, gerente)
    VALUES
    ('pesquisa', 3, '1234'),
    ('marketing', 2, '6543'),
    ('administração', 4, '8765');
    --projeto
    CREATE TABLE projeto (
    pnome VARCHAR(100),
    pcodigo VARCHAR(10),
    cidade VARCHAR(100),
    cdep INTEGER
    );
    INSERT INTO projeto (pnome, pcodigo, cidade, cdep)
    VALUES
    ('ProdutoA', 'PA', 'Cumbuco', 3),
    ('ProdutoB', 'PB', 'Icapui', 3),
    ('Informatização', 'Inf', 'Fortaleza', 4),
    ('Divulgação', 'Div', 'Morro Branco', 2);
    
    --tarefas
    CREATE TABLE tarefas (
    cpf VARCHAR(4),
    pcodigo VARCHAR(10),
    horas INTEGER
    );
    INSERT INTO tarefas (cpf, pcodigo, horas)
    
    VALUES
    ('1234', 'PA', 30.0),
    ('1234', 'PB', 10.0),
    ('4321', 'PA', 5.0),
    ('4321', 'Div', 35.0),
    ('5678', 'Div', 40.0),
    ('8765', 'Inf', 32.0),
    ('8765', 'Div', 8.0),
    ('3456', 'PA', 10.0),
    ('3456', 'PB', 25.0),
    ('3456', 'Div', 5.0),
    ('6543', 'PB', 40.0);
    --dunidade
    CREATE TABLE dunidade(
    dcodigo INTEGER,
    dcidade VARCHAR(50)
    );
    INSERT INTO dunidade (dcodigo, dcidade)
    VALUES
    (2, 'Morro Branco'),
    (3, 'Cumbuco'),
    (3, 'Prainha'),
    (3, 'Taiba'),
    (3, 'Icapui'),
    (4, 'Fortaleza');
    
    

---

**Query #1**

    -- Recupere o nome e o salário de todos os empregados
    select enome, salario
    FROM empregado;

| enome    | salario  |
| -------- | -------- |
| chiquin  | 10000.00 |
| helenita | 12000.00 |
| pedrin   | 9000.00  |
| valtin   | 15000.00 |
| zulmira  | 12000.00 |
| zefinha  | 10000.00 |

---
**Query #2**

    -- Recupere o nome e o salário de todos os empregados do sexo feminino.
    select enome, salario
    FROM empregado
    WHERE sexo = 'F';

| enome    | salario  |
| -------- | -------- |
| helenita | 12000.00 |
| zulmira  | 12000.00 |
| zefinha  | 10000.00 |

---
**Query #3**

    -- Recupere o nome e o salário de todos os empregados do sexo feminino e que ganham salário maior que R$ 10.000,00.
    select enome, salario
    FROM empregado
    WHERE sexo = 'F' and salario > 10000;

| enome    | salario  |
| -------- | -------- |
| helenita | 12000.00 |
| zulmira  | 12000.00 |

---
**Query #4**

    -- Recupere a quantidade de empregados.
    select COUNT(*) as quantidade_empregados
    from empregado;

| quantidade_empregados |
| --------------------- |
| 6                     |

---
**Query #5**

    -- Recupere o maior salário, o menor salário e a média salarial da empresa.
    select MAX(salario), min(salario), avg(salario)
    from empregado;

| max      | min     | avg                    |
| -------- | ------- | ---------------------- |
| 15000.00 | 9000.00 | 11333.3333333333333333 |

---
**Query #6**

    -- Recupere o nome e o salário de todos os empregados que trabalham em Marketing 
    SELECT enome, salario
    from empregado, departamento
    WHERE cdep=codigo and dnome = 'marketing';

| enome    | salario  |
| -------- | -------- |
| helenita | 12000.00 |
| pedrin   | 9000.00  |
| zefinha  | 10000.00 |

---
**Query #7**

    -- recupere o CPF dos empregados que possuem alguma tarefa.
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
**Query #8**

    -- Recupere o CPF dos empregados que não possuem alguma tarefa.
    SELECT DISTINCT e.cpf
    from empregado e
    where e.cpf not in (SELECT f.cpf from tarefas f);

There are no results to be displayed.

---
**Query #9**

    -- Recupere o nome dos empregados que possuem alguma tarefa. 
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
