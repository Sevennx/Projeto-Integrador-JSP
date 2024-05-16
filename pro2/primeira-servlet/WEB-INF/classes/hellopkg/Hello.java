package hellopkg;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Hello extends HttpServlet {
    
    public void doGet(
        HttpServletRequest requisicao,
        HttpServletResponse resposta)
        throws ServletException,
        IOException {
            PrintWriter out;
            resposta.setContentType("text/html");

            HttpSession sessao = requisicao.getSession();

            String nome = "Ana";
            String mail = "Ana@mail.com";
            sessao.setAttribute("Usuário", nome);
            sessao.setAttribute("Perfil", "Administrador");
            sessao.setAttribute("E-mail", mail );

            out = resposta.getWriter();
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Olá!</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h2>Servlet olá mundo!</h2>");
            if (sessao.isNew()) {
                out.println("<h2>Sessão de usuário é nova!</h2>");
            } else {
                out.println("<h2>Sessão de usuário já existente!</h2>");
            }
            out.println("<p>Sessão: " + sessao.getValue("Perfil") + "</p>");
            out.println("<p>Sessão: " + sessao.getValue("E-mail") + "</p>");
            out.println("</body>");
            out.println("</html>");
    }

}