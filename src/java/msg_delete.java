import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//CURRENT SERVLET REDIRECTS TO HOMEPAGES, OLD "homepage"
@WebServlet("/msg_delete")
public class msg_delete extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        String msg_id = request.getParameter("msg_id");
        if (msg_id != null && !msg_id.isEmpty()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                Statement st = con.createStatement();
                ResultSet rs;
                rs = st.executeQuery("select deleted_for from messages where msg_id = " + msg_id + " limit 1;");
                if (rs.next()) {
                    if (rs.getString("deleted_for") == null) {
                        st.executeUpdate("UPDATE messages SET deleted_for = '" + (String) session.getAttribute("user") + "' WHERE msg_id = " + msg_id );
                    }
                    else{
                        st.executeUpdate("DELETE FROM messages WHERE msg_id = " + msg_id);
                    }
                }
                response.sendRedirect("./inbox.jsp");
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(msg_delete.class.getName()).log(Level.SEVERE, null, ex);
            }
        }     
    }
}
