
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Create bid</title>
        <%@ page import ="java.sql.*" %>
        <%@ page import ="javax.sql.*" %>
    </head>
    <body>
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
        <!-- Bid creation -->
        <form action="CreateBid" method="post">
        Create a bid: <br/><br/>
        Name: <input type="text" name="name" placeholder="Bid name" required /><br/><br/>
        Categories: </br>
        <%  Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC","root","");
            Statement st = con.createStatement();
            ResultSet rs=st.executeQuery("SELECT * FROM category_labels"); 
            while(rs.next()){ %>
            <input type="checkbox" name="cat" value=<%=rs.getString("category_name")%> ><%=rs.getString("category_name")%></input>
        <% } %>    
        <br/><br/>
        Buy Price: <input type="number" name="buyp" step="0.01" min="0" placeholder="ex 1.5" required/><br/><br/>
        First Bid: <input type="number" name="firstb" step="0.01" min="0" placeholder="ex 1.5" required/><br/><br/>
        Location: <input type="text" name="loc" placeholder="ex Athens" required/><br/><br/>
        Country: <input type="text" name="country" placeholder="ex Greece" required/><br/><br/>
        Description: <input type="text" name="desc" placeholder="Type a description of the item" required/><br/><br/>
        End of bid: <input type="date" name="dt" required /> <input type="time" name="tm" step="1" required/><br/><br/>
        Attach images: <input type="file" name="img" multiple /><br/><br/>
        Start bid: <br/> <br/>
        <input type="radio" name="start" value="Yes" checked>Yes<br/><br/>
        <input type="radio" name="start" value="No">No<br/><br/>
        <br/><br/>
        Create bid:<input type="submit" name="create" value="Submit bid"/><br/><br/>
        </form>
    </body>
</html>
