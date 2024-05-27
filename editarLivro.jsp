<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Livro</title>
    <style>
        /* Estilos CSS aqui */
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

        .form-group input, .form-group select {
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

        .message {
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<%
    String url = "jdbc:mysql://localhost:3306/livraria";
    String username = "root";
    String password = "";

    int id = Integer.parseInt(request.getParameter("id")); // Recuperar o ID do livro da URL

    String titulo = "";
    String autor = "";
    int ano = 0;
    double preco = 0.0;
    String foto = "";
    int idEditora = 0;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Estabelecer a conexão com o banco de dados
        conn = DriverManager.getConnection(url, username, password);
        String sql = "SELECT * FROM livro WHERE Id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        // Verificar se o livro foi encontrado
        if (rs.next()) {
            titulo = rs.getString("titulo");
            autor = rs.getString("autor");
            ano = rs.getInt("ano");
            preco = rs.getDouble("preco");
            foto = rs.getString("foto");
            idEditora = rs.getInt("idEditora");
        } else {
            // Se o livro não for encontrado, redirecionar de volta para a página inicial
            response.sendRedirect("listarLivros.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Fechar recursos, como PreparedStatement e Connection
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<div class="container">
    <h1>Editar Livro</h1>
    <%
        String successParam = request.getParameter("success");
        if (successParam != null) {
            boolean success = Boolean.parseBoolean(successParam);
            if (success) {
                out.println("<div class='message success'>Livro editado com sucesso!</div>");
            } else {
                out.println("<div class='message error'>Erro ao editar o livro. Por favor, tente novamente.</div>");
            }
        }
    %>
    <form class="form-group" action="atualizaLivro.jsp" method="POST">
        <input type="hidden" name="id" value="<%= id %>"> <!-- Campo oculto para enviar o ID do livro -->

        <label for="titulo">Título:</label>
        <input type="text" id="titulo" name="titulo" value="<%= titulo %>" required>

        <label for="autor">Autor:</label>
        <input type="text" id="autor" name="autor" value="<%= autor %>" required>

        <label for="ano">Ano de Publicação:</label>
        <input type="number" id="ano" name="ano" value="<%= ano %>" required>

        <label for="preco">Preço:</label>
        <input type="number" step="0.01" id="preco" name="preco" value="<%= preco %>" required>

        <label for="foto">URL da Foto:</label>
        <input type="text" id="foto" name="foto" value="<%= foto %>">

        <label for="editora">Editora:</label>
        <select id="editora" name="editora" required>
            <!-- Adicione as opções dinamicamente -->
            <option value="">Selecione uma Editora</option>
            <%
                try {
                    conn = DriverManager.getConnection(url, username, password);
                    String sqlEditora = "SELECT id, nome FROM editora";
                    pstmt = conn.prepareStatement(sqlEditora);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        int editoraId = rs.getInt("id");
                        String editoraNome = rs.getString("nome");
                        String selected = (editoraId == idEditora) ? "selected" : "";
                        out.println("<option value='" + editoraId + "' " + selected + ">" + editoraNome + "</option>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null)
 conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </select>

        <button type="submit">Salvar Alterações</button>
    </form><br>
    <a href="admin.html">Sair</a>
</div>

</body>
</html>
