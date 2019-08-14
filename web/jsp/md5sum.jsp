<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.security.MessageDigest"%>
<html>
    <body>
        This jsp code shows an example of a functioning md5 hash.<br>
        The plaintext password is 'password' and is hard coded.<br>
        The MD5 hash version of 'password' is '5f4dcc3b5aa765d61d8327deb882cf99'<br> 
        and is calculated each time the page is loaded.<br><br>
        <%
String plainText = "123456";
MessageDigest mdAlgorithm = MessageDigest.getInstance("MD5");
mdAlgorithm.update(plainText.getBytes());

byte[] digest = mdAlgorithm.digest();
StringBuffer hexString = new StringBuffer();

for (int i = 0; i < digest.length; i++) {
    plainText = Integer.toHexString(0xFF & digest[i]);

    if (plainText.length() < 2) {
        plainText = "0" + plainText;
    }

    hexString.append(plainText);
}

out.print(hexString.toString());
        %>
    </body>
</html>