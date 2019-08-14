<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Verify User</title>
    </head>
    <body>
        <%@ page import="java.sql.*"%>
        <%@ page import="javax.sql.*"%>
        <%
            String uname = request.getParameter("profile_uname");
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "king", "");
            Statement st = con.createStatement();
            st.executeUpdate("UPDATE Users SET verified = 'Y' WHERE uname='" + uname + "'");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/users_preview.jsp");
            dispatcher.forward(request, response);
        %>
    </body>
</html>
