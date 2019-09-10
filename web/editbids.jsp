<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>biddit - Create Bid</title>
        <link rel="stylesheet" href="./css/homepage.css">
        <link rel="stylesheet" href="./css/createbids.css">
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
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM item WHERE item_id = '" + request.getParameter("item_id") + "'");
        %>
        <div id="header"> </div>
        <div class="main_body">.
            <%
                if (rs.next()) {
            %>
            <div class="page_title">
                <span>Edit your Item information</span>
            </div>
            <%
                session.setAttribute("itemid", rs.getString("item_id"));
                session.setAttribute("hasstarted", rs.getString("hasstarted"));
            %>
            <form action="EditBid" method="post" class="creation_form" enctype="multipart/form-data">
                <input name="item_id" type="hidden" value=<%=rs.getString("item_id")%> />
                <input name="hasstarted" type="hidden" value=<%=rs.getString("hasstarted")%> />
                <!--Name-->
                <div class="field_options" id="box70">
                    <span id="field_title"> Item Title</span>
                    <input type="text" name="name" value=<%=rs.getString("name")%> required>
                </div>

                <!--Categories-->
                <div class="field_options" id="box30_long">
                    <span id="field_title"> Choose Categories</span>
                    <div class="panel">
                        <%
                            Statement st_2 = con.createStatement();
                            ResultSet catrs = st_2.executeQuery("SELECT * FROM category WHERE item_id = '" + request.getParameter("item_id") + "'");
                            ArrayList<String> ar = new ArrayList<String>();
                            while (catrs.next()) {
                                ar.add(catrs.getString("category_name"));
                            }
                        %>
                        <div id="left">
                            <%
                                Statement st_5 = con.createStatement();
                                ResultSet rs_2 = st_5.executeQuery("SELECT * FROM category_labels limit 15");
                                while (rs_2.next()) {
                            %>
                            <input type="checkbox" name="cat" value=<%=rs_2.getString("category_name")%> <% if (ar.contains(rs_2.getString("category_name"))) { %> checked <% }%> ><%=rs_2.getString("category_name")%></input> </br>
                            <%
                                }
                            %>    
                        </div>
                        <div id="right">
                            <%
                                rs_2 = st_5.executeQuery("SELECT * FROM category_labels limit 15, 30");
                                while (rs_2.next()) {
                            %>
                            <input type="checkbox" name="cat" value=<%=rs_2.getString("category_name")%> <% if (ar.contains(rs_2.getString("category_name"))) { %> checked <% }%> ><%=rs_2.getString("category_name")%></input> </br>
                            <%
                                }
                            %>     
                        </div>
                    </div>
                </div>

                <!--Buy Price-->
                <div class="field_options" id="box35">
                    <span id="field_title"> Buy Price</span>
                    <input type="number" name="buyp" value=<%=rs.getString("buy_price")%> step="0.01" min="0" required>
                </div>

                <!--First Bid-->
                <div class="field_options" id="box35">
                    <span id="field_title"> Start Price</span>
                    <input type="number" name="firstb" value=<%=rs.getString("first_bid")%> step="0.01" min="0" required>
                </div>

                <!--Location-->
                <div class="field_options" id="box35">
                    <span id="field_title"> City</span>
                    <input type="text" name="loc" value=<%=rs.getString("location")%> required>
                </div>

                <!--Country-->
                <div class="field_options" id="box35">
                    <span id="field_title"> Country</span>
                    <input type="text" name="country" value=<%=rs.getString("country")%> required>
                </div>

                <!--Description-->
                <div class="field_options" id="box70">
                    <span id="field_title"> Description</span>
                    <textarea type="text" name="desc" style="height: 93px;" required><%=rs.getString("description")%> </textarea>
                </div>


                <%
                    String s = rs.getString("ends");
                    String s1 = s.substring(0, 10);
                    String s2 = s.substring(11, 19);
                %>
                <!--End of bid Date-->
                <div class="field_options" id="box30">
                    <span id="field_title"> Date</span>
                    <input type="date" name="dt" value=<%=s1%> required>
                </div>

                <!--End of bid Time-->
                <div class="field_options" id="box30">
                    <span id="field_title"> Time</span>
                    <input type="time" name="tm" value=<%=s2%>  step="1" required>
                </div>

                <!--Images-->
                <div class="field_options" id="box35">
                    <span id="field_title"> Add Images</span>
                    <input type="file" name="img" multiple>
                </div>
                
                <!--Start Bid Option-->
                <%
                    if (rs.getString("hasstarted").equals("1")) { %>
                <span id="field_title"> Bid already started</span>
                <% } else { %>
                <div class="field_options" id="box_radio">
                    <span id="field_title"> Start Bid? </span>
                    <input type="radio" name="start" value="Yes" checked> Yes
                    <input type="radio" name="start" value="No"> No
                </div>
                <% }%>
                <!--Submit Button-->
                <button type="submit" name="sbm" value="Edit" class="button button-block"/>Submit your edits</button>
            </form>
            <%
                }
            %>
        </div>
    </body>
</html>
