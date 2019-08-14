<!DOCTYPE html>
<html lang="en" >
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
        <title>biddit - Welcome!</title>
        <link rel="stylesheet" href="./css/startpage.css">
    </head>
    <body>
        <%
            if (session.getAttribute("user_type") != null) {
                response.sendRedirect("homepage");
            }
        %>
        
        <% if (session.getAttribute("error") != null) { if (session.getAttribute("error").equals("uname")) { %>
        <script type="text/javascript"> alert("This username doesn't exist. Please try again!"); </script>            
        <% } }%>
        
        <% if (session.getAttribute("error") != null) { if (session.getAttribute("error").equals("pwd")) { %>
        <script type="text/javascript"> alert("Wrong password. Please try again!"); </script>            
        <% } }%>
        
        <div class="fadeIn first">
            <img src="./img/logo/logo_350x150.png" class="logo" alt="Logo 350x150"/>
        </div>
        <div class="form">
            <ul class="tab-group">
                <li class="tab active"><a href="#login">Log In</a></li>
                <li class="tab"><a href="#signup">Sign Up</a></li>
            </ul>

            <div class="tab-content">
                <div id="login">    
                    <form action="LoginServlet" method="post">

                        <div class="field-wrap">
                            <input type="text" placeholder="Username" name="usr" required/>
                        </div>

                        <div class="field-wrap">

                            <input type="password" placeholder="Password" name="pwd" required/>
                        </div>
                        <button class="button button-block" type="submit"/>Log In!</button>
                    </form>

                </div>

                <div id="signup">   
                    <form action="./jsp/reg.jsp" method="post" name="register_form">

                        <div class="field-wrap">
                            <input type="text" placeholder="Username" name="uname" required/>

                        </div>

                        <div class="top-row">
                            <div class="field-wrap">
                                <input type="text" placeholder="First Name" name="fname" required/>

                            </div>

                            <div class="field-wrap">
                                <input type="text" placeholder="Last Name" name="lname" required/>

                            </div>
                        </div>

                        <div class="top-row">
                            <div class="field-wrap">
                                <input type="password" placeholder="Password" name="pwd1" required/>

                            </div>

                            <div class="field-wrap">
                                <input type="password" placeholder="Repeat Password" name="pwd2" required/>

                            </div>
                        </div>

                        <div class="field-wrap">
                            <input type="text" placeholder="Email" name="email" required/>

                        </div>

                        <div class="field-wrap">
                            <input type="text" placeholder="Address" name="address" required/>

                        </div>

                        <div class="top-row">
                            <div class="field-wrap">
                                <input type="text" placeholder="Phone" name="phone" required/>

                            </div>

                            <div class="field-wrap">
                                <input type="text" placeholder="T.I.N." name="tin" required/>

                            </div>
                        </div>
                        <button type="submit" class="button button-block"/>LET'S SHOP!</button>

                    </form>

                </div>
            </div>

<<<<<<< HEAD:web/startpage.jsp
            <form action="LoginServlet" method="post">
                <input type="hidden" name="visitor_flag" value="Y"><br>
                <button class="visitor" type="submit"/>Just a visitor? Click here!</button>
            </form>
        </div>
=======


            </div><!-- tab-content -->
            <div class="visitor"><a href="homepage.jsp">Just a visitor? Click here!</a></div>

        </div> <!-- /form -->
        <!-- partial -->
>>>>>>> origin/master:web/startpage.html
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script  src="./js/script.js"></script>

    </body>
</html>