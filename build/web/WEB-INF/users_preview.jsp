<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Admin - Users Preview</title>
        <link rel="stylesheet" href="./css/homepage.css">
        <link rel="stylesheet" href="./css/users_preview.css">
        <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
    </head>
    <body>
        <div class="header" style="height: auto;">
            <a class="logo" href="homepage">
                <img alt="homepage" title="biddit" src="./img/logo/logo_350x150.png">
            </a>
            <div class="welcome_box">
                User Administrator Page
            </div>
            <div class="icon_list">
                <a href="LogoutServlet"><img  id="exit_icon" src="./img/icons/exit_icon_v2.png"  alt="Sign Out" title="Sign Out"></a>
            </div>
        </div>
        <div class="main_body">
            <%
                Class.forName("com.mysql.jdbc.Driver");
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM Users WHERE admin='N' ORDER BY id DESC");
            %>
            <div class="table_container">
                <table>
                    <th>Username</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Verified</th>
                        <%
                            while (rs.next()) {
                        %>
                    <tr onclick="window.location = 'user_review?profile_uname=<%= rs.getString("uname")%>';">

                        <td>
                            <%=rs.getString("uname")%>
                        </td>
                        <td><%=rs.getString("fname")%></td>
                        <td><%=rs.getString("lname")%></td>
                        <td><%=rs.getString("email")%></td>
                        <%if (rs.getString("verified").equals("N")) {%>
                        <td>No</td>
                        <td bgcolor="#F8F9FB">
                            <a class="verify" href="user_verify?profile_uname=<%= rs.getString("uname")%>">Click to verify this profile</a>
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
            <div class="buttons_container">
                <a class="dbutton dbutton-block" href="DownloadDTD"/>
                Download XML
                <font size="3">(DTD template)</font>
                </a>
                <a class="dbutton dbutton-block" href="DownloadJSON"/>
                Download XML
                <font size="3">(JSON template)</font>
                </a>
            </div>
        </div>
    </body>
</html>
