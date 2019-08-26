
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
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(urlPatterns = {"/UploadBid"})
public class UploadBid extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public UploadBid() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try {
            HttpSession session = request.getSession(false);
            Object o=session.getAttribute("user");
            String usr=(String)o;
            SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date=sdf.format(new Date());
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC","root","");
            Statement st = con.createStatement();
            int l=st.executeUpdate("insert into bid (item_id,user_id,time,amount) values('" + request.getParameter("item_id") + "','" + usr + "', '" + date + "','" + request.getParameter("buyp") + "')");
            Statement st_2 = con.createStatement();
            ResultSet rs=st_2.executeQuery("SELECT * FROM item where item_id = '" + request.getParameter("item_id") + "'");
            if(rs.next()){
                int num=Integer.parseInt(rs.getString("number_of_bids"));
                num=num+1;
                float currently=Float.parseFloat(request.getParameter("buyp"));
                Statement st_3 = con.createStatement();
                float buy_p=Float.parseFloat(rs.getString("buy_price"));
                if(Float.compare(currently,buy_p)==0){
                    int has=2;
                    int upd=st_3.executeUpdate("UPDATE item SET currently = '" + currently + "',number_of_bids = '" + num + "',hasstarted = '" + has + "' WHERE item_id = '" + request.getParameter("item_id") + "' ");
                    String seller=rs.getString("seller_id");
                    Statement st_4 = con.createStatement();
                    int lp=st_4.executeUpdate("insert into won (item_id,bidder,seller) values ('" + request.getParameter("item_id") + "','" + usr + "','" + seller + "')");
                }
                else{
                    int upd=st_3.executeUpdate("UPDATE item SET currently = '" + currently + "',number_of_bids = '" + num + "' WHERE item_id = '" + request.getParameter("item_id") + "' ");
                }
            }
            response.sendRedirect("../../web/homepage.jsp");           
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}