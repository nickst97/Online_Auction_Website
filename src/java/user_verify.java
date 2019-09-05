
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
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
            try {
                Class.forName("com.mysql.jdbc.Driver");
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                Statement st = con.createStatement();
                st.executeUpdate("UPDATE Users SET verified = 'Y' WHERE uname='" + uname + "'");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/users_preview.jsp");
                dispatcher.forward(request, response);
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(user_verify.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
