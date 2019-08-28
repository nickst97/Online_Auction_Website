<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.security.MessageDigest"%>
<html>
    <body>
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