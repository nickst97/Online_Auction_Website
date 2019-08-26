<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>biddit - Welcome!</title>
        <link rel="stylesheet" href="/css/homepage.css">
        <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<!--        <script>// this doesnt work
            $(function () {
                $("#header").load("../header.jsp");
            });
        </script>-->
    </head>
    <body>

        <div class="header">
            <a class="logo" href="#">
                <img alt="homepage" src="./img/logo/logo_350x150.png">
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
                <% if (session.getAttribute("user_type").equals("visitor")) { %>
                <div class="icon">
                    <img src="./img/icons/profile_icon.png">
                    <div class="overlay">
                        <a href="profile.html" class="icon_hover"><img src="./img/icons/profile_icon_hover.png"></a>
                    </div>
                </div>

                <!--                if verified user-->
                <% } else { %>
                <a href="./inbox.jsp"><img id="chat_icon" src="./img/icons/chat_icon_v2.png" alt="Messages" title="Messages"></a>
                <a href="LogoutServlet"><img  id="exit_icon" src="./img/icons/exit_icon_v2.png"  alt="Sign Out" title="Sign Out"></a>
                <% }%>
            </div>
        </div>
        <div class="main_body">
            
        </div>
    </body>
</html>
