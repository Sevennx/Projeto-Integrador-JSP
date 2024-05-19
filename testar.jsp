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
            
            String banco = "livraria";
            String usuario = "root";
            String senha = "";

            String configServer = "?&serverTimezone=UTC";
            String servidor = "jdbc:mysql://localhost:3306/";
            String conexao = servidor + banco + configServer;

            Connection conn = DriverManager.getConnection(conexao, usuario, senha);
    %>
        <p>Conectou!</p>
    <%
                conn.close(); 
        } catch (Exception e) {
    %>
            <p>Erro! (<%= e%>)</p>
    <%
        }
    %>
</body>
</html>