<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Catálogo de Livros</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
        }
        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f0f0f0;
        }
        .container {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 1200px; /* Aumentando a largura máxima */
            width: 100%;
            height: 100%;
            overflow: auto;
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
        .book-item img {
            max-width: 100px;
            max-height: 150px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Catálogo de Livros</h1>

    <div class="search-bar">
        <label for="search">Pesquisar livros pelo título:</label>
        <input type="text" id="search" name="search" placeholder="Digite o título do livro" onkeyup="filterBooks()">
    </div>

    <ul id="book-list" class="book-list">
        <%  
            String url = "jdbc:mysql://localhost:3306/livraria";
            String username = "root";
            String password = "";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                conn = DriverManager.getConnection(url, username, password);
                stmt = conn.createStatement();
                String sql = "SELECT * FROM livro";
                rs = stmt.executeQuery(sql);
                while (rs.next()) {
        %>
                    <li class="book-item">
                        <div class="book-info">
                            <h2>Título: <%= rs.getString("titulo") %></h2>
                            <p>Autor: <%= rs.getString("autor") %></p>
                            <p>Ano de Publicação: <%= rs.getString("ano") %></p>
                            <p>Preço: R$ <%= rs.getDouble("preco") %></p>
                            <%
                                int idEditora = rs.getInt("idEditora");
                                PreparedStatement pstmt = conn.prepareStatement("SELECT nome FROM editora WHERE id = ?");
                                pstmt.setInt(1, idEditora);
                                ResultSet rsEditora = pstmt.executeQuery();
                                if (rsEditora.next()) {
                            %>
                                    <p>Editora: <%= rsEditora.getString("nome") %></p>
                            <%
                                }
                                pstmt.close();
                            %>
                        </div>
                        <div class="book-cover">
                            <img src="capa-livros-img/img.jpg" alt="Capa do Livro">
                        </div>
                    </li>
        <%  
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </ul>

    <br>
    <div>
        <button><a href="login.jsp">Ir para página de login</a></button>
    </div>
</div>

<script>
    function filterBooks() {
        var input, filter, ul, li, h2, i, txtValue;
        input = document.getElementById('search');
        filter = input.value.toUpperCase();
        ul = document.getElementById("book-list");
        li = ul.getElementsByTagName('li');
        for (i = 0; i < li.length; i++) {
            h2 = li[i].getElementsByTagName("h2")[0];
            txtValue = h2.textContent || h2.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                li[i].style.display = "";
            } else {
                li[i].style.display = "none";
            }
        }
    }
</script>

</body>
</html>
