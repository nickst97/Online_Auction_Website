<!DOCTYPE html>
<html>
    <head>
        <title>Navigate bids</title>
        <%@ page import ="java.sql.*" %>
        <%@ page import ="javax.sql.*" %>
    </head>
    <body>
        <a href="homepage.jsp">Homepage</a>
        <a href="manage.jsp">Manage bids</a>
        <a href="navigate.jsp">Search/Navigate bids</a>
        <% if (session.getAttribute("user")!=null) { %>
        <a href="./jsp/logout.jsp">Log-out</a>
        <% } else{ %>
        <a href="startpage.html">Log-in/Sign-up</a>
        <% } %>
        </br>
        </br>
        <a href="createbids.jsp">Create a bid</a>
        <a href="navigatebids.jsp">Navigate live bids</a>
        <a href="editbids.jsp">Edit/Delete not live bids</a>
        <%
            Object o=session.getAttribute("user");
            String usr=(String)o;
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root","");
            Statement st = con.createStatement();
            Statement st_2 = con.createStatement();
            Statement st_3 = con.createStatement();
            Statement st_4 = con.createStatement();
            int val=1;
            ResultSet rs=st.executeQuery("SELECT * FROM item WHERE seller_id = '" + usr + "' AND hasstarted = '" + val + "' ");
            %>
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
            while(bidrs.next()){ %>
              <table cellspacing='5'>
                  <tr>
                  <td valing='top' aling='left'><b>Bidder username:</b></td>
                  <td valing='top' aling='right'><b><%=bidrs.getString("user_id")%></b></td>
                  <tr>
                  <td valing='top' aling='left'><b>Location:</b></td>
                  <td valing='top' aling='right'><b><%=bidrs.getString("location")%></b></td>
              </tr>
              <tr>
                  <td valing='top' aling='left'><b>Country:</b></td>
                  <td valing='top' aling='right'><b><%=bidrs.getString("country")%></b></td>
              </tr>
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