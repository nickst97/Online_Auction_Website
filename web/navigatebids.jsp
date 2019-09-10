<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>biddit - My live Bids</title>
        <link rel="stylesheet" href="./css/homepage.css">
        <link rel="stylesheet" href="./css/items_list_view.css">
        <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script>
            $(function () {
                $("#header").load("./jsp/header.jsp");
            });
            <% session.setAttribute("active_tab", "tab_3"); %>
        </script>
    </head>
    <body>
        <%
            if (session.getAttribute("user_type") == null) {
                session.setAttribute("user_type", "visitor");
            }
        %>
        <%
            if (session.getAttribute("user_type").equals("visitor")) {
                response.sendRedirect("homepage.jsp");
            }
        %>
        <% //check if end date has passed
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTCjdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            Statement st_10 = con.createStatement();
            int hasn = 2;
            ResultSet rs_10 = st_10.executeQuery("SELECT * FROM item WHERE hasstarted != '" + hasn + "'");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date datec = new Date();
            /* for every item */
            while (rs_10.next()) {
                String enddate = rs_10.getString("ends");
                Date edf = sdf.parse(enddate);
                /* if date passed */
                if (enddate.compareTo(sdf.format(datec)) < 0) {
                    Statement st_11 = con.createStatement();
                    int hasch = 2;
                    /* end it */
                    int lch = st_11.executeUpdate("UPDATE item SET hasstarted = '" + hasch + "' WHERE item_id= '" + rs_10.getString("item_id") + "'");
                    Statement st_12 = con.createStatement();
                    ResultSet rs_12 = st_12.executeQuery("SELECT * FROM item WHERE item_id = '" + rs_10.getString("item_id") + "'");
                    /* find item */
                    if (rs_12.next()) {
                        /* get current max */
                        float curr = Float.parseFloat(rs_12.getString("currently"));
                        Statement st_13 = con.createStatement();
                        ResultSet rs_13 = st_13.executeQuery("SELECT * FROM bid WHERE item_id = '" + rs_10.getString("item_id") + "'");
                        /* for every bid of this item */
                        while (rs_13.next()) {
                            float amount = Float.parseFloat(rs_13.getString("amount"));
                            /* if max,won */
                            if (Float.compare(curr, amount) == 0) {
                                String seller = rs_12.getString("seller_id");
                                String usrw = rs_13.getString("user_id");
                                Statement st_14 = con.createStatement();
                                int lp = st_14.executeUpdate("insert into won (item_id,bidder,seller) values ('" + rs_10.getString("item_id") + "','" + usrw + "','" + seller + "')");
                                break;
                            }
                        }
                    }
                }
            }
            //ends here
        %> 

        <div id="header" > </div>  
        <div class="main_body">
            <%
                Object o = session.getAttribute("user");
                String usr = (String) o;
                Statement st = con.createStatement();
                Statement st_4 = con.createStatement();
                int val = 2;
                ResultSet rs = st.executeQuery("SELECT * FROM item WHERE seller_id = '" + usr + "' AND hasstarted != '" + val + "' ");
            %>
            <!-- Live bids navigation (hasstarted==1) -->

            <div class="page_title">
                <span> Live Bids of <%=usr%></span>
            </div>
            <div class="flex-container">
                <%
                    while (rs.next()) {
                        String idi = rs.getString(1);
                        int id = Integer.valueOf(idi);
                %>
                <div id="up_transition">

                    <a href="item_view.jsp?item_id=<%=rs.getString("item_id")%>">

                        <div class="item_box">
                            <%
                                ResultSet photors = st_4.executeQuery("SELECT * FROM photo WHERE item_id = '" + id + "' limit 1");
                                if (photors.next()) {
                                    String phids;
                                    phids = photors.getString("photo_id");
                            %>      <div class="item_photo" style="background-image: url('./ImageRetrieve?ph=<%=phids%>');"></div>
                            <%
                            } else {
                            %>      <div class="item_photo" style="background-image: url('./img/no_image.png');"></div>
                            <%
                                }
                            %>
                            <div class="box_title">
                                <%=rs.getString("name")%>
                            </div>
                            <div class="box_info">
                                <div class="item_info">
                                    <div class="row">
                                        <div id="left">
                                            <u>Best Offer:</u> </br>
                                                <%=rs.getString("currently")%>
                                        </div>
                                        <div id="right">
                                            <u>Buy Price:</u> </br>
                                                <%=rs.getString("buy_price")%>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div id="center">
                                            <%=rs.getString("location")%>, <%=rs.getString("country")%> </br>
                                            <%=rs.getString("ends")%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>