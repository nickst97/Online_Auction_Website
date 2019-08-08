<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Create Bid</title>
    </head>
    <body>
        <%@ page import ="java.sql.*" %>
        <%@ page import ="javax.sql.*" %>
        <%@ page import = "java.util.Date" %>
        <%@ page import = "java.text.SimpleDateFormat" %>
        <%@ page import = "java.io.InputStream" %>
        <% 
            Object o=session.getAttribute("user");
            String usr=(String)o;
            SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date=sdf.format(new Date());
            String uname="";
            String name = request.getParameter("name");
            String[] category = request.getParameterValues("cat");
            String[] img=request.getParameterValues("img");
            String buyprice = request.getParameter("buyp");
            String firstbid = request.getParameter("firstb");
            String location = request.getParameter("loc");
            String country = request.getParameter("country");
            String description = request.getParameter("desc");
            String start=request.getParameter("start");
            String dt=request.getParameter("dt");
            String tm=request.getParameter("tm");
            String enddate=dt+" "+tm;
            int num=0;
            int startval=1;
            if(start!=null){
            if(start.equals("Yes"))
                   startval=1;
            else
                   startval=0;
            }
            out.println("b;a "+date+" y y "+enddate);
            if(category!=null)
            for(int i=0;i<category.length;i++)
                out.println(uname+category[i]);
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root","");
            Statement st = con.createStatement();
            int l=st.executeUpdate("insert into item (name,currently,first_bid,buy_price,number_of_bids,location,country,started,ends,seller_id,description,hasstarted) values('" + name + "','" + firstbid + "', '" + firstbid + "','" + buyprice + "','" + num + "', '" + location + "','" + country + "', '" + date + "', '" + enddate + "','" + usr + "','" + description + "','" + startval+ "')");
            ResultSet rs=st.executeQuery("select * from item order by item_id desc limit 1");
            if(rs.next()){
            String id=rs.getString(1);
            int idi=Integer.valueOf(id);
            for(int k=0;k<category.length;k++)
                l=st.executeUpdate("insert into category (item_id,category_name) values ('" + idi + "','" + category[k] + "')");
            for(int k=0;k<img.length;k++)
                l=st.executeUpdate("insert into photo (item_id,photo_data) values ('" + idi + "','" + img[k] + "')");
            }
            response.sendRedirect("../homepage.jsp");
        %>
    </body>
</html>
