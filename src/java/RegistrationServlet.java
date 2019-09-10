import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

@WebServlet(urlPatterns = {"/RegistrationServlet"})
public class RegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public RegistrationServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String uname = request.getParameter("uname");
            String password = request.getParameter("pwd1");
            String password_repeat = request.getParameter("pwd2");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String loc = request.getParameter("loc");
            String country = request.getParameter("country");
            String tin = request.getParameter("tin");
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            Statement st = con.createStatement();

            //username availability checking
            ResultSet res = st.executeQuery("SELECT * FROM Users WHERE uname = '" + uname + "' LIMIT 1");
            if (res.next()) {
                request.getSession().setAttribute("error", "used_uname");
                response.sendRedirect("startpage.jsp");
                return;
            }

            //password equality checking
            if (!password.equals(password_repeat)) {
                request.getSession().setAttribute("error", "wrong_pwd");
                response.sendRedirect("startpage.jsp");
                return;
            }

            MessageDigest mdAlgorithm = MessageDigest.getInstance("MD5");
            mdAlgorithm.update(password.getBytes());
            byte[] digest = mdAlgorithm.digest();
            StringBuilder hashedpasswd = new StringBuilder();
            for (int i = 0; i < digest.length; i++) {
                password = Integer.toHexString(0xFF & digest[i]);
                if (password.length() < 2) {
                    password = "0" + password;
                }
                hashedpasswd.append(password);
            }

            //update database
            int i = st.executeUpdate("insert into Users (uname, password, fname, lname, email, phone, address, tin) values ('" + uname + "', '" + hashedpasswd.toString() + "', '" + fname + "', '" + lname + "', '" + email + "', '" + phone + "', '" + loc + ' ' + country + "', '" + tin + "')");
            i = st.executeUpdate("insert into bidder (user_id, location, country) values ('" + uname + "', '" + loc + "', '" + country + "')");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/verify_wait.html");
            dispatcher.forward(request, response);
        } catch (ClassNotFoundException | SQLException | NoSuchAlgorithmException ex) {
            Logger.getLogger(RegistrationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
