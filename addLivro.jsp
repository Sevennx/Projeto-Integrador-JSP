<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adicionar Novo Livro</title>
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
    String url = "jdbc:mysql://localhost:3306/livraria";
    String username = "root";
    String password = "";

    String titulo = request.getParameter("titulo");
    String autor = request.getParameter("autor");
    String ano = request.getParameter("ano");
    String preco = request.getParameter("preco");
    String foto = request.getParameter("foto");
    String idEditora = request.getParameter("editora");
    boolean livroAdicionado = false;

    if (titulo != null && autor != null && ano != null && preco != null && idEditora != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Estabelecer a conexão com o banco de dados
            conn = DriverManager.getConnection(url, username, password);

            // Preparar a consulta SQL para inserir um novo livro
            String sql = "INSERT INTO livro (titulo, autor, ano, preco, foto, idEditora) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, titulo);
            pstmt.setString(2, autor);
            pstmt.setInt(3, Integer.parseInt(ano));
            pstmt.setDouble(4, Double.parseDouble(preco));
            pstmt.setString(5, foto);
            pstmt.setInt(6, Integer.parseInt(idEditora));
            
            // Executar a consulta
            pstmt.executeUpdate();
            
            // Marcar o livro como adicionado com sucesso
            livroAdicionado = true;
        } catch (SQLException e) {
            // Tratar exceção de SQL
            e.printStackTrace();
        } finally {
            // Fechar recursos, como PreparedStatement e Connection
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
    <h1>Adicionar Novo Livro</h1>
    
    <form class="form-group" action="addLivro.jsp" method="POST">
        <label for="titulo">Título:</label>
        <input type="text" id="titulo" name="titulo" required>
        
        <label for="autor">Autor:</label>
        <input type="text" id="autor" name="autor" required>
        
        <label for="ano">Ano de Publicação:</label>
        <input type="number" id="ano" name="ano" required>
        
        <label for="preco">Preço:</label>
        <input type="number" step="0.01" id="preco" name="preco" required>
        
        <label for="foto">URL da Foto:</label>
        <input type="text" id="foto" name="foto">
        
        <label for="editora">Editora:</label>
        <select id="editora" name="editora" required>
            <!-- Adicione as opções dinamicamente -->
            <option value="">Selecione uma Editora</option>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    // Estabelecer a conexão com o banco de dados
                    conn = DriverManager.getConnection(url, username, password);
                    stmt = conn.createStatement();
                    String sql = "SELECT id, nome FROM editora";
                    rs = stmt.executeQuery(sql);
                    while (rs.next()) {
                        int editoraId = rs.getInt("id");
                        String editoraNome = rs.getString("nome");
                        out.println("<option value='" + editoraId + "'>" + editoraNome + "</option>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    // Fechar recursos, como Statement e Connection
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </select>
        
        <button type="submit">Adicionar Livro</button><br>
        <a href="admin.html">Sair</a>
    </form>
</div>

<% if (livroAdicionado) { %>
    <div class="modal" id="modal">
        <div class="modal-content">
            <h1>Livro Adicionado com Sucesso!</h1>
            <button onclick="closeModal()">OK</button>
        </div>
    </div>
<% } %>

<script>
    function closeModal() {
        document.getElementById('modal').style.display = 'none';
        window.location.href = 'addLivro.jsp';
    }

    <% if (livroAdicionado) { %>
        document.getElementById('modal').style.display = 'flex';
    <% } %>
</script>
   
</body>
</html>
