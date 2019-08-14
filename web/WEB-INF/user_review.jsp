<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - <% String uname = request.getParameter("profile_uname");
            out.print(uname);%></title>
        <link rel="stylesheet" href="./homepage.css">
        <link rel="stylesheet" href="./user_review.css">
    </head>
    <body>
        <%@ page import="java.sql.*"%>
        <%@ page import="javax.sql.*"%>

        <div class="header">
            <a class="logo" href="#">
                <img alt="homepage" src="./img/logo/logo_350x150.png">
            </a>
            <div class="welcome_box">
                User Administrator Page
            </div>
            <div class="icon_list">
                <div class="icon">
                    <img src="./img/icons/profile_icon.png">
                    <div class="overlay">
                        <a href="profile.html" class="icon_hover"><img src="./img/icons/profile_icon_hover.png"></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="main_body">
            <div class="row">
                <div class="column">

                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "king", "");
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery("select * from Users where uname='" + uname + "'");
                        rs.next();
                    %>
                    <table>
                        <tr>
                            <th><h1><%=rs.getString("uname")%> </h1></th>
                        </tr>
                        <tr>
                            <th>Name: </th>
                            <td> <%=rs.getString("fname") + " " + rs.getString("lname")%> </td>
                        </tr>
                        <tr>
                            <th>Email: </th>
                            <td> <%=rs.getString("email")%> </td>
                        </tr>
                        <tr>
                            <th>Phone: </th>
                            <td> <%=rs.getString("phone")%> </td>
                        </tr>
                        <tr>
                            <th>Address: </th>
                            <td> <%=rs.getString("address")%> </td>
                        </tr>
                        <tr>
                            <th>TIN: </th>
                            <td> <%=rs.getString("tin")%> </td>
                        </tr>
                        <%
                            rs.close();
                        %>
                    </table>
                </div>
                <div class="column" id="bid">
                    <h1>Bought items</h1> <br> <br> <br> <br>
                    <h1>Sold items</h1>
                </div>
            </div>
        </div>
    </body>
</html>
