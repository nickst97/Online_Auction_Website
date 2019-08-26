
import java.io.IOException;
import static java.lang.System.out;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

@WebServlet(urlPatterns = {"/msg_submit"})
public class msg_submit extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public msg_submit() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String receiver_uname = request.getParameter("receiver");
            String item_id = request.getParameter("itemid");
            String content = request.getParameter("content");
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "king", "");
            Statement st = con.createStatement();
            HttpSession session = request.getSession(false);
            String sender_uname = (String) session.getAttribute("user");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = sdf.format(new Date());
            int i = st.executeUpdate("insert into messages (item_id, sender_uname, receiver_uname, time, content) values (" + item_id + ", '" + sender_uname + "', '" + receiver_uname + "', '" + time + "', '" + content + "')");
            response.sendRedirect("inbox.jsp");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(msg_submit.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
