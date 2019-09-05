<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>biddit - Welcome!</title>
        <link rel="stylesheet" href="./css/header.css">
        <link rel="stylesheet" href="./css/advanced_search.css">
        <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
        <script src='https://kit.fontawesome.com/a076d05399.js'></script>
        <style>
            <%if (session.getAttribute("active_tab") != null) {
                    if (session.getAttribute("active_tab").equals("tab_1")) {%>
            #createbids{    
                background-color: transparent;
                border-bottom: 3px solid var(--site_orange);
            }
            <%      } else if (session.getAttribute("active_tab").equals("tab_2")) {%>
            #navigate{    
                background-color: transparent;
                border-bottom: 3px solid var(--site_orange);
            }
            <%      } else if (session.getAttribute("active_tab").equals("tab_3")) {%>
            #navigatebids{    
                background-color: transparent;
                border-bottom: 3px solid var(--site_orange);
            }
            <% } } %>
        </style>
    </head>
    <body>
        <div class="header">
            <a class="logo" href="homepage">
                <img alt="homepage" title="biddit" src="./img/logo/logo_350x150.png">
            </a>
            <div class="search-container">
                <form action="./searchres.jsp" method="post">
                    <button type="submit" class="search_button" name="sbm" value="Submit"><img src="./img/icons/search_icon.png" height="18"></button>
                    <input name="formn" type="hidden" value="f6"/>
                    <input type="text" placeholder="What are you looking for?" name="kwd" required/>
                    <select class="dropdown" name="cat">
                        <option value="all" name="cat" selected>All Categories<i class='fas fa-sort-down'></i></option>
                        <%
                            Class.forName("com.mysql.jdbc.Driver");
                            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTCjdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                            Statement st = con.createStatement();
                            ResultSet rs = st.executeQuery("SELECT * FROM category_labels ORDER BY category_name;");
                            while (rs.next()) {
                        %>
                        <option value=<%=rs.getString("category_name")%> ><%=rs.getString("category_name")%></option>
                        <%
                            }
                        %>    
                    </select>
                </form>
            </div>
            <div class="icon_list">
                <!--                if visitor-->
                <% if (session.getAttribute("user_type").equals("visitor")) {
                        session.setAttribute("registration_tab", "Y");
                %>
                <a href="startpage.jsp"><img  id="signup_icon" src="./img/icons/signup_icon.png"  alt="Sign Up" title="Become a user!"></a>
                <!--                if admin-->
                <%} else if (session.getAttribute("user_type").equals("admin")) {
                %>
                <a href="LogoutServlet"><img  id="exit_icon" src="./img/icons/exit_icon_v2.png"  alt="Sign Out" title="Sign Out"></a>
                
                
                <!--                if verified user-->
                <% } else { %>

                <!-- removed - to vrika perrito telika
                <div class="mybids_options">
                    <button class="dropbtn"><img  src="./img/icons/mybids_icon.png" alt="My Bids" title="My Bids"></button>
                    <div class="dropdown-content">
                        <a href="./createbids.jsp">Create a Bid</a>
                        <a href="./navigatebids.jsp">View my Live Bids</a>
                        <a href="./editbids.jsp">Edit my Bids</a>
                    </div>
                </div> -->
                <%  Class.forName("com.mysql.jdbc.Driver");
                    st = con.createStatement();
                    rs = st.executeQuery("select * from messages where viewed = 'N' and receiver_uname = '" + session.getAttribute("user") + "' and (deleted_for != '" + session.getAttribute("user") + "' or deleted_for is NULL) limit 1 ;");
                    if (rs.next()) {
                %> <a href="./inbox.jsp"><img id="chat_icon_unread" src="./img/icons/chat_icon_v2_unread.png" alt="Messages" title="Messages"></a> <%
                } else {
                    %> <a href="./inbox.jsp"><img id="chat_icon" src="./img/icons/chat_icon_v2.png" alt="Messages" title="Messages"></a> <%
                        } %>
                <a href="LogoutServlet"><img  id="exit_icon" src="./img/icons/exit_icon_v2.png"  alt="Sign Out" title="Sign Out"></a>
                    <% }%>
            </div>
            <div class="second_row">
                <ul class="nav">
                    <%
                        if (session.getAttribute("user_type").equals("visitor") || session.getAttribute("user_type").equals("admin")) {
                    %>
                    <li><a id="navigate">advanced search</a></li>
                        <%
                        } else {
                        %>
                    <li><a href="createbids.jsp" id="createbids">create bid</a></li>
                    <li><a id="navigate">advanced search</a></li>
                    <li><a href="navigatebids.jsp" id="navigatebids">my live bids</a></li>
                        <%
                            }
                        %>
                </ul>
            </div>
        </div>
        <div id="myModal" class="modal" style="z-index: 99;">
            <div class="modal-content">
                <span class="close">&times;</span>
                <form action="searchres.jsp" method="post" class="search_form">
                    <div id="field">
                        <span id="field_title">Categories</span>
                        <select class="field" id="select" name="cat">
                            <option value="" disabled selected>Select Category</option>
                            <%
                                Statement st_1 = con.createStatement();
                                ResultSet rs_1 = st_1.executeQuery("SELECT * FROM category_labels ORDER BY category_name;");

                                while (rs_1.next()) {
                            %>
                            <option name="cat" value=<%=rs_1.getString("category_name")%> ><%=rs_1.getString("category_name")%></option>
                            <%
                                }
                            %>    
                        </select>
                        <input name="formn" type="hidden" value="f1" />
                        <button type="submit" name="sbm" value="Submit" class="button button-block"><i class="fa fa-arrow-circle-right"></i></button>
                    </div>
                </form>
                <form action="searchres.jsp" method="post" class="search_form">
                    <div id="field">
                        <span id="field_title">Location</span>
                        <input type="text" name="loc" name="name" placeholder="Insert a location...">
                        <input name="formn" type="hidden" value="f3" >
                        <button type="submit" name="sbm" value="Submit" class="button button-block"><i class="fa fa-arrow-circle-right"></i></button>
                    </div>
                </form>
                <form action="searchres.jsp" method="post" class="search_form">
                    <div id="price">
                        <span id="field_title">Price Range</span>
                        <input type="number" name="price_from" step="0.01" min="0" placeholder="from">
                        <input type="number" name="price_to" step="0.01" min="0" placeholder="to">
                        <input name="formn" type="hidden" value="f5" />
                        <button type="submit" name="sbm" value="Submit" class="button button-block"><i class="fa fa-arrow-circle-right"></i></button>
                    </div>
                </form>
            </div>
        </div>
        <script type="text/javascript">
            var modal = document.getElementById("myModal");
            var btn = document.getElementById("navigate");
            var span = document.getElementsByClassName("close")[0];
            btn.onclick = function () {
                modal.style.display = "block";
            }
            span.onclick = function () {
                modal.style.display = "none";
            }
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }

        </script>
    </body>
</html>