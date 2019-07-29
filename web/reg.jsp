<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Registration</title>
    </head>
    <body>
        <%@ page import ="java.sql.*" %>
        <%@ page import ="javax.sql.*" %>
        <%
            String uname = request.getParameter("uname");
            String password = request.getParameter("pwd1");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String tin = request.getParameter("tin");
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
                    "king", "");
            Statement st = con.createStatement();
            ResultSet rs;
            int i = st.executeUpdate("insert into Users (uname, password, fname, lname, email, phone, address, tin) values ('" + uname + "', '" + password + "', '" + fname + "', '" + lname + "', '" + email + "', '" + phone + "', '" + address + "', '" + tin + "')");

            out.println("Registered");


        %>
        <a href ="Login.html">Login</a><br/><br/>
        <a href="index.html">Home</a>
    </body>
</html>


