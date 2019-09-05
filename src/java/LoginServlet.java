import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.http.*;
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

@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try {
            String v_flag = request.getParameter("visitor_flag");
            if (v_flag != null && !v_flag.isEmpty()) {
                if (v_flag.equals("Y")) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user_type", "visitor");
                    response.sendRedirect("homepage");
                }
            } else {
                String uname = request.getParameter("usr");
                String pwd = request.getParameter("pwd");
                Class.forName("com.mysql.jdbc.Driver");
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from Users where uname='" + uname + "'");
                if (rs.next()) {
                    //coding the password
                    MessageDigest mdAlgorithm = MessageDigest.getInstance("MD5");
                    mdAlgorithm.update(pwd.getBytes());
                    byte[] digest = mdAlgorithm.digest();
                    StringBuilder hashedpasswd = new StringBuilder();
                    for (int i = 0; i < digest.length; i++) {
                        pwd = Integer.toHexString(0xFF & digest[i]);
                        if (pwd.length() < 2) {
                            pwd = "0" + pwd;
                        }
                        hashedpasswd.append(pwd);
                    }
                    HttpSession session = request.getSession();
                    if (rs.getString(3).equals(hashedpasswd.toString())) {
                        if (rs.getString("admin").equals("Y")) {
                            session.setAttribute("user_type", "admin");
                            response.sendRedirect("homepage");
                            return;
                        } else if (rs.getString("verified").equals("N")) {
                            session.setAttribute("user_type", "user_vr");
                            response.sendRedirect("homepage");
                            return;
                        } else {
                            session.setAttribute("user_type", "user_ok");
                            session.setAttribute("user", uname);
                            response.sendRedirect("homepage");
                            return;
                        }
                    } else {
                        request.getSession().setAttribute("error", "pwd");
                        response.sendRedirect("startpage.jsp");
                        return;
                    }
                }
                request.getSession().setAttribute("error", "uname");
                response.sendRedirect("startpage.jsp");
            }
        } catch (ClassNotFoundException | SQLException | NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
