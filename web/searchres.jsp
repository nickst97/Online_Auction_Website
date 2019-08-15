<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Search-Navigate Page</title>
        <%@ page import ="java.sql.*" %>
        <%@ page import ="javax.sql.*" %>
        <%@ page import = "java.util.Date" %>
        <%@ page import = "java.text.SimpleDateFormat" %>
    </head>
    <body>
        <%  //code to check if item end date has passed
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root","");
            Statement st_10=con.createStatement();
            int hasn=2;
            ResultSet rs_10=st_10.executeQuery("SELECT * FROM item WHERE hasstarted != '" + hasn + "'");
            SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date datec=new Date();
            /* for every item */
            while(rs_10.next()){
                String enddate=rs_10.getString("ends");
                Date edf=sdf.parse(enddate);
                /* if date passed */
                if(enddate.compareTo(sdf.format(datec))<0){
                    Statement st_11=con.createStatement();
                    int hasch=2;
                    /* end it */
                    int lch=st_11.executeUpdate("UPDATE item SET hasstarted = '" + hasch + "' WHERE item_id= '" + rs_10.getString("item_id") + "'");
                    Statement st_12=con.createStatement();
                    ResultSet rs_12=st_12.executeQuery("SELECT * FROM item WHERE item_id = '" + rs_10.getString("item_id") + "'");
                    /* find item */
                    if(rs_12.next()){
                        /* get current max */
                        float curr=Float.parseFloat(rs_12.getString("currently"));
                        Statement st_13=con.createStatement();
                        ResultSet rs_13=st_13.executeQuery("SELECT * FROM bid WHERE item_id = '" + rs_10.getString("item_id") + "'");
                        /* for every bid of this item */
                        while(rs_13.next()){
                            float amount=Float.parseFloat(rs_13.getString("amount"));
                            /* if max,won */
                            if(Float.compare(curr,amount)==0){
                                String seller=rs_12.getString("seller_id");
                                String usrw=rs_13.getString("user_id");
                                Statement st_14 = con.createStatement();
                                int lp=st_14.executeUpdate("insert into won (item_id,bidder,seller) values ('" + rs_10.getString("item_id") + "','" + usrw + "','" + seller + "')");
                                break;
                            }
                        }
                    }
                }
            }
            //ends here
        %>
        <a href="homepage.jsp">Homepage</a>
        <% if (session.getAttribute("user")!=null) { %>
        <a href="manage.jsp">Manage bids</a>
        <% } %>
        <a href="navigate.jsp">Search/Navigate bids</a>
        <% if (session.getAttribute("user")!=null) { %>
        <a href="./jsp/logout.jsp">Log-out</a>
        <% } else{ %>
        <a href="startpage.jsp">Log-in/Sign-up</a>
        <% } %>
        <!-- category dropdown-->
        <form action="searchres.jsp" method="post">
        Choose a category:
        <select name="cat" >
            <%
            Statement st_7 = con.createStatement();
            ResultSet rs_8=st_7.executeQuery("SELECT * FROM category_labels"); 
            while(rs_8.next()){ %>
            <option name="cat" value=<%=rs_8.getString("category_name")%> ><%=rs_8.getString("category_name")%></option>
        <% } %>
        </select>
        <input name="formn" type="hidden" value="f1" />
        <input type="submit" name="sbm" value="Submit" />
        </form>
        <!-- category type -->
        <form action="searchres.jsp" method="post">
            Category: <input type="text" name="cat" placeholder="ex Mens" required/>
            <input name="formn" type="hidden" value="f2" />
            <input type="submit" name="sbm" value="Submit" />
        </form>
        <!-- location -->
        <form action="searchres.jsp" method="post">
            Location: <input type="text" name="loc" placeholder="ex Greece" required/>
            <input name="formn" type="hidden" value="f3" />
            <input type="submit" name="sbm" value="Submit" />
        </form>
        <!-- description -->
        <form action="searchres.jsp" method="post">
            Description: <input type="text" name="desc" required/>
            <input name="formn" type="hidden" value="f4" />
            <input type="submit" name="sbm" value="Submit" />
        </form>
        <!-- buy price -->
         <form action="searchres.jsp" method="post">
            Price: <input type="number" name="price" step="0.01" min="0" placeholder="ex 1.5" required/>
            <input name="formn" type="hidden" value="f5" />
            <input type="submit" name="sbm" value="Submit" />
        </form>
        <%
            Statement st = con.createStatement();
            Statement st_2 = con.createStatement();
            Statement st_3 = con.createStatement();
            Statement st_4 = con.createStatement();
            String val=request.getParameter("formn");
            ResultSet rs=null;
            ResultSet cattrs=null;
            // if category input
            if(val.equals("f1") || val.equals("f2")){   //category input
                String cat=request.getParameter("cat");
                cattrs=st.executeQuery("SELECT * FROM category WHERE category_name = '" + cat + "'");
                if(!cattrs.isBeforeFirst()){
                    %> <p>No results match the search</p> <%
                }
                int times=0;
                while(cattrs.next()){
                    int valll=1;
                    String teidi=cattrs.getString("item_id");
                    int itm=Integer.valueOf(teidi);
                    ResultSet rs_2=st_4.executeQuery("SELECT * FROM item WHERE item_id = '" + itm + "' AND hasstarted = '" + valll + "' ");
                    while(rs_2.next()){
                        times=times+1;
                        String idi=rs_2.getString(1);
                        int id=Integer.valueOf(idi);
              %>
              <!-- output category input results-->
              </br></br>
              <p> <b><%=rs_2.getString("name")%></b> </p> </br>
              <table cellspacing='5'>
              <tr>
                  <td valing='top' aling='left'><b>Seller:</b></td>
                  <td valing='top' aling='right'><b><%=rs_2.getString("seller_id")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Best offer:</b></td>
                  <td valing='top' aling='right'><b><%=rs_2.getString("currently")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Buy Price:</b></td>
                  <td valing='top' aling='right'><b><%=rs_2.getString("buy_price")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>First Bid:</b></td>
                  <td valing='top' aling='right'><b><%=rs_2.getString("first_bid")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Number of bids:</b></td>
                  <td valing='top' aling='right'><b><%=rs_2.getString("number_of_bids")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Location:</b></td>
                  <td valing='top' aling='right'><b><%=rs_2.getString("location")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Country:</b></td>
                  <td valing='top' aling='right'><b><%=rs_2.getString("country")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Starting date:</b></td>
                  <td valing='top' aling='right'><b><%=rs_2.getString("started")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Ending date:</b></td>
                  <td valing='top' aling='right'><b><%=rs_2.getString("ends")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Description:</b></td>
                  <td valing='top' aling='right'><b><%=rs_2.getString("description")%></b></td>
              </tr>
              <%
              ResultSet catrs=st_2.executeQuery("SELECT * FROM category WHERE item_id = '" + id + "'");
              int i=0;
               while(catrs.next()){ 
                    i=i+1;
              %>
              <tr>
                  <td valing='top' aling='left'><b>Category <%=i%>:</b></td>
                  <td valing='top' aling='right'><b><%=catrs.getString("category_name")%></b></td>
              </tr>
              <% }
              %>
              </table>
              </br> </br>
              <%
              ResultSet photors=st_3.executeQuery("SELECT * FROM photo WHERE item_id = '" + id + "'");      
              while(photors.next()){
                Blob im=photors.getBlob("photo_data");
                %>
                <img src="<%=im %> " width="50"/>
                <%
              }
              %>
                <% if (session.getAttribute("user")!=null) { %>
            <form action="placebid.jsp" method="post">
            <input name="item_id" type="hidden" value=<%=rs_2.getString(1)%> />
            Place bid:<input type="submit" name="sbm" value="Place bid" />
            </form> <%
            }
            }
            }
                if(times==0){
                    %> <p>No results match the search</p> <%
                }
            }
            else{   //not category input
                int vall=1;
                if(val.equals("f3")){
                    String loc=request.getParameter("loc");
                    rs=st.executeQuery("SELECT * FROM item WHERE location = '" + loc + "' OR country = '" + loc + "' AND hasstarted = '" + vall + "' ");
                }
                else if(val.equals("f4")){
                    String descr=request.getParameter("desc");
                    rs=st.executeQuery("SELECT * FROM item WHERE desc CONTAINS '" + descr + "' AND hasstarted = '" + vall + "' ");
                }
                else if(val.equals("f5")){
                    String fl=request.getParameter("price");
                    float f=Float.parseFloat(fl);
                    rs=st.executeQuery("SELECT * FROM item WHERE buy_price = '" + f + "' AND hasstarted = '" + vall + "' ");
                }
                if(!rs.isBeforeFirst()){
                    %> <p>No results match the search</p> <%
                }
            while(rs.next()){
                String idi=rs.getString(1);
                int id=Integer.valueOf(idi);
              %>
              <!-- output results -->
              </br></br>
              <p> <b><%=rs.getString("name")%></b> </p> </br>
              <table cellspacing='5'>
              <tr>
                  <td valing='top' aling='left'><b>Seller:</b></td>
                  <td valing='top' aling='right'><b><%=rs.getString("seller_id")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Best offer:</b></td>
                  <td valing='top' aling='right'><b><%=rs.getString("currently")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Buy Price:</b></td>
                  <td valing='top' aling='right'><b><%=rs.getString("buy_price")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>First Bid:</b></td>
                  <td valing='top' aling='right'><b><%=rs.getString("first_bid")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Number of bids:</b></td>
                  <td valing='top' aling='right'><b><%=rs.getString("number_of_bids")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Location:</b></td>
                  <td valing='top' aling='right'><b><%=rs.getString("location")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Country:</b></td>
                  <td valing='top' aling='right'><b><%=rs.getString("country")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Starting date:</b></td>
                  <td valing='top' aling='right'><b><%=rs.getString("started")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Ending date:</b></td>
                  <td valing='top' aling='right'><b><%=rs.getString("ends")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Description:</b></td>
                  <td valing='top' aling='right'><b><%=rs.getString("description")%></b></td>
              </tr>
              <%
              ResultSet catrs=st_2.executeQuery("SELECT * FROM category WHERE item_id = '" + id + "'");
              int i=0;
               while(catrs.next()){ 
                    i=i+1;
              %>
              <tr>
                  <td valing='top' aling='left'><b>Category <%=i%>:</b></td>
                  <td valing='top' aling='right'><b><%=catrs.getString("category_name")%></b></td>
              </tr>
              <% }
              %>
              </table>
              </br> </br>
              <%
              ResultSet photors=st_3.executeQuery("SELECT * FROM photo WHERE item_id = '" + id + "'");      
              while(photors.next()){
                Blob im=photors.getBlob("photo_data");
                %>
                <img src="<%=im %> " width="50"/>
                <%
              }
              %>
            <!-- place bids -->
            <% if (session.getAttribute("user")!=null) { %>
            <form action="placebid.jsp" method="post">
            <input name="item_id" type="hidden" value=<%=rs.getString(1)%> />
            Place bid:<input type="submit" name="sbm" value="Place bid" />
            </form> <%
            }
            }   //while
            }// if
           %>
    </body>
</html>