
import java.io.IOException;
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
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            Statement st = con.createStatement();
            HttpSession session = request.getSession(false);
            String sender_uname = (String) session.getAttribute("user");

//            checking if this communication is possible between the two users
            Statement st_1 = con.createStatement();
            ResultSet rs = st_1.executeQuery("select * from won where item_id='" + item_id + "' and ((bidder='" + sender_uname + "' and seller='" + receiver_uname + "') or (bidder='" + receiver_uname + "' and seller='" + sender_uname + "'))");
            if (!rs.next()) {
                request.getSession().setAttribute("error", "msg");
                response.sendRedirect("inbox.jsp");
                return;
            } else {
//!
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time = sdf.format(new Date());
                int i = st.executeUpdate("insert into messages (item_id, sender_uname, receiver_uname, time, content) values (" + item_id + ", '" + sender_uname + "', '" + receiver_uname + "', '" + time + "', '" + content + "')");
                response.sendRedirect("inbox.jsp");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(msg_submit.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
