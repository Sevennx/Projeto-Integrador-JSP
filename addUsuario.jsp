<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*, java.sql.SQLException" %>
<%@ page import="java.sql.DriverManager" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Processamento de Novo Usuário</title>
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
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .modal-content button {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%
        String nome = request.getParameter("nome");
        String senha = request.getParameter("senha");
        boolean usuarioAdicionado = false;

        if (nome != null && senha != null) {
            String url = "jdbc:mysql://localhost:3306/livraria";
            String username = "root"; 
            String password = ""; 

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

                String sql = "INSERT INTO usuario (nome, senha) VALUES (?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, nome);
                pstmt.setString(2, senha);
                pstmt.executeUpdate();
                
                usuarioAdicionado = true;
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
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
        <h1>Processamento de Novo Usuário</h1>
        
        <form class="form-group" action="addUsuario.jsp" method="POST">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" required>
            
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" required>
            
            <button type="submit">Adicionar Usuário</button>
        </form><br>
        <a href="admin.html">Sair</a>
    </div>

    <% if (usuarioAdicionado) { %>
        <div class="modal" id="modal">
            <div class="modal-content">
                <h1>Novo Usuário Adicionado com Sucesso!</h1>
                <button onclick="closeModal()">OK</button>
            </div>
        </div>
    <% } %>

    <script>
        function closeModal() {
            document.getElementById('modal').style.display = 'none';
            window.location.href = 'addUsuario.jsp';
        }

        <% if (usuarioAdicionado) { %>
            document.getElementById('modal').style.display = 'flex';
        <% } %>
    </script>
   
</body>
</html>
