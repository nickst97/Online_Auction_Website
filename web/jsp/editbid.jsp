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
        <% 
            String val=request.getParameter("sbm");
            String idd=request.getParameter("item_id");
            int idf=Integer.parseInt(idd);
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root","");
            Statement st = con.createStatement();
            Statement st_2 = con.createStatement();
            Statement st_3 = con.createStatement();
            if(val.equals("Delete")){
                int rs=st.executeUpdate("DELETE FROM category WHERE item_id = '" + idf + "' ");
                rs=st_2.executeUpdate("DELETE FROM photo WHERE item_id = '" + idf + "' ");
                rs=st_3.executeUpdate("DELETE FROM item WHERE item_id = '" + idf + "' ");
                response.sendRedirect("../editbids.jsp");
            }
            else{
                Object oo=session.getAttribute("user");
                String usr=(String)oo;
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
                String has=request.getParameter("hasstarted");
                String start="";
                if(has.equals("0"))
                    start=request.getParameter("start");
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
                int l;
                if(has.equals("0"))    
                    l=st.executeUpdate("UPDATE item SET name = '" + name + "', first_bid = '" + firstbid + "',currently = '" + firstbid + "',buy_price =  '" + buyprice + "',location = '" + location + "',country = '" + country + "',started = '" + date + "',ends = '" + enddate + "',description = '" + description + "',hasstarted = '" + startval + "' WHERE item_id = '" + idf + "' ");
                else
                    l=st.executeUpdate("UPDATE item SET name = '" + name + "', first_bid = '" + firstbid + "',currently = '" + firstbid + "',buy_price =  '" + buyprice + "',location = '" + location + "',country = '" + country + "',ends = '" + enddate + "',description = '" + description + "' WHERE item_id = '" + idf + "' ");
                int rss=st.executeUpdate("DELETE FROM category WHERE item_id = '" + idf + "' ");
                for(int k=0;k<category.length;k++)
                    l=st.executeUpdate("insert into category (item_id,category_name) values ('" + idf + "','" + category[k] + "')");
                response.sendRedirect("../homepage.jsp");
            }
        %>
    </body>
</html>