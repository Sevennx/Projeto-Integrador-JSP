<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adicionar Nova Editora</title>
    <style>
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
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .container-msg{
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        
        h1 {
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            margin-bottom: 5px;
            text-align: left;
            color: #555;
        }
        .form-group input {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<%
    // Verifica se os parâmetros foram enviados
    String nome = request.getParameter("nome");
    String cidade = request.getParameter("cidade");

    if (nome != null && cidade != null) {
        // Dados do banco de dados
        String url = "jdbc:mysql://localhost:3306/livraria";
        String username = "root"; // substitua pelo seu usuário do banco de dados
        String password = ""; // substitua pela sua senha do banco de dados

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Utilize o driver atualizado
            conn = DriverManager.getConnection(url, username, password);

            String sql = "INSERT INTO editora (nome, cidade) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nome);
            pstmt.setString(2, cidade);
            pstmt.executeUpdate();
            
            out.println ("<div class='container-msg'><h1>Nova Editora Adicionada com Sucesso!</h1></div>");
    
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<h1>Erro ao adicionar a editora: " + e.getMessage() + "</h1>");
            out.println("<a href='admin.html'>Voltar ao Admin</a>");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<h1>Erro ao carregar o driver JDBC: " + e.getMessage() + "</h1>");
            out.println("<a href='admin.html'>Voltar ao Admin</a>");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

    <div class="container">
        <h1>Adicionar Nova Editora</h1>
        
        <form class="form-group" action="addEditora.jsp" method="POST">
            <label for="nome">Nome da Editora:</label>
            <input type="text" id="nome" name="nome" required>
            
            <label for="cidade">Cidade:</label>
            <input type="text" id="cidade" name="cidade" required>
            
            <button type="submit">Adicionar Editora</button>
        </form><br>
        <a href="admin.html">Sair</a>
    </div>
   
</body>
</html>
