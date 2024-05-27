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
    String cidade = request.getParameter("cidade");
    boolean editoraAdicionada = false;

    if (nome != null && cidade != null) {
        String url = "jdbc:mysql://localhost:3306/livraria";
        String username = "root"; 
        String password = ""; 

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            String sql = "INSERT INTO editora (nome, cidade) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nome);
            pstmt.setString(2, cidade);
            pstmt.executeUpdate();
            
            editoraAdicionada = true;
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

    <% if (editoraAdicionada) { %>
        <div class="modal" id="modal">
            <div class="modal-content">
                <h1>Nova Editora Adicionada com Sucesso!</h1>
                <button onclick="closeModal()">OK</button>
            </div>
        </div>
    <% } %>

    <script>
        function closeModal() {
            document.getElementById('modal').style.display = 'none';
            window.location.href = 'addEditora.jsp';
        }

        <% if (editoraAdicionada) { %>
            document.getElementById('modal').style.display = 'flex';
        <% } %>
    </script>
    

</body>
</html>
