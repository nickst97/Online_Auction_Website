<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>biddit - Welcome!</title>
        <link rel="stylesheet" href="./css/homepage.css">
        <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
    </head>
    <body>
        <div class="header">
            <a class="logo" href="homepage">
                <img alt="homepage" title="biddit" src="./img/logo/logo_350x150.png">
            </a>
            <div class="search-container">
                <form action="/action_page.php">
                    <button type="submit" class="search_button"><img src="./img/icons/search_icon.png" height="18"></button>
                    <input type="text" placeholder="What are you looking for?" name="search">
                    <button type="submit" class="dropdown">Dropdown</button>
                </form>
            </div>
            <div class="icon_list">
                <!--                if visitor-->
                <% if (session.getAttribute("user_type").equals("visitor")) {
                        session.setAttribute("registration_tab", "Y");
                %>
                    <a href="startpage.jsp"><img  id="signup_icon" src="./img/icons/signup_icon.png"  alt="Sign Up" title="Become a user!"></a>
                <!--                if verified user-->
                <% } else {
                    Class.forName("com.mysql.jdbc.Driver");
                    java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "king", "");
                    Statement st = con.createStatement();
                    ResultSet rs;
                    rs = st.executeQuery("select * from messages where viewed = 'N' and receiver_uname = '" + session.getAttribute("user") + "' and (deleted_for != '" + session.getAttribute("user") + "' or deleted_for is NULL) limit 1 ;");
                    if(rs.next()){
                        %> <a href="./inbox.jsp"><img id="chat_icon_unread" src="./img/icons/chat_icon_v2_unread.png" alt="Messages" title="Messages"></a> <%
                    }
                    else{
                        %> <a href="./inbox.jsp"><img id="chat_icon" src="./img/icons/chat_icon_v2.png" alt="Messages" title="Messages"></a> <%
                    } %>
                    <a href="LogoutServlet"><img  id="exit_icon" src="./img/icons/exit_icon_v2.png"  alt="Sign Out" title="Sign Out"></a>
                <% }%>
            </div>
        </div>
    </body>
</html>
