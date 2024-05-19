<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Livros</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f0f0f0;
        }
        .container {
            text-align: center;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
        }
        h1 {
            margin-bottom: 20px;
            color: #333;
            font-size: 2em;
        }
        .search-bar {
            margin-bottom: 20px;
        }
        .search-bar input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }
        .book-list {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        .book-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
            font-size: 1.2em;
            color: #666;
        }
        .book-item:last-child {
            border-bottom: none;
        }
        a {
            color: #333;
            text-decoration: none;
        }
        a:hover {
            color: #666;
        }
    </style>
</head>
<body>
    
    <div class="container">
        <h1>Catálogo de Livros</h1>
        
        <div class="search-bar">
            <label for="search">Pesquisar livros pelo título:</label>
            <input type="text" id="search" name="search" onkeyup="filterBooks()" placeholder="Digite o título do livro">
        </div>

        <ul id="book-list" class="book-list">
            <li class="book-item">Livro 1: Título do Livro</li>
            <li class="book-item">Livro 2: Outro Título</li>
            <li class="book-item">Livro 3: Mais um Título</li>
        </ul>
    </div>
    <br>
    <div>
       <button><a href="login.jsp">Ir para página de login</a></button>
    </div>
    
</body>
</html>
