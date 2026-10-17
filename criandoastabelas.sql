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
(4, 'Fortaleza')

