<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>biddit - Search Results</title>
        <link rel="stylesheet" href="./css/homepage.css">
        <link rel="stylesheet" href="./css/items_list_view.css">
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

            <div class="page_title">
                <span>Search Results</span>
            </div>
            <%
                Statement st = con.createStatement();
                Statement st_2 = con.createStatement();
                Statement st_3 = con.createStatement();
                Statement st_4 = con.createStatement();
                Statement st_img = con.createStatement();
                String val = request.getParameter("formn");
                ResultSet rs = null;
                ResultSet cattrs = null;
                // if category input
                if (val.equals("f1") || val.equals("f2")) {   //category input
                    String cat = request.getParameter("cat");
                    cattrs = st.executeQuery("SELECT * FROM category WHERE category_name = '" + cat + "'");
                    if (!cattrs.isBeforeFirst()) {

            %> <div class="no_results">
                <span>No results here :(</span>
            </div> <%            }
                int times = 0;
            %> <div class="flex-container"> <%
                while (cattrs.next()) {
                    int valll = 1;
                    String teidi = cattrs.getString("item_id");
                    int itm = Integer.valueOf(teidi);
                    ResultSet rs_2 = st_4.executeQuery("SELECT * FROM item WHERE item_id = '" + itm + "' AND hasstarted = '" + valll + "' ");

                    while (rs_2.next()) {
                        times = times + 1;
                        String idi = rs_2.getString(1);
                        int id = Integer.valueOf(idi);
                %>
                <!--output category input results-->

                <div id="up_transition">

                    <a href="item_view.jsp?item_id=<%=rs_2.getString("item_id")%>">

                        <div class="item_box">
                            <%
                                ResultSet photors = st_img.executeQuery("SELECT * FROM photo WHERE item_id = '" + id + "' limit 1");
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
                                <%=rs_2.getString("name")%>
                            </div>
                            <div class="box_info">
                                <div class="item_info">
                                    <div class="row">
                                        <div id="left">
                                            <u>Best Offer:</u> </br>
                                                <%=rs_2.getString("currently")%>
                                        </div>
                                        <div id="right">
                                            <u>Buy Price:</u> </br>
                                                <%=rs_2.getString("buy_price")%>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div id="center">
                                            <%=rs_2.getString("location")%>, <%=rs_2.getString("country")%> </br>
                                            <%=rs_2.getString("ends")%>
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
                <%
                    }
                %>
            </div> <%
            } else {   //not category input
                int vall = 1;
                if (val.equals("f3")) {
                    String loc = request.getParameter("loc");
                    rs = st.executeQuery("SELECT * FROM item WHERE location LIKE '%" + loc + "%' OR country LIKE '%" + loc + "%' AND hasstarted = '" + vall + "' ");
                } else if (val.equals("f4")) {
                    String descr = request.getParameter("desc");
                    rs = st.executeQuery("SELECT * FROM item WHERE desc CONTAINS '" + descr + "' AND hasstarted = '" + vall + "' ");
                } else if (val.equals("f5")) {
                    String fl_from = request.getParameter("price_from");
                    float f_from = Float.parseFloat(fl_from);
                    String fl_to = request.getParameter("price_to");
                    float f_to = Float.parseFloat(fl_to);
                    rs = st.executeQuery("SELECT * FROM item WHERE buy_price > '" + f_from + "' AND  buy_price < '" + f_to + "' AND hasstarted = '" + vall + "' ");
                } else if (val.equals("f6")) {
                    String kwd = request.getParameter("kwd");
                    String cat = request.getParameter("cat");
                    if (cat.equals("all")) {
                        rs = st.executeQuery("SELECT * FROM item WHERE description LIKE '%" + kwd + "%' or name LIKE '%" + kwd + "%'");
                    } else {
                        rs = st.executeQuery("SELECT * FROM item WHERE description LIKE '%" + kwd + "%' or name LIKE '%" + kwd + "%' and item_id in (select item_id from category where category_name = '" + cat + "');");
                    }
                } %>

            <%        if (!rs.isBeforeFirst()) {
            %> <div class="no_results">
                <span>No results here :(</span>
            </div> <%
                }
            %>
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
                                ResultSet photors = st_img.executeQuery("SELECT * FROM photo WHERE item_id = '" + id + "' limit 1");
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
            <%
                }// if
            %>
        </div>
    </body>
</html>