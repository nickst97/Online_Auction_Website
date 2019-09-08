
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
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.ServletException;

@WebServlet(urlPatterns = {"/DownloadDTD"})
public class DownloadDTD extends HttpServlet {
    private static final long serialVersionUID=1L;
    
@Override
protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
    try{
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC","root","");
        response.setContentType("text/xml");
        String filename="GenerateDTD_"+System.currentTimeMillis()+".xml";
        response.setHeader("Content-disposition","attachment;filename=" + filename);
        ArrayList<String> rows=new ArrayList<String>();
        rows.add("<Items>");
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery("select * from item");
        // for every item
        while(rs.next()){  
            int id=Integer.parseInt(rs.getString("item_id"));
            rows.add("\t<Item ItemID=\""+rs.getString("item_id")+"\">");
            rows.add("\t\t<Name>"+rs.getString("name")+"</Name>");
            //for every category
            Statement st_2 = con.createStatement();
            ResultSet rs_2=st_2.executeQuery("select * from category where item_id = '" + id + "'");
            while(rs_2.next()){
                rows.add("\t\t<Category>"+rs_2.getString("category_name")+"</Category>");
            }
            rows.add("\t\t<Currently>"+rs.getString("currently")+"</Currently>");
            rows.add("\t\t<First_Bid>"+rs.getString("first_bid")+"</First_bid>");
            rows.add("\t\t<Number_of_Bids>"+rs.getString("number_of_bids")+"</Number_of_Bids>");
            //bid
            Statement st_3 = con.createStatement();
            ResultSet rs_3=st_3.executeQuery("select * from bid where item_id = '" + id + "'");
            if(rs_3.isBeforeFirst()){
                rows.add("\t\t<Bids>");
                while(rs_3.next()){
                    rows.add("\t\t\t<Bid>");
                    Statement st_4 = con.createStatement();
                    ResultSet rs_4=st_4.executeQuery("select * from bidder where user_id = '" + rs_3.getString("user_id") + "'");
                    if(rs_4.next()){
                        rows.add("\t\t\t\t<Bidder UserID=\""+rs_4.getString("user_id")+"\">");
                        rows.add("\t\t\t\t\t<Location>"+rs_4.getString("location")+"</Location>");
                        rows.add("\t\t\t\t\t<Country>"+rs_4.getString("country")+"</Country>");
                        rows.add("\t\t\t\t</Bidder>");
                    }
                    rows.add("\t\t\t\t<Time>"+rs_3.getString("time")+"</Time>");
                    rows.add("\t\t\t\t<Amount>"+rs_3.getString("amount")+"</Amount>");
                    rows.add("\t\t\t</Bid>");
                }
                rows.add("\t\t</Bids>");
            }
            rows.add("\t\t<Location>"+rs.getString("location")+"</Location>");
            rows.add("\t\t<Country>"+rs.getString("country")+"</Country>");
            rows.add("\t\t<Started>"+rs.getString("started")+"</Started>");
            rows.add("\t\t<Ends>"+rs.getString("ends")+"</Ends>");
            rows.add("\t\t<Seller SellerID=\""+rs.getString("seller_id")+"\">");
            rows.add("\t\t<Description>"+rs.getString("description")+"</Description>");
            rows.add("\t</Item>");
        }
        rows.add("</Items>");
        
        Iterator<String> it=rows.iterator();
        while(it.hasNext()){
            String outputs=(String)it.next();
            response.getOutputStream().println(outputs);
        }
        response.getOutputStream().flush();
                
    }catch(Exception ex){
        Logger.getLogger(ImageRetrieve.class.getName()).log(Level.SEVERE, null, ex);
    }
}
}
