<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="ISO-8859-1" %>

<%@ page import="java.sql.*" %>

<html>
<head>
    <style>
    table, tr, th, td {
        border: solid black 1px;
    }
    </style>
</head>
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

            Connection conn = DriverManager.getConnection(
                conexao, usuario, senha); // Conectar

            String sql = "SELECT * FROM tb_agenda";

            // Executa SQL
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet resultado = ps.executeQuery();

            int id;
            String nome, sobrenome;

            out.println("<table>");
            out.println("<tr><th>Nomes</th><th>Sobrenomes</th></tr>");
            while( resultado.next() ) {
                nome = resultado.getString("nome");
                sobrenome = resultado.getString("sobre");
                out.println("<tr><td>"+nome+"</td><td>"+
                sobrenome+"</td></tr>");
            }
            out.println("</table>");

    %>
        <p>Dados exibidos!</p>
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