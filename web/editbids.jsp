<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" charset=ISO-8859-1">
        <title>Edit bids</title>
        <%@ page import ="java.sql.*" %>
        <%@ page import ="javax.sql.*" %>
        <%@ page import ="java.util.ArrayList" %>
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
            int val=0;
            int num=0;
            ResultSet rs=st.executeQuery("SELECT * FROM item WHERE seller_id = '" + usr + "' AND (hasstarted = '" + val + "' OR number_of_bids = '" + num + "' )");
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
        Name: <input type="text" name="name" value=<%=rs.getString("name")%> /><br/><br/>
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
            <input type="checkbox" name="cat" value="Collectibles" <% if(ar.contains("Collectibles")){ %> checked <% } %> >Collectibles</input>
            <input type="checkbox" name="cat" value="Movies" <% if(ar.contains("Movies")){ %> checked <% } %> >Movies</input>
            <input type="checkbox" name="cat" value="DVD" <% if(ar.contains("DVD")){ %> checked <% } %> >DVD</input>
            <input type="checkbox" name="cat" value="Television" <% if(ar.contains("Television")){ %> checked <% } %> >Television</input>
            <input type="checkbox" name="cat" value="Autographs" <% if(ar.contains("Autographs")){ %> checked <% } %> >Autographs</input>
            <input type="checkbox" name="cat" value="Posters" <% if(ar.contains("Posters")){ %> checked <% } %> >Posters</input>
            <input type="checkbox" name="cat" value="Music" <% if(ar.contains("Music")){ %> checked <% } %> >Music</input>
            <input type="checkbox" name="cat" value="Video" <% if(ar.contains("Video")){ %> checked <% } %> >Video</input>
            <input type="checkbox" name="cat" value="Clothing" <% if(ar.contains("Clothing")){ %> checked <% } %> >Clothing</input>
            <input type="checkbox" name="cat" value="Boys" <% if(ar.contains("Boys")){ %> checked <% } %> >Boys</input>
            <input type="checkbox" name="cat" value="Girls" <% if(ar.contains("Girls")){ %> checked <% } %> >Girls</input>
            <input type="checkbox" name="cat" value="Teens" <% if(ar.contains("Teens")){ %> checked <% } %> >Teens</input>
            <input type="checkbox" name="cat" value="Men" <% if(ar.contains("Men")){ %> checked <% } %> >Men</input>
            <input type="checkbox" name="cat" value="Women" <% if(ar.contains("Women")){ %> checked <% } %> >Women</input>
            <input type="checkbox" name="cat" value="Underwears" <% if(ar.contains("Underwears")){ %> checked <% } %> >Underwears</input>
            <input type="checkbox" name="cat" value="Shoes" <% if(ar.contains("Shoes")){ %> checked <% } %> >Shoes</input>
            <input type="checkbox" name="cat" value="Jeans" <% if(ar.contains("Jeans")){ %> checked <% } %> >Jeans</input>
            <input type="checkbox" name="cat" value="T-shirts" <% if(ar.contains("T-shirts")){ %> checked <% } %> >T-shirts</input>
            <input type="checkbox" name="cat" value="Sweaters" <% if(ar.contains("Sweaters")){ %> checked <% } %> >Sweaters</input>
            <input type="checkbox" name="cat" value="Accessories" <% if(ar.contains("Accessories")){ %> checked <% } %> >Accessories</input>
            <input type="checkbox" name="cat" value="Backpacks" <% if(ar.contains("Backpacks")){ %> checked <% } %> >Backpacks</input>
            <input type="checkbox" name="cat" value="Bags" <% if(ar.contains("Bags")){ %> checked <% } %> >Bags</input>
            <input type="checkbox" name="cat" value="Suits" <% if(ar.contains("Suits")){ %> checked <% } %> >Suits</input>
            <input type="checkbox" name="cat" value="Sports" <% if(ar.contains("Sports")){ %> checked <% } %> >Sports</input>
            <input type="checkbox" name="cat" value="Skirts" <% if(ar.contains("Skirts")){ %> checked <% } %> >Skirts</input>
            <input type="checkbox" name="cat" value="Small" <% if(ar.contains("Small")){ %> checked <% } %> >Small</input>
            <input type="checkbox" name="cat" value="Medium" <% if(ar.contains("Medium")){ %> checked <% } %> >Medium</input>
            <input type="checkbox" name="cat" value="Large" <% if(ar.contains("Large")){ %> checked <% } %> >Large</input>
            <input type="checkbox" name="cat" value="Extra-Small" <% if(ar.contains("Extra-Small")){ %> checked <% } %> >Extra-Small</input>
            <input type="checkbox" name="cat" value="Extra-Large" <% if(ar.contains("Extra-Large")){ %> checked <% } %> >Extra-Large</input>
        <br/><br/>
        Buy Price: <input type="number" name="buyp"  step="0.01" min="0" value=<%=rs.getString("buy_price")%> /><br/><br/>
        First Bid: <input type="number" name="firstb"  step="0.01" min="0" value=<%=rs.getString("first_bid")%> /><br/><br/>
        Location: <input type="text" name="loc" value=<%=rs.getString("location")%> /><br/><br/>
        Country: <input type="text" name="country" value=<%=rs.getString("country")%> /><br/><br/>
        Description: <input type="text" name="desc" value=<%=rs.getString("description")%> /><br/><br/>
        <% 
        
        String s=rs.getString("ends");
        String s1=s.substring(0,10);
        String s2=s.substring(11,19);
        %>
        End of bid: <input type="date" name="dt" value=<%=s1%> /> <input type="time" name="tm"  value=<%=s2%> step="1"/><br/><br/>
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
