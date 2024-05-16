CREATE TABLE editora (
    id INT PRIMARY KEY,
    cidade VARCHAR(45)
);

CREATE TABLE livro (
    Id INT PRIMARY KEY,
    titulo VARCHAR(120),
    autor VARCHAR(60),
    ano INT,
    preco DOUBLE,
    foto VARCHAR(45),
    idEditora INT,
    FOREIGN KEY (idEditora) REFERENCES editora(id)
);

CREATE TABLE usuario (
    id INT PRIMARY KEY,
    nome VARCHAR(45),
    senha VARCHAR(32)
);