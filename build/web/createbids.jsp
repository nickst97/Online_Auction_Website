<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
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
        </script>
        <% session.setAttribute("active_tab", "tab_1"); %>

    </head>
    <body>
        <div id="header"> </div>
        <div class="main_body">
            <div class="page_title">
                <span>Upload your Item for Bidding</span>
            </div>
            <form action="CreateBid" method="post" class="creation_form" enctype="multipart/form-data">

                <!--Name-->
                <div class="field_options" id="box70">
                    <span id="field_title"> Item Title</span>
                    <input type="text" name="name" required>
                </div>

                <!--Categories-->
                <div class="field_options" id="box30_long">
                    <span id="field_title"> Choose Categories</span>
                    <div class="panel">
                        <div id="left">
                            <%                                Class.forName("com.mysql.jdbc.Driver");
                                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost/MyEbayDB?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery("SELECT * FROM category_labels ORDER BY category_name limit 15");
                                while (rs.next()) {
                            %>
                            <input type="checkbox" name="cat" value=<%=rs.getString("category_name")%> ><%=rs.getString("category_name")%> </input> </br>
                            <%
                                }
                            %>    
                        </div>
                        <div id="right">
                            <%
                                Class.forName("com.mysql.jdbc.Driver");
                                rs = st.executeQuery("SELECT * FROM category_labels ORDER BY category_name limit 15,30");
                                while (rs.next()) {
                            %>
                            <input type="checkbox" name="cat" value=<%=rs.getString("category_name")%> ><%=rs.getString("category_name")%> </input>  </br>
                            <%
                                }
                            %>    
                        </div>
                    </div>
                </div>

                <!--Buy Price-->
                <div class="field_options" id="box35">
                    <span id="field_title"> Buy Price</span>
                    <input type="number" name="buyp" step="0.01" min="0" required>
                </div>

                <!--First Bid-->
                <div class="field_options" id="box35">
                    <span id="field_title"> Start Price</span>
                    <input type="number" name="firstb" step="0.01" min="0" required>
                </div>

                <!--Location-->
                <div class="field_options" id="box35">
                    <span id="field_title"> City</span>
                    <input type="text" name="loc" required>
                </div>

                <!--Country-->
                <div class="field_options" id="box35">
                    <span id="field_title"> Country</span>
                    <input type="text" name="country" required>
                </div>

                <!--Description-->
                <div class="field_options" id="box70">
                    <span id="field_title"> Description</span>
                    <textarea type="text" name="desc" style="height: 93px;" required> </textarea>
                </div>

                <!--End of bid Date-->
                <div class="field_options" id="box30">
                    <span id="field_title"> Date</span>
                    <input type="date" name="dt" required>
                </div>

                <!--End of bid Time-->
                <div class="field_options" id="box30">
                    <span id="field_title"> Time</span>
                    <input type="time" name="tm" step="1" required>
                </div>

                <!--Images-->
                <div class="field_options" id="box35">
                    <span id="field_title"> Add Images</span>
                    <input type="file" name="img" multiple>
                </div>

                <!--Start Bid Option-->
                <div class="field_options" id="box_radio">
                    <span id="field_title"> Start Bid? </span>
                    <input type="radio" name="start" value="Yes" checked> Yes
                    <input type="radio" name="start" value="No"> No
                </div>
                <!--Coordinates-->
                <!--Submit Button-->
                <button type="submit" name="create" value="Submit bid" class="button button-block"/>Send your item!</button>
            </form>
        </div>
    </body>
</html>
