<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="chat.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <form action="msg_submit" method ="post" name="msg_box">
                <input type="text" id="receiver" name="receiver" placeholder="Username" required>
                <input type="text" id="itemid" name="itemid" placeholder="Item ID" required>
                <textarea id="subject" name="content" placeholder="Write your message.." style="height:200px" required></textarea>
                <input type="submit" value="Submit">
              </form>
        </div>
    </body>
</html>