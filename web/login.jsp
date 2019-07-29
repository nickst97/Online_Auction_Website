<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Login</title>
    </head>
    <body>
        <%@ page import="java.sql.*"%>
        <%@ page import="javax.sql.*"%>
        <%
            String uname = request.getParameter("usr");
            session.putValue("uname", uname);
            String pwd = request.getParameter("pwd");
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "king", "");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from Users where uname='" + uname + "'");
            if (rs.next()) {
                if (rs.getString(3).equals(pwd)) {
                    out.println("Welcome " + uname + " !");
                } else {
                    out.println("Invalid password try again" + pwd);
                }
            } else
        %>
        <a href="index.html">Home</a>
    </body>
</html>
