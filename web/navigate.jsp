<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Search-Navigate Page</title>
        <%@ page import ="java.sql.*" %>
        <%@ page import ="javax.sql.*" %>
    </head>
    <body>
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
        <!-- choose category -->
         <form action="searchres.jsp" method="post">
        Choose a category:
        <select name="cat" >
            <%  Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root","");
            Statement st = con.createStatement();
            ResultSet rs=st.executeQuery("SELECT * FROM category_labels"); 
            while(rs.next()){ %>
            <option name="cat" value=<%=rs.getString("category_name")%> ><%=rs.getString("category_name")%></option>
        <% } %>  
        </select>
        <input name="formn" type="hidden" value="f1" />
        <input type="submit" name="sbm" value="Submit" />
        </form>
        <!-- choose category -->
        <form action="searchres.jsp" method="post">
            Category: <input type="text" name="cat" placeholder="ex Mens" required/>
            <input name="formn" type="hidden" value="f2" />
            <input type="submit" name="sbm" value="Submit" />
        </form>
        <!-- choose location -->
        <form action="searchres.jsp" method="post">
            Location: <input type="text" name="loc" placeholder="ex Greece" required/>
            <input name="formn" type="hidden" value="f3" />
            <input type="submit" name="sbm" value="Submit" />
        </form>
        <!-- choose description -->
        <form action="searchres.jsp" method="post">
            Description: <input type="text" name="desc" required/>
            <input name="formn" type="hidden" value="f4" />
            <input type="submit" name="sbm" value="Submit" />
        </form>
        <!-- choose buy price -->
         <form action="searchres.jsp" method="post">
            Price: <input type="number" name="price" step="0.01" min="0" placeholder="ex 1.5" required/>
            <input name="formn" type="hidden" value="f5" />
            <input type="submit" name="sbm" value="Submit" />
        </form>
    </body>
</html>
