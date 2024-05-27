CREATE DATABASE livraria;
CREATE TABLE editora (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL

);

CREATE TABLE livro (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(120),
    autor VARCHAR(60),
    ano INT,
    preco DOUBLE,
    foto VARCHAR(45),
    idEditora INT,
    FOREIGN KEY (idEditora) REFERENCES editora(id)
);

CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    senha VARCHAR(32)
);

INSERT INTO `usuario`(`nome`, `senha`) VALUES ('admin','321')