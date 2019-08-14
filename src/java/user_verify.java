import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//CURRENT SERVLET REDIRECTS TO HOMEPAGES, OLD "homepage"
@WebServlet("/user_verify")
public class user_verify extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        String uname = request.getParameter("profile_uname");
        if (uname != null && !uname.isEmpty()) {
           RequestDispatcher rd = getServletContext().getRequestDispatcher("/WEB-INF/user_verify.jsp?profile_uname="+uname);
           rd.forward(request, response);           
        }     
    }
}
