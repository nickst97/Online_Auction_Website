
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

@WebServlet(urlPatterns = {"/ImageRetrieve"})
public class ImageRetrieve extends HttpServlet {
    private static final long serialVersionUID=1L;
    
@Override
protected void service(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException{
    try{
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTCjdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC","root","");
        HttpSession session = req.getSession(false);
        int photo_id=Integer.parseInt(req.getParameter("ph"));
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery("select * from photo where photo_id = '" + photo_id + "'");
        byte[] img=null;
        ServletOutputStream ss=null;
        if(rs.next()){
            img=rs.getBytes("photo_data");
        }
        ss=resp.getOutputStream();
        ss.write(img);
        con.close();
    }catch(Exception ex){
        Logger.getLogger(ImageRetrieve.class.getName()).log(Level.SEVERE, null, ex);
    }
}
}
