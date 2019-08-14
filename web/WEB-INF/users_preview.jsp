<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Users Preview</title>
        <link rel="stylesheet" href="./css/homepage.css">
        <link rel="stylesheet" href="./css/users_preview.css">
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
            <%
                Class.forName("com.mysql.jdbc.Driver");
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "king", "");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM Users WHERE admin='N' ORDER BY id DESC");
            %>

            <table>
                <th>Username</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Verified</th>
                    <%
                        while (rs.next()) {
                    %>
                <!--            RequestDispatcher rd = getServletContext().getRequestDispatcher("/report?p="+value);
                rd.forward(request, response);   -->
                            <!--<tr onclick="window.location = '/WEB-INF/user_review.jsp?profile_uname=<%= rs.getString("uname")%>';">-->
                <tr onclick="window.location = 'user_review?visitor_flag=<%= rs.getString("uname")%>';">

                    <td>
                        <%=rs.getString("uname")%>
                    </td>
                    <td><%=rs.getString("fname")%></td>
                    <td><%=rs.getString("lname")%></td>
                    <td><%=rs.getString("email")%></td>
                    <%if (rs.getString("verified").equals("N")) {%>
                    <td>No</td>
                    <td bgcolor="#F8F9FB">
                        <a class="verify" href="./jsp/user_verify.jsp?profile_uname=<%= rs.getString("uname")%>">Click to verify this profile</a>
                    </td><%} else {%>
                    <td>Yes</td>
                    <%}%>
                </tr>

                <%
                    }
                    rs.close();
                %>
            </table>
        </div>
    </body>
</html>
