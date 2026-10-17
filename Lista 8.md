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

    -- Recupere o nome e o salário de todos os empregados que trabalham em Marketing.
    SELECT enome, salario
    FROM empregado , departamento
    WHERE cdep=codigo and dnome like 'marketing';

| enome    | salario  |
| -------- | -------- |
| helenita | 12000.00 |
| pedrin   | 9000.00  |
| zefinha  | 10000.00 |

---
**Query #2**

    -- Recupere o CPF de todos os empregados que trabalham em Pesquisa ou que diretamente gerenciam um empregado que trabalha em Pesquisa.
    SELECT cpf 
    from empregado, departamento
    where cdep = codigo and dnome = 'pesquisa'
    UNION
    SELECT chefe
    from empregado, departamento
    WHERE cdep=codigo and dnome = 'pesquisa';

| cpf  |
| ---- |
| 1234 |
| 3456 |
| 8765 |

---
**Query #3**

    -- Recupere o nome e a cidade dos projetos que envolvem (contêm) pelo menos um empregado que trabalha mais de 30 horas nesse projeto.
    Select DISTINCT pnome, cidade 
    from projeto, tarefas
    WHERE horas > 30;

| pnome          | cidade       |
| -------------- | ------------ |
| ProdutoA       | Cumbuco      |
| Divulgação     | Morro Branco |
| Informatização | Fortaleza    |
| ProdutoB       | Icapui       |

---
**Query #4**

    -- Recupere o nome e a data de nascimento dos gerentes de cada departamento
    SELECT enome, nasc
    from empregado, departamento
    where gerente=cpf;

| enome   | nasc       |
| ------- | ---------- |
| chiquin | 1962-02-02 |
| zefinha | 1967-07-07 |
| valtin  | 1965-05-05 |

---
**Query #5**

    -- Recupere o nome e o endereço de todos os empregados que trabalham para o departamento “Pesquisa”
    SELECT enome, endereco
    from empregado, departamento
    WHERE cdep = codigo and dnome='pesquisa';

| enome   | endereco |
| ------- | -------- |
| chiquin | rua 1, 1 |
| zulmira | rua 5, 5 |

---
**Query #6**

    -- Para cada projeto localizado em Icapuí, recupere o código do projeto, o nome do departamento que o controla e o nome do seu gerente.
    select projeto.pcodigo as codigo_projeto , departamento.dnome as departamento, empregado.enome AS gerente
    FROM projeto, departamento, empregado
    WHERE projeto.cidade = 'Icapui' and projeto.cdep=departamento.codigo and departamento.gerente = cpf;

| codigo_projeto | departamento | gerente |
| -------------- | ------------ | ------- |
| PB             | pesquisa     | chiquin |

---
**Query #7**

    -- Recupere o nome e o sexo dos empregados que não são gerentes.
    SELECT DISTINCT e.enome, e.sexo
    from empregado e
    where cpf not in (SELECT gerente 
                                  from departamento d)

| enome    | sexo |
| -------- | ---- |
| zulmira  | F    |
| pedrin   | M    |
| helenita | F    |

---

[View on DB Fiddle](https://www.db-fiddle.com/)
