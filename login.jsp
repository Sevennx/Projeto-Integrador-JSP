<%@ page language="java" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
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
            max-width: 400px;
            width: 100%;
        }
        h1 {
            margin-bottom: 20px;
            color: #333;
            font-size: 2em;
        }
        .login-form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .login-form input {
            width: 300px;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }
        .login-form button {
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007BFF;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }
        .login-form button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%
        String usuario = request.getParameter("username");
        String senha = request.getParameter("password");

        if (usuario != null && senha != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                String banco = "livraria";
                String configServer = "?&serverTimezone=UTC";
                String servidor = "jdbc:mysql://localhost:3306/";
                String conexao = servidor + banco + configServer;

                Connection conn = DriverManager.getConnection(conexao, "root", "");
                String sql = "SELECT * FROM usuario WHERE nome=? AND senha=?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, usuario);
                pstmt.setString(2, senha);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    HttpSession userSession = request.getSession();
                    userSession.setAttribute("username", usuario);
                    response.sendRedirect("admin.html");
                } else {
                    out.println("<p>Usuário ou senha inválidos!</p>");
                }

                conn.close();
            } catch (Exception e) {
                out.println("<p>Erro! (" + e + ")</p>");
            }
        }
    %>
    
    <div class="container">
        <h1>Login</h1>
        <form class="login-form" method="post">
            <input type="text" id="username" name="username" placeholder="Usuário" required>
            <input type="password" id="password" name="password" placeholder="Senha" required>
            <button type="submit">Entrar</button>
        </form>
    </div>
    <br>
    <div>
        <a href="index.jsp">Voltar para página inicial</a>
    </div>
</body>
</html>
