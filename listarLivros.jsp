<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*" %>

<%
    // Variáveis para conexão com o banco de dados
    String url = "jdbc:mysql://localhost:3306/livraria";
    String username = "root";
    String password = "";

    // Conexão com o banco de dados
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Estabelecer a conexão com o banco de dados
        conn = DriverManager.getConnection(url, username, password);

        // Consulta SQL para recuperar os livros e suas informações
        String sql = "SELECT l.Id, l.titulo, l.autor, l.ano, l.preco, l.foto, e.nome AS editora_nome " +
                     "FROM livro l INNER JOIN editora e ON l.idEditora = e.id";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Livros</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
        }

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 800px;
            text-align: center;
        }

        h1 {
            margin-bottom: 20px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- Lista de livros -->
    <div class="container">
        <h1>Lista de Livros</h1>
        <table>
            <tr>
                <th>Título</th>
                <th>Autor</th>
                <th>Ano</th>
                <th>Preço</th>
                <th>Editora</th>
                <th>Ação</th>
            </tr>
            <% 
                // Loop através dos resultados da consulta
                while (rs.next()) {
                    int id = rs.getInt("Id");
                    String titulo = rs.getString("titulo");
                    String autor = rs.getString("autor");
                    int ano = rs.getInt("ano");
                    double preco = rs.getDouble("preco");
                    String editora = rs.getString("editora_nome");
            %>
            <tr>
                <td><%= titulo %></td>
                <td><%= autor %></td>
                <td><%= ano %></td>
                <td><%= preco %></td>
                <td><%= editora %></td>
                <td><a href="editarLivro.jsp?id=<%= id %>">Editar</a></td>
            </tr>
            <% 
                }
            %>
        </table>
        <a href="admin.html">voltar</a>
    </div>
</body>
</html>

<%
    // Fechar recursos
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
