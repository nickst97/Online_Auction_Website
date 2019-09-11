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

@WebServlet(urlPatterns = {"/CreateBid"})
@MultipartConfig(maxFileSize=16177215) // upload max size=16MB
public class CreateBid extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public CreateBid() {
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
            String uname="";
            String name = request.getParameter("name");
            String[] category = request.getParameterValues("cat");
            String buyprice = request.getParameter("buyp");
            String firstbid = request.getParameter("firstb");
            String location = request.getParameter("loc");
            String country = request.getParameter("country");
            String description = request.getParameter("desc");
            String start=request.getParameter("start");
            String dt=request.getParameter("dt");
            String tm=request.getParameter("tm");
            String enddate=dt+" "+tm;
            Collection<Part> imgs=request.getParts();
            int num=0;
            int startval=1;
            if(start!=null){
            if(start.equals("Yes"))
                   startval=1;
            else
                   startval=0;
            }
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/login?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTCjdbc:mysql://localhost/login?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC","root","");
            Statement st = con.createStatement();
            int l=st.executeUpdate("insert into item (name,currently,first_bid,buy_price,number_of_bids,location,country,started,ends,seller_id,description,hasstarted) values('" + name + "','" + firstbid + "', '" + firstbid + "','" + buyprice + "','" + num + "', '" + location + "','" + country + "', '" + date + "', '" + enddate + "','" + usr + "','" + description + "','" + startval + "')");
            ResultSet rs=st.executeQuery("select * from item order by item_id desc limit 1");
            if(rs.next()){
                String id=rs.getString(1);
                int idi=Integer.valueOf(id);
                for(int k=0;k<category.length;k++){
                    l=st.executeUpdate("insert into category (item_id,category_name) values ('" + idi + "','" + category[k] + "')");
                }
                for(Part img :imgs){
                    if(img.getName().equals("img")){
                        InputStream is=img.getInputStream();
                        if(is.available()>0){
                            String sql="insert into photo (item_id,photo_data) values(?,?)";
                            PreparedStatement stat=con.prepareStatement(sql);
                            stat.setString(1,id);
                            stat.setBlob(2,is);
                            stat.executeUpdate();
                        }
                    }
               }

            }
            con.close();
        } catch (ClassNotFoundException | SQLException | NullPointerException | ServletException ex) {
            Logger.getLogger(CreateBid.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("homepage.jsp");
    }
}