<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="ISO-8859-1" %>

<%@ page import="java.sql.*" %>

<html>
<head></head>
<body>
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            
            // Dados de conexão com o banco
            String banco = "test";
            String usuario = "caio";
            String senha = "123";

            String configServer = "?&serverTimezone=UTC";
            String servidor = "jdbc:mysql://localhost:3306/";
            String conexao = servidor + banco + configServer;

            Connection conn = DriverManager.getConnection(conexao, usuario, senha); // Conectar
    %>
        <p>Conectou!</p>
    <%
                conn.close(); // Fechar conexão
        } catch (Exception e) {
    %>
            <p>Erro! (<%= e%>)</p>
    <%
        }
    %>
</body>
</html>