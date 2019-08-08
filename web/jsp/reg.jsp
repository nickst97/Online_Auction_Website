<<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
            String password_repeat = request.getParameter("pwd2");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String tin = request.getParameter("tin");
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root","");
            Statement st = con.createStatement();

            //username availability checking
            ResultSet res = st.executeQuery("SELECT * FROM Users WHERE uname = '" + uname + "' LIMIT 1");
            if (res.next()) {
        %>
        <script type="text/javascript">
            alert("Username already taken.");
            history.go(-1);
        </script>
        <%
        } else {

            //password equality checking
            if (!password.equals(password_repeat)) {
        %>
        <script type="text/javascript">
            alert("Passwords do not match.");
            history.go(-1);
        </script>
        <%
                } else {
                    //update database
                    int i = st.executeUpdate("insert into Users (uname, password, fname, lname, email, phone, address, tin) values ('" + uname + "', '" + password + "', '" + fname + "', '" + lname + "', '" + email + "', '" + phone + "', '" + address + "', '" + tin + "')");
                    out.println("Registered");
                    response.sendRedirect("../startpage.html");
                }
            }
        %>
        <a href ="login.html">Login</a><br/><br/>
        <a href="index.html">Home</a>
    </body>
</html>


