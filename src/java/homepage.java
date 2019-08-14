
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//CURRENT SERVLET REDIRECTS TO HOMEPAGES, OLD "homepage"
@WebServlet("/homepage")
public class homepage extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String user_type = (String) session.getAttribute("user_type");
            if (user_type.equals("admin"))  {
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/users_preview.jsp");
                dispatcher.forward(request, response);
            } else if (user_type.equals("user_vr"))  {
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/verify_wait.html");
                dispatcher.forward(request, response);
            } else if ((user_type.equals("user_ok")) || (user_type.equals("visitor"))) {
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/homepage.jsp");
                dispatcher.forward(request, response);
            } else {
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/startpage.jsp");
                dispatcher.forward(request, response);
            }
        }

    }
}
