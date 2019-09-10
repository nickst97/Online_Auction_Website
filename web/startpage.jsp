<!DOCTYPE html>
<html lang="en" >
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>biddit - Welcome!</title>
        <link rel="stylesheet" href="./css/startpage.css">
        <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">            
        <% session.removeAttribute("active_tab"); %>
    </head>
    <body>
        <%
            if ((session.getAttribute("user_type") != null) && !(session.getAttribute("user_type").equals("visitor"))) {
                response.sendRedirect("homepage");
            }
        %>

        <%  if (session.getAttribute("error") != null) {
                if (session.getAttribute("error").equals("uname")) { %>
        <script type="text/javascript"> alert("This username doesn't exist. Please try again!");</script>            
        <%      } else if (session.getAttribute("error").equals("pwd")) { %>
        <script type="text/javascript"> alert("Wrong password. Please try again!");</script>            
        <%      } else if (session.getAttribute("error").equals("used_uname")) { %>
        <script type="text/javascript"> alert("Username already taken!");</script>                 
        <%      } else if (session.getAttribute("error").equals("wrong_pwd")) { %>
        <script type="text/javascript"> alert("Passwords don't match. Please try again!");</script>            
        <% }
                session.removeAttribute("error");
            }%>

        <div class="fadeIn first">
            <img src="./img/logo/logo_350x150.png" class="logo" alt="Logo 350x150"/>
        </div>
        <div class="form">
            <ul class="tab-group">
                <%  if (session.getAttribute("registration_tab") != null) {
                        if (session.getAttribute("registration_tab").equals("Y")) { %>
                <li class="tab"><a href="#login">Log In</a></li>
                <li class="tab active"><a href="#signup">Sign Up</a></li>
                <script>
                    window.onload = function () {
                        $('#login').hide();
                        $('#signup').fadeIn(600);
                    };
                </script>
                <%      }
                    session.removeAttribute("registration_tab");
                } else { %>
                <li class="tab active"><a href="#login">Log In</a></li>
                <li class="tab"><a href="#signup">Sign Up</a></li>
                    <%  }%>                
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
                    <form action="RegistrationServlet" method="post" name="register_form">

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

                        <div class="top-row">
                            <div class="field-wrap">
                                <input type="text" placeholder="Location" name="loc" required/>

                            </div>

                            <div class="field-wrap">
                                <input type="text" placeholder="Country" name="country" required/>

                            </div>
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

            <form action="LoginServlet" method="post">
                <input type="hidden" name="visitor_flag" value="Y"><br>
                <button class="visitor" type="submit"/>Just a visitor? Click here!</button>
            </form>
        </div>
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script>

                    $('.tab a').on('click', function (e) {
                        e.preventDefault();
                        $(this).parent().addClass('active');
                        $(this).parent().siblings().removeClass('active');
                        target = $(this).attr('href');
                        $('.tab-content > div').not(target).hide();
                        $(target).fadeIn(600);
                    });
        </script>
    </body>
</html>