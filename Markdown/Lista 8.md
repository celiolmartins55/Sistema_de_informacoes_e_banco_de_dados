
**Recupere o nome e o salário de todos os empregados que trabalham em Marketing.**

    SELECT enome, salario
    FROM empregado , departamento
    WHERE cdep=codigo and dnome like 'marketing'

| enome    | salario  |
| -------- | -------- |
| helenita | 12000.00 |
| pedrin   | 9000.00  |
| zefinha  | 10000.00 |

---
**Recupere o CPF de todos os empregados que trabalham em Pesquisa ou que diretamente gerenciam um empregado que trabalha em Pesquisa.**
    
    SELECT cpf 
    from empregado, departamento
    where cdep = codigo and dnome = 'pesquisa'
    UNION
    SELECT chefe
    from empregado, departamento
    WHERE cdep=codigo and dnome = 'pesquisa'

| cpf  |
| ---- |
| 1234 |
| 3456 |
| 8765 |

---
**Recupere o nome e a cidade dos projetos que envolvem (contêm) pelo menos um empregado que trabalha mais de 30 horas nesse projeto.**
    
    Select DISTINCT pnome, cidade 
    from projeto, tarefas
    WHERE horas > 30

| pnome          | cidade       |
| -------------- | ------------ |
| ProdutoA       | Cumbuco      |
| Divulgação     | Morro Branco |
| Informatização | Fortaleza    |
| ProdutoB       | Icapui       |

---
**Recupere o nome e a data de nascimento dos gerentes de cada departamento.**
    
    SELECT enome, nasc
    from empregado, departamento
    where gerente=cpf

| enome   | nasc       |
| ------- | ---------- |
| chiquin | 1962-02-02 |
| zefinha | 1967-07-07 |
| valtin  | 1965-05-05 |

---
**Recupere o nome e o endereço de todos os empregados que trabalham para o departamento “Pesquisa”**
    
    SELECT enome, endereco
    from empregado, departamento
    WHERE cdep = codigo and dnome='pesquisa'

| enome   | endereco |
| ------- | -------- |
| chiquin | rua 1, 1 |
| zulmira | rua 5, 5 |

---
**Para cada projeto localizado em Icapuí, recupere o código do projeto, o nome do departamento que o controla e o nome do seu gerente.**
    
    select projeto.pcodigo as codigo_projeto , departamento.dnome as departamento, empregado.enome AS gerente
    FROM projeto, departamento, empregado
    WHERE projeto.cidade = 'Icapui' and projeto.cdep=departamento.codigo and departamento.gerente = cpf

| codigo_projeto | departamento | gerente |
| -------------- | ------------ | ------- |
| PB             | pesquisa     | chiquin |

---
**Recupere o nome e o sexo dos empregados que não são gerentes.**

    SELECT DISTINCT e.enome, e.sexo
    from empregado e
    where cpf not in (SELECT gerente 
                                  from departamento d)

| enome    | sexo |
| -------- | ---- |
| zulmira  | F    |
| pedrin   | M    |
| helenita | F    |



