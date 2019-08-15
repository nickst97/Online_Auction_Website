
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Start Page</title>
    </head>
    <body>
        <a href="homepage.jsp">Home Page</a>
        <% if (session.getAttribute("user")!=null) { %>
        <a href="manage.jsp">Manage bids</a>
        <% } %>
        <a href="navigate.jsp">Search/Navigate bids</a>
        <% if (session.getAttribute("user")!=null) { %>
        <a href="./jsp/logout.jsp">Log-out</a>
        <% } else{ %>
        <a href="startpage.jsp">Log-in/Sign-up</a>
        <% } %>
    </body>
</html>