
import java.io.IOException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(urlPatterns = {"/EditBid"})
public class EditBid extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public EditBid() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try {
            String val = request.getParameter("sbm");
            String idd = request.getParameter("item_id");
            int idf = Integer.parseInt(idd);
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTCjdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            Statement st = con.createStatement();
            Statement st_2 = con.createStatement();
            Statement st_3 = con.createStatement();
            if (val.equals("Delete")) {
                int rs = st.executeUpdate("DELETE FROM category WHERE item_id = '" + idf + "' ");
                rs = st_2.executeUpdate("DELETE FROM photo WHERE item_id = '" + idf + "' ");
                rs = st_3.executeUpdate("DELETE FROM item WHERE item_id = '" + idf + "' ");
            } else {
                HttpSession session = request.getSession(false);
                Object oo = session.getAttribute("user");
                String usr = (String) oo;
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String date = sdf.format(new Date());
                String uname = "";
                String name = request.getParameter("name");
                String[] category = request.getParameterValues("cat");
                String buyprice = request.getParameter("buyp");
                String firstbid = request.getParameter("firstb");
                String location = request.getParameter("loc");
                String country = request.getParameter("country");
                String lat = request.getParameter("lat");
                String lon = request.getParameter("lon");
                String description = request.getParameter("desc");
                String has = request.getParameter("hasstarted");
                String start = "";
                if (has.equals("0")) {
                    start = request.getParameter("start");
                }
                String dt = request.getParameter("dt");
                String tm = request.getParameter("tm");
                String enddate = dt + " " + tm;
                int num = 0;
                int startval = 1;
                if (start != null) {
                    if (start.equals("Yes")) {
                        startval = 1;
                    } else {
                        startval = 0;
                    }
                }
                int l;
                if (has.equals("0")) {
                    l = st.executeUpdate("UPDATE item SET name = '" + name + "', first_bid = '" + firstbid + "',lat = '" + lat + "',lon = '" + lon + "',currently = '" + firstbid + "',buy_price =  '" + buyprice + "',location = '" + location + "',country = '" + country + "',started = '" + date + "',ends = '" + enddate + "',description = '" + description + "',hasstarted = '" + startval + "' WHERE item_id = '" + idf + "' ");
                } else {
                    l = st.executeUpdate("UPDATE item SET name = '" + name + "', first_bid = '" + firstbid + "',currently = '" + firstbid + "',lat = '" + lat + "',lon = '" + lon + "',buy_price =  '" + buyprice + "',location = '" + location + "',country = '" + country + "',ends = '" + enddate + "',description = '" + description + "' WHERE item_id = '" + idf + "' ");
                }
                int rss = st.executeUpdate("DELETE FROM category WHERE item_id = '" + idf + "' ");
                for (int k = 0; k < category.length; k++) {
                    l = st.executeUpdate("insert into category (item_id,category_name) values ('" + idf + "','" + category[k] + "')");
                }
            }
        } catch (ClassNotFoundException | SQLException | NullPointerException ex) {
            Logger.getLogger(EditBid.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("editbids.jsp");
    }
}
