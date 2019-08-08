
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Create bid</title>
    </head>
    <body>
        <a href="homepage.jsp">Homepage</a>
        <a href="manage.jsp">Manage bids</a>
        <a href="navigate.jsp">Search/Navigate bids</a>
        <% if (session.getAttribute("user")!=null) { %>
        <a href="./jsp/logout.jsp">Log-out</a>
        <% } else{ %>
        <a href="startpage.html">Log-in/Sign-up</a>
        <% } %>
        </br>
        </br>
        <a href="createbids.jsp">Create a bid</a>
        <a href="navigatebids.jsp">Navigate live bids</a>
        <a href="editbids.jsp">Edit/Delete not live bids</a>
        <form action="./jsp/createbid.jsp" method="post">
        Create a bid: <br/><br/>
        Name: <input type="text" name="name" placeholder="Bid name"/><br/><br/>
        Categories: </br>
            <input type="checkbox" name="cat" value="Collectibles">Collectibles</input>
            <input type="checkbox" name="cat" value="Movies">Movies</input>
            <input type="checkbox" name="cat" value="DVD">DVD</input>
            <input type="checkbox" name="cat" value="Television">Television</input>
            <input type="checkbox" name="cat" value="Autographs">Autographs</input>
            <input type="checkbox" name="cat" value="Posters">Posters</input>
            <input type="checkbox" name="cat" value="Music">Music</input>
            <input type="checkbox" name="cat" value="Video">Video</input>
            <input type="checkbox" name="cat" value="Clothing">Clothing</input>
            <input type="checkbox" name="cat" value="Boys">Boys</input>
            <input type="checkbox" name="cat" value="Girls">Girls</input>
            <input type="checkbox" name="cat" value="Teens">Teens</input>
            <input type="checkbox" name="cat" value="Men">Men</input
            <input type="checkbox" name="cat" value="Women">Women</input>
            <input type="checkbox" name="cat" value="Underwears">Underwears</input>
            <input type="checkbox" name="cat" value="Shoes">Shoes</input>
            <input type="checkbox" name="cat" value="Jeans">Jeans</input>
            <input type="checkbox" name="cat" value="T-shirts">T-shirts</input>
            <input type="checkbox" name="cat" value="Sweaters">Sweaters</input>
            <input type="checkbox" name="cat" value="Accessories">Accessories</input>
            <input type="checkbox" name="cat" value="Backpacks">Backpacks</input>
            <input type="checkbox" name="cat" value="Bags">Bags</input>
            <input type="checkbox" name="cat" value="Suits">Suits</input>
            <input type="checkbox" name="cat" value="Sports">Sports</input>
            <input type="checkbox" name="cat" value="Skirts">Skirts</input>
            <input type="checkbox" name="cat" value="Small">Small</input>
            <input type="checkbox" name="cat" value="Medium">Medium</input>
            <input type="checkbox" name="cat" value="Large">Large</input>
            <input type="checkbox" name="cat" value="Extra-Small">Extra-Small</input>
            <input type="checkbox" name="cat" value="Extra-Large">Extra-Large</input>
        <br/><br/>
        Buy Price: <input type="number" name="buyp" step="0.01" min="0" placeholder="ex 1.5"/><br/><br/>
        First Bid: <input type="number" name="firstb" step="0.01" min="0" placeholder="ex 1.5"/><br/><br/>
        Location: <input type="text" name="loc" placeholder="ex Athens"/><br/><br/>
        Country: <input type="text" name="country" placeholder="ex Greece"/><br/><br/>
        Description: <input type="text" name="desc" placeholder="Type a description of the item"/><br/><br/>
        End of bid: <input type="date" name="dt" /> <input type="time" name="tm" step="1"/><br/><br/>
        Attach images: <input type="file" name="img" multiple /><br/><br/>
        Start bid: <br/> <br/>
        <input type="radio" name="start" value="Yes" checked>Yes<br/><br/>
        <input type="radio" name="start" value="No">No<br/><br/>
        <br/><br/>
        Create bid:<input type="submit" name="create" value="Submit bid"/><br/><br/>
        </form>
    </body>
</html>
