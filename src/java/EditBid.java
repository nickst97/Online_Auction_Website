
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
import java.io.InputStream;
import javax.servlet.ServletException;
import java.sql.PreparedStatement;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
import java.io.File;
import java.io.FileInputStream;
import java.util.Collection;
import java.util.ArrayList;
import java.util.Iterator;

@WebServlet(urlPatterns = {"/EditBid"})
@MultipartConfig(maxFileSize=16177215) // upload max size=16MB
public class EditBid extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public EditBid() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try {
            HttpSession session = request.getSession(false);
            Object oo = session.getAttribute("user");
            String usr = (String) oo;
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
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String date = sdf.format(new Date());
                String uname = "";
                String name = request.getParameter("name");
                String[] category = request.getParameterValues("cat");
                String buyprice = request.getParameter("buyp");
                String firstbid = request.getParameter("firstb");
                String location = request.getParameter("loc");
                String country = request.getParameter("country");
                String description = request.getParameter("desc");
                String has = request.getParameter("hasstarted");
                Collection<Part> imgs=request.getParts();
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
                    l = st.executeUpdate("UPDATE item SET name = '" + name + "', first_bid = '" + firstbid + "',currently = '" + firstbid + "',buy_price =  '" + buyprice + "',location = '" + location + "',country = '" + country + "',started = '" + date + "',ends = '" + enddate + "',description = '" + description + "',hasstarted = '" + startval + "' WHERE item_id = '" + idf + "' ");
                } else {
                    l = st.executeUpdate("UPDATE item SET name = '" + name + "', first_bid = '" + firstbid + "',currently = '" + firstbid + "',buy_price =  '" + buyprice + "',location = '" + location + "',country = '" + country + "',ends = '" + enddate + "',description = '" + description + "' WHERE item_id = '" + idf + "' ");
                }
                int rss = st.executeUpdate("DELETE FROM category WHERE item_id = '" + idf + "' ");
                for (int k = 0; k < category.length; k++) {
                    l = st.executeUpdate("insert into category (item_id,category_name) values ('" + idf + "','" + category[k] + "')");
                }
                for(Part img :imgs){
                    if(img.getName().equals("img")){
                        InputStream is=img.getInputStream();
                        if(is.available()>0){
                            String sql="insert into photo (item_id,photo_data) values(?,?)";
                            PreparedStatement stat=con.prepareStatement(sql);
                            stat.setString(1,idd);
                            stat.setBlob(2,is);
                            stat.executeUpdate();
                        }
                    }
               }
            }
        } catch (ClassNotFoundException | SQLException | NullPointerException | ServletException ex) {
            Logger.getLogger(EditBid.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("navigatebids.jsp");
    }
}
