<!DOCTYPE html>
<html>
    <head>
        <title>Navigate bids</title>
        <%@ page import ="java.sql.*" %>
        <%@ page import ="javax.sql.*" %>
        <%@ page import = "java.util.Date" %>
        <%@ page import = "java.text.SimpleDateFormat" %>
    </head>
    <body>
            <% //check if end date has passed
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC","root","");
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
        <% if (session.getAttribute("user")==null) { 
        response.sendRedirect("/homepage.jsp");
         } %>
        <a href="homepage.jsp">Homepage</a>
        <a href="manage.jsp">Manage bids</a>
        <a href="navigate.jsp">Search/Navigate bids</a>
        <% if (session.getAttribute("user")!=null) { %>
        <a href="LogoutServlet">Log-out</a>
        <% } else{ %>
        <a href="startpage.jsp">Log-in/Sign-up</a>
        <% } %>
        </br>
        </br>
        <a href="createbids.jsp">Create a bid</a>
        <a href="navigatebids.jsp">Navigate live bids</a>
        <a href="editbids.jsp">Edit/Delete not live bids</a>
        <%
            Object o=session.getAttribute("user");
            String usr=(String)o;
            Statement st = con.createStatement();
            Statement st_2 = con.createStatement();
            Statement st_3 = con.createStatement();
            Statement st_4 = con.createStatement();
            int val=1;
            ResultSet rs=st.executeQuery("SELECT * FROM item WHERE seller_id = '" + usr + "' AND hasstarted = '" + val + "' ");
            %>
            <!-- Live bids navigation (hasstarted==1) -->
            <p><b> Live Bids of <%=usr%></b></p>
            <%
            while(rs.next()){
                String idi=rs.getString(1);
                int id=Integer.valueOf(idi);
              %>
              </br></br>
              <p> <b><%=rs.getString("name")%></b> </p> </br>
              <table cellspacing='5'>
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
              ResultSet photors=st_4.executeQuery("SELECT * FROM photo WHERE item_id = '" + id + "'");      
              while(photors.next()){
                Blob im=photors.getBlob("photo_data");
                %>
                <img src="<%=im %> " width="50"/>
                <%
              }
              ResultSet bidrs=st_3.executeQuery("SELECT * FROM bid WHERE item_id = '" + id + "'");
            %>
            <p><b> Bids:</b></p>
            <%
            while(bidrs.next()){ 
                Statement st_5 = con.createStatement();
                ResultSet bidderrs=st_5.executeQuery("SELECT * FROM bidder WHERE user_id= '" + bidrs.getString("user_id") + "'");
            
                %>
              <table cellspacing='5'>
                  <tr>
                  <td valing='top' aling='left'><b>Bidder username:</b></td>
                  <td valing='top' aling='right'><b><%=bidrs.getString("user_id")%></b></td>
                  <tr>
                  <% if(bidderrs.next()){ %>
                  <td valing='top' aling='left'><b>Location:</b></td>
                  <td valing='top' aling='right'><b><%=bidderrs.getString("location")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Country:</b></td>
                  <td valing='top' aling='right'><b><%=bidderrs.getString("country")%></b></td>
              </tr>
              <% } %>
              <tr>
                  <td valing='top' aling='left'><b>Time:</b></td>
                  <td valing='top' aling='right'><b><%=bidrs.getString("time")%></b></td>
              </tr>
                
              <tr>
                  <td valing='top' aling='left'><b>Amount:</b></td>
                  <td valing='top' aling='right'><b><%=bidrs.getString("amount")%></b></td>
              </tr>
              </tr>
              <p> ----------------------------------- </p>
              <% }
              %>
              </table>
              <p> ----------------------------------- </p>
              <%
            }
            %>
        
    </body>
</html>