<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>biddit - Welcome!</title>
        <link rel="stylesheet" href="./css/homepage.css">
        <link rel="stylesheet" href="./css/item_view.css">
        <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script>
            $(function () {
                $("#header").load("./jsp/header.jsp");
            });
            <% session.removeAttribute("active_tab"); %>
        </script>
    </head>
    <body>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM item WHERE item_id = '" + request.getParameter("item_id") + "'");
        %>
        <div id="header" > </div>
        <div class="main_body">
            <% if (rs.next()) {%>
            <div class="page_title">
                <span><%=rs.getString("name")%></span>
            </div>
            <div class="item_container" id="item_container_id">
                <div class="photo_gallery">

                    <div class="img_container">
                        <img id="expandedImg" style="height:200px">
                    </div>

                    <%
                        Statement photors_st = con.createStatement();
                        ResultSet photors = photors_st.executeQuery("SELECT * FROM photo WHERE item_id = '" + rs.getString("item_id") + "'");
                        String phids;
                        if (photors.next()) {
                            phids = photors.getString("photo_id");
                    %>
                    <div class="column">
                        <img src="./ImageRetrieve?ph=<%=phids%>" id="default" style="height: 50px" onclick="myFunction(this);">
                    </div>
                    <%
                            } else{ %>
                            <div class="column">
                        <img src="./img/no_image.png" id="default" style="height: 50px" onclick="myFunction(this);">
                            </div>
                    <% }
                        while (photors.next()) {
                            phids = photors.getString("photo_id");
                    %>
                    <div class="column">
                        <img src="./ImageRetrieve?ph=<%=phids%>" style="height: 50px" onclick="myFunction(this);">
                    </div>
                    <%
                        }
                    %>
                </div>

                <div class="info_section">
                    <div class="title">
                        <span> <%=rs.getString("seller_id")%> </span>
                    </div>
                    <div class="half_panel" style="float: left;">
                        Best Offer: <%=rs.getString("currently")%> </br>
                        Buy Price: <%=rs.getString("buy_price")%> </br>
                        First Bid: <%=rs.getString("first_bid")%> </br>
                        Number of Bids: <%=rs.getString("number_of_bids")%> </br>
                    </div>
                    <div class="half_panel" style="float: right;">
                        <%=rs.getString("location")%>, <%=rs.getString("country")%> </br>
                        <% 
                        String temploc=rs.getString("location");
                        String[] temploc_2=temploc.split("\\s+");
                        String qr="";
                        for(int kl=0;kl<temploc_2.length;kl++){
                            qr=qr+temploc_2[kl];
                            qr=qr+"%20";
                        }
                        String tempcou=rs.getString("country");
                        String[] tempcou_2=tempcou.split("\\s+");
                        for(int kl=0;kl<tempcou_2.length;kl++){
                            qr=qr+tempcou_2[kl];
                            qr=qr+"%20";
                        }
                        String hr="https://www.openstreetmap.org/search?query="+qr;
                        %>
                        <a href="<%=hr%>" target="_blank" >click to view map</a> </br> 
                        Start Date: <%=rs.getString("started")%> </br>
                        End Date: <%=rs.getString("ends")%> </br>
                    </div>
                    <div class="full_panel" style="min-height: 100px; font-style: italic;  ">
                        <%=rs.getString("description")%>.

                        </br>
                        </br>

                        <%
                            Statement catrs_st = con.createStatement();
                            ResultSet catrs = catrs_st.executeQuery("SELECT * FROM category WHERE item_id = " + rs.getString("item_id") + "");
                            if (catrs.next()) {
                        %>
                        <%=catrs.getString("category_name")%>
                        <%
                            }
                            while (catrs.next()) {
                        %>
                        , <%=catrs.getString("category_name")%>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            <%
                if (session.getAttribute("user") != null) {
                    if (!session.getAttribute("user").equals(rs.getString("seller_id"))) {
            %>
            <div class="placebid_button_container" style="background: url(./img/background.png); background-size: 50%;">
                <%
                    Object o = session.getAttribute("user");
                    String usr = (String) o;
                    Statement st_4 = con.createStatement();
                    ResultSet bidrs = st_4.executeQuery("SELECT * FROM bidder WHERE user_id = '" + usr + "'");
                    double minval = Double.parseDouble(rs.getString("currently"));
                    minval = minval + 0.01;
                %>
                <form action="UploadBid" method="post" id="placebid_button_form" onsubmit="return confirm('Are you sure?');">
                    <div id="custom_box">
                        <input name="item_id" type="hidden" value=<%=rs.getString("item_id")%> />
                        <% if (!bidrs.isBeforeFirst()) { %>
                                Location: <input type="text" name="loc" placeholder="ex Athens" required/><br/>
                                Country: <input type="text" name="country" placeholder="ex Greece" required/><br 
                        <%  } %>
                        <input type="number" name="buyp" step="0.01" min=<%=minval%> max=<%=rs.getString("buy_price")%> placeholder="0.00" required>
                        <input type="submit" name="sbm" id="placebid_id" value="Place bid!" >
                    </div>
                </form>
            </div>
            <%
            } else if (((rs.getString("hasstarted").equals("0")) || (rs.getString("number_of_bids").equals("0"))) && (!rs.getString("hasstarted").equals("2"))) {
            %>
            <script>
                document.getElementById('item_container_id').setAttribute("style", "padding-bottom: 40px");
            </script>
            <div class="edit_button">
                <a href="editbids.jsp?item_id=<%=rs.getString("item_id")%>">
                    <img src="./img/icons/edit_icon.png" title="Edit this item" style="width:60px;height:60px;border:0;">
                </a>
            </div>
            <div class="delete_button">
                <form action="EditBid" method="post" onsubmit="return confirm('Are you want to delete this item?');"> <!-- enctype="multipart/form-data">-->
                    <input type="submit" name="sbm" value="Delete" title="Delete this item" /><br/><br/>
                    <input name="item_id" type="hidden" value=<%=rs.getString("item_id")%> />
                </form>
                <% }
                else if ((!rs.getString("number_of_bids").equals("0")) && (!rs.getString("hasstarted").equals("2"))) {
            %>
            <script>
                document.getElementById('item_container_id').setAttribute("style", "padding-bottom: 40px");
            </script>
      

                <div class="page_title" style="margin-top: 430px; z-index: 2; z-index: -1;">
                    <span>Bids</span>
                </div>
                <%
                    Statement st_3 = con.createStatement();
                    ResultSet bidsrs = st_3.executeQuery("SELECT * FROM bid WHERE item_id = '" + rs.getString("item_id") + "' ORDER BY amount DESC;");
                %>
                <div class="bidder_container">
                    <%
                        while (bidsrs.next()) {
                            Statement st_5 = con.createStatement();
                            ResultSet bidderrs = st_5.executeQuery("SELECT * FROM bidder WHERE user_id= '" + bidsrs.getString("user_id") + "'");
                            if(bidderrs.next()){
                    %>
                    <span class="bidder_title"> <%=bidderrs.getString("user_id")%> </span> </br>
                    <span class="bidder_info"> <%=bidderrs.getString("location")%>, <%=bidderrs.getString("country")%> </span>
                    <span class="bidder_info"> <%=bidsrs.getString("time")%> </span>
                    <span class="bidder_info"> <%=bidsrs.getString("amount")%> </span>
                    </br>
                    </br>
                <% }}
                %>
                </div>
                <%
                    }
                            }
                        }
                    
                %>
            </div>
            <script>
                document.addEventListener("DOMContentLoaded", function (event) {
                    document.getElementById("default").click();
                });

                function myFunction(imgs) {
                    var expandImg = document.getElementById("expandedImg");
                    expandImg.src = imgs.src;
                    expandImg.parentElement.style.display = "block";
                }

            </script>
    </body>
</html>
