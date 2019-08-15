<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" charset=ISO-8859-1">
        <title>Edit bids</title>
        <%@ page import ="java.sql.*" %>
        <%@ page import ="javax.sql.*" %>
        <%@ page import ="java.util.ArrayList" %>
        <%@ page import = "java.util.Date" %>
        <%@ page import = "java.text.SimpleDateFormat" %>
    </head>
    <body>
            <%  //see if end date has passed
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
        <% if (session.getAttribute("user")==null) { 
        response.sendRedirect("/homepage.jsp");
         } %>
        <a href="homepage.jsp">Homepage</a>
        <a href="manage.jsp">Manage bids</a>
        <a href="navigate.jsp">Search/Navigate bids</a>
        <% if (session.getAttribute("user")!=null) { %>
        <a href="./jsp/logout.jsp">Log-out</a>
        <% } else{ %>
        <a href="startpage.jsp">Log-in/Sign-up</a>
        <% } %>
        </br>
        </br>
        <a href="createbids.jsp">Create a bid</a>
        <a href="navigatebids.jsp">Navigate live bids</a>
        <a href="editbids.jsp">Edit/Delete not live bids</a>
         <%
            //edit not live bids(hasstarted==0) or live bids(hasstarted==1) with number_of_bids==0
            Object o=session.getAttribute("user");
            String usr=(String)o;
            Statement st = con.createStatement();
            Statement st_2 = con.createStatement();
            int val=0;
            int num=0;
            ResultSet rs=st.executeQuery("SELECT * FROM item WHERE seller_id = '" + usr + "' AND (hasstarted = '" + val + "' OR number_of_bids = '" + num + "' ) AND hasstarted!= '" + hasn + "'");
           %>
           </br> <p><b> Edit Bids of <%=usr%></b></p> </br> </br>
            <%
                
            while(rs.next()){ 
            session.setAttribute("itemid",rs.getString("item_id"));
            session.setAttribute("hasstarted",rs.getString("hasstarted"));
            %>
        <form action="./jsp/editbid.jsp" method="post">
        Edit bid <%=rs.getString("item_id")%> : <br/><br/>
        <input name="item_id" type="hidden" value=<%=rs.getString("item_id")%> />
        <input name="hasstarted" type="hidden" value=<%=rs.getString("hasstarted")%> />
        Name: <input type="text" name="name" value="<%=rs.getString("name")%>" required /><br/><br/>
        <% 
        String idi=rs.getString(1);
        int id=Integer.valueOf(idi);
        ResultSet catrs=st_2.executeQuery("SELECT * FROM category WHERE item_id = '" + id + "'");
        ArrayList<String> ar=new ArrayList<String>();
        while(catrs.next()){
            ar.add(catrs.getString("category_name"));
        }
        if(ar.contains("Movies"))
            out.println("MOVIES");
        %>
        Categories: </br> 
            <%  
            Statement st_5 = con.createStatement();
            ResultSet rs_2=st_5.executeQuery("SELECT * FROM category_labels");
            String descr=rs.getString("description");
            while(rs_2.next()){ 
            
             %>
            <input type="checkbox" name="cat" value=<%=rs_2.getString("category_name")%> <% if(ar.contains(rs_2.getString("category_name"))){ %> checked <% } %> ><%=rs_2.getString("category_name")%></input>
        <% } %>
        <br/><br/>
        Buy Price: <input type="number" name="buyp"  step="0.01" min="0" value=<%=rs.getString("buy_price")%> required /><br/><br/>
        First Bid: <input type="number" name="firstb"  step="0.01" min="0" value=<%=rs.getString("first_bid")%> required /><br/><br/>
        Location: <input type="text" name="loc" value="<%=rs.getString("location")%>" required /><br/><br/>
        Country: <input type="text" name="country" value="<%=rs.getString("country")%>" required /><br/><br/>
        Description: <input type="text" name="desc" value="<%=rs.getString("description")%>" required /><br/><br/>
        <% 
        
        String s=rs.getString("ends");
        String s1=s.substring(0,10);
        String s2=s.substring(11,19);
        %>
        End of bid: <input type="date" name="dt" value=<%=s1%> required /> <input type="time" name="tm"  value=<%=s2%> step="1" required /><br/><br/>
        <%
        if(rs.getString("hasstarted").equals("1")){ %>
        Start bid: Bid has already started <br/> <br/> 
        <% } else { %>
        Start bid: <br/> <br/>
        <input type="radio" name="start" value="Yes" >Yes<br/><br/>
        <input type="radio" name="start" value="No" checked>No<br/><br/>
        <% } %>
        <br/><br/>
        Edit bid:<input type="submit" name="sbm" value="Edit" /><br/><br/>
        Delete bid:<input type="submit" name="sbm" value="Delete" /><br/><br/>
        </form>
        <p> ---------------------------------- </p>
        <% }
        %>
    </body>
</html>
