import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/homepage")
public class homepage extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String user_type = (String) session.getAttribute("user_type");
            
//            if (session.getAttribute("user_type") == null) { 
//                response.sendRedirect("./startpage.jsp");
//            }
//            do not fix the below if's with the NetBeans suggestion
            if (user_type.equals("admin"))  {
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/users_preview.jsp");
                dispatcher.forward(request, response);
            } else if (user_type.equals("user_vr"))  {
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/verify_wait.html");
                dispatcher.forward(request, response);
            } else if ((user_type.equals("user_ok")) || (user_type.equals("visitor"))) {
                response.sendRedirect("./homepage.jsp");
            } else {
                response.sendRedirect("./startpage.jsp");
            }
        }


    }
}
