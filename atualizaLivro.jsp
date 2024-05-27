<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    String url = "jdbc:mysql://localhost:3306/livraria";
    String username = "root";
    String password = "";

    int id = Integer.parseInt(request.getParameter("id"));
    String titulo = request.getParameter("titulo");
    String autor = request.getParameter("autor");
    int ano = Integer.parseInt(request.getParameter("ano"));
    double preco = Double.parseDouble(request.getParameter("preco"));
    String foto = request.getParameter("foto");
    int idEditora = Integer.parseInt(request.getParameter("editora"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Estabelecer a conexão com o banco de dados
        conn = DriverManager.getConnection(url, username, password);

        // Preparar a consulta SQL para atualizar o livro
        String sql = "UPDATE livro SET titulo=?, autor=?, ano=?, preco=?, foto=?, idEditora=? WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, titulo);
        pstmt.setString(2, autor);
        pstmt.setInt(3, ano);
        pstmt.setDouble(4, preco);
        pstmt.setString(5, foto);
        pstmt.setInt(6, idEditora);
        pstmt.setInt(7, id);

        // Executar a consulta
        int rowsUpdated = pstmt.executeUpdate();

        if (rowsUpdated > 0) {
            // Redirecionar de volta para a página de edição com mensagem de sucesso
            response.sendRedirect("editarLivro.jsp?id=" + id + "&success=true");
        } else {
            // Redirecionar de volta para a página de edição com mensagem de erro
            response.sendRedirect("editarLivro.jsp?id=" + id + "&success=false");
        }
    } catch (SQLException e) {
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
%>
