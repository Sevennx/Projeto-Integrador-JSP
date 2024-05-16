<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="ISO-8859-1" %>

<%@ page import="java.sql.*" %>

<html>
<head></head>
<body>
    <%
    
        String sql = "" +
            "INSERT INTO tb_agenda " +
                "(nome, sobre) " +
                "values (?,?)";

        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            
            // Dados de conexão com o banco
            String banco = "test";
            String usuario = "caio";
            String senha = "123";

            String configServer = "?&serverTimezone=UTC";
            String servidor = "jdbc:mysql://localhost:3306/";
            String conexao = servidor + banco + configServer;

            Connection conn = DriverManager.getConnection(
                conexao, usuario, senha); // Conectar

            // Executa SQL
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1,"Ana");
            ps.setString(2,"Silva");

            ps.execute();
    %>
        <p>Campo inserido!</p>
    <%
                conn.close(); // Fechar conexão
        } catch (Exception e) {
    %>
            <p>Erro! (<%= e%>) <br>  <%= sql %>  </p>
    <%
        }
    %>
</body>
</html>