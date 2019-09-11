<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%
    Class.forName("com.mysql.jdbc.Driver");
    java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
    Statement st_msg = con.createStatement();
    Statement st_item = con.createStatement();
    ResultSet rs_msg, rs_item;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>biddit - Inbox</title>
        <link rel="stylesheet" href="./css/homepage.css">
        <link rel="stylesheet" href="./css/inbox.css">
        <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            $(function () {
                $("#header").load("./jsp/header.jsp");
            });
            <% session.removeAttribute("active_tab"); %>

            $(document).ready(function () {
                var showChar = 150;
                var ellipsestext = "...";
                var moretext = "more";
                var lesstext = "less";
                $('.more').each(function () {
                    var content = $(this).html();
                    if (content.length > showChar) {
                        var c = content.substr(0, showChar);
                        var h = content.substr(showChar, content.length - showChar);
                        var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink" style="color: ##4f4f51">' + moretext + '</a></span>';
                        $(this).html(html);
                    }
                });

                $(".morelink").click(function () {
                    if ($(this).hasClass("less")) {
                        $(this).removeClass("less");
                        $(this).html(moretext);
                    } else {
                        $(this).addClass("less");
                        $(this).html(lesstext);
                    }
                    $(this).parent().prev().toggle();
                    $(this).prev().toggle();
                    return false;
                });
            });
        </script>
        <style>
            .dropdown-content {
                display: none;
                position: fixed;
                background-color: #f1f1f1;
                min-width: 170px;
                text-align: left;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                background-color: transparent;
            }

            .dropdown-content a:hover {background-color: #ddd; }
        </style>
    </head>
    <body>
        <%  if ((session.getAttribute("user_type") == null) || ((session.getAttribute("user_type") != null) && ((session.getAttribute("user_type").equals("admin")) || (session.getAttribute("user_type").equals("visitor"))))) {
                response.sendRedirect("homepage");
            } %>

        <%  if (session.getAttribute("error") != null) {
                if (session.getAttribute("error").equals("msg")) { %>
        <script type="text/javascript"> alert("You cannot communicate with this user. There is not a registered bid with this credentials.");</script>            
        <%      }
                session.removeAttribute("error");
            }%>
        <div id="header"> </div>
        <div class="main_body">
            <div class="tab">
                <button class="tablinks" id="default" onclick="openTab(event, 'Inbox')">Inbox</button>
                <button class="tablinks" onclick="openTab(event, 'Sent')">Sent</button>
                <button class="tablinks" id="msg_button">Write Message</button>
                <div id="msg_modal_id" class="msg_modal" style="z-index: 99;">
                    <form class="msg_modal-content" action="msg_submit" method ="post" name="msg_box" style="background: url(./img/background.png); background-size: 50%;">
                        <span class="close">&times;</span>
                        <input type="text" id="receiver" name="receiver" placeholder="Username" required>
                        <input type="text" id="itemid" name="itemid" placeholder="Item ID" required>
                        <textarea id="content" name="content" placeholder="Write your message.." style="height:200px" required></textarea>
                        <input type="image" name="submit" src="./img/icons/send_icon.png" border="0" alt="Submit" style="width: 50px;" />
                    </form>
                </div>
            </div>
            <div id="Inbox" class="tabcontent">
                <div class="table-wrapper">
                    <table class="table table-striped table-hover" style="border-radius: 10px;">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Item</th>
                                <th>Date</th>
                                <th>Message</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% rs_msg = st_msg.executeQuery("select * from messages where receiver_uname='" + (String) session.getAttribute("user") + "' and (deleted_for IS NULL or deleted_for!='" + (String) session.getAttribute("user") + "') ORDER BY time DESC");
                                while (rs_msg.next()) {
                                    if (rs_msg.getString("viewed").equals("N")) { %> <tr style="font-weight:bold"> <% } else { %> <tr> <% }%>
                                <td> <%= rs_msg.getString("sender_uname")%> </td>
                                <td> <% rs_item = st_item.executeQuery("select name from item where item_id = '" + rs_msg.getString("item_id") + "' limit 1;");
//                                    while (rs_item.next()) {
                                    if (rs_item.next()) {%>
                                    <%= rs_item.getString("name")%>
                                    <% }%>
                                </td>
                                <td> <%= rs_msg.getString("time")%> </td>
                                <td class="comment more" width="50%" style="text-align: justify;"> <%= rs_msg.getString("content")%> </td>
                                <td>
                                    <a href="msg_markread?msg_id=<%= rs_msg.getString("msg_id")%>"><i class="material-icons" data-toggle="tooltip" title="Delete" style="color: #2c2b30">
                                            <% if (rs_msg.getString("viewed").equals("N")) {%>
                                            &#xe837;
                                            <% } else { %>
                                            &#xe836;                                                                       
                                            <% }%>
                                        </i></a> 
                                    <a href="msg_delete?msg_id=<%= rs_msg.getString("msg_id")%>" class="confirmation"><i class="material-icons" data-toggle="tooltip" title="Delete" style="color: #2c2b30">&#xE872;</i></a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="Sent" class="tabcontent">
                <div class="table-wrapper">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Item</th>
                                <th>Date</th>
                                <th>Message</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% rs_msg = st_msg.executeQuery("select * from messages where sender_uname='" + (String) session.getAttribute("user") + "' and deleted_for IS NULL or deleted_for!='" + (String) session.getAttribute("user") + "' ORDER BY time DESC");
                                while (rs_msg.next()) {%>
                            <tr>
                                <td> <%= rs_msg.getString("receiver_uname")%> </td>
                                <td> <% rs_item = st_item.executeQuery("select name from item where item_id = '" + rs_msg.getString("item_id") + "' limit 1;");
                                    while (rs_item.next()) {%>
                                    <%= rs_item.getString("name")%>
                                    <% }%>
                                </td>
                                <td> <%= rs_msg.getString("time")%> </td>
                                <td class="comment more" width="50%"> <%= rs_msg.getString("content")%> </td>
                                <td>
                                    <a href="msg_delete?msg_id=<%= rs_msg.getString("msg_id")%>" class="confirmation"><i class="material-icons" data-toggle="tooltip" title="Delete" style="color: #2c2b30">&#xE872;</i></a>
                                </td>
                            </tr>
                            <% }%>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script type="text/javascript">

            document.addEventListener("DOMContentLoaded", function (event) {
                document.getElementById("default").click();
            });

            var msg_modal = document.getElementById("msg_modal_id");
            var msg_btn = document.getElementById("msg_button");
            var msg_span = document.getElementsByClassName("close")[0];
            msg_btn.onclick = function () {
                msg_modal_id.style.display = "block";
            }
            msg_span.onclick = function () {
                msg_modal_id.style.display = "none";
            }
            window.onclick = function (event) {
                if (event.target == msg_modal) {
                    msg_modal_id.style.display = "none";
                }
            }

            var elems = document.getElementsByClassName('confirmation');
            var confirmIt = function (e) {
                if (!confirm('Are you sure you want to delete this message?'))
                    e.preventDefault();
            };
            for (var i = 0, l = elems.length; i < l; i++) {
                elems[i].addEventListener('click', confirmIt, false);
            }

            function openTab(evt, tab_type) {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }
                document.getElementById(tab_type).style.display = "block";
                evt.currentTarget.className += " active";
            }
        </script>
        <% con.close(); %>
    </body>
</html>