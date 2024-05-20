<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Catálogo de Livros</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
        }
        .container {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            width: 100%;
            text-align: center;
        }
        h1 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 1rem;
        }
        .search-bar {
            margin-bottom: 2rem;
        }
        .search-bar label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        .search-bar input {
            width: 100%;
            padding: 0.75rem;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .search-bar input:focus {
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.25);
            outline: none;
        }
        .book-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .book-item {
            background: #f9f9f9;
            padding: 1rem;
            margin: 0.5rem;
            border-radius: 10px;
            border: 1px solid #e0e0e0;
            flex: 1 1 calc(30% - 1rem);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, background 0.3s;
        }
        .book-item:hover {
            transform: translateY(-5px);
            background: #f1f1f1;
        }
        button {
            background: #007bff;
            color: #fff;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 1rem;
            transition: background-color 0.3s;
        }
        button a {
            color: #fff;
            text-decoration: none;
        }
        button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Catálogo de Livros</h1>
        
        <div class="search-bar">
            <label for="search">Pesquisar livros pelo título:</label>
            <input type="text" id="search" name="search" placeholder="Digite o título do livro">
        </div>

        <ul id="book-list" class="book-list">
            <li class="book-item">Livro 1: A Menina que Roubava Livros - Markus Zusak</li>
            <li class="book-item">Livro 2: O Hobbit - J.R.R. Tolkien</li>
            <li class="book-item">Livro 3: 1984 - George Orwell</li>
            <li class="book-item">Livro 4: O Código Da Vinci - Dan Brown</li>
            <li class="book-item">Livro 5: Orgulho e Preconceito - Jane Austen</li>
            <li class="book-item">Livro 6: Cem Anos de Solidão - Gabriel García Márquez</li>
            <li class="book-item">Livro 7: O Pequeno Príncipe - Antoine de Saint-Exupéry</li>
            <li class="book-item">Livro 8: Moby Dick - Herman Melville</li>
            <li class="book-item">Livro 9: Dom Quixote - Miguel de Cervantes</li>
            <li class="book-item">Livro 10: A Guerra dos Tronos - George R.R. Martin</li>
            <li class="book-item">Livro 11: Harry Potter e a Pedra Filosofal - J.K. Rowling</li>
            <li class="book-item">Livro 12: O Senhor dos Anéis: A Sociedade do Anel - J.R.R. Tolkien</li>
            <li class="book-item">Livro 13: O Nome do Vento - Patrick Rothfuss</li>
            <li class="book-item">Livro 14: O Alquimista - Paulo Coelho</li>
            <li class="book-item">Livro 15: As Crônicas de Nárnia - C.S. Lewis</li>
        </ul>
        <br>
        <div>
            <button><a href="login.jsp">Ir para página de login</a></button>
        </div>
    </div>
</body>
</html>
