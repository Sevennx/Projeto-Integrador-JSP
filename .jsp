<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Livro</title>
    <style>
        /* Estilos CSS aqui */
    </style>
</head>
<body>

<%
    // Parâmetros de conexão com o banco de dados
    String url = "jdbc:mysql://localhost:3306/livraria?useUnicode=true&characterEncoding=UTF-8";
    String username = "root";
    String password = "";

    // Conexão com o banco de dados
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Estabelece a conexão com o banco de dados
        conn = DriverManager.getConnection(url, username, password);

        // Consulta SQL para obter a lista de livros disponíveis
        String sqlLivros = "SELECT Id, titulo FROM livro";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sqlLivros);

%>
<div class="container">
    <h1>Editar Livro</h1>
    <form action="editarLivroForm.jsp" method="GET">
        <label for="livro">Selecione o Livro:</label>
        <select id="livro" name="id" required>
            <option value="">Selecione um Livro</option>
            <% 
                // Loop para exibir as opções de livros disponíveis
                while (rs.next()) {
                    int livroId = rs.getInt("Id");
                    String tituloLivro = rs.getString("titulo");
            %>
            <option value="<%= livroId %>"><%= tituloLivro %></option>
            <% } // Fim do loop de livros %>
        </select>
        <button type="submit">Editar Livro</button>
    </form>
</div>
<%
    } catch (SQLException e) {
        // Tratamento de exceção
        e.printStackTrace();
    } finally {
        // Fechamento dos recursos
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
