<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String user = (String) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body {
    margin: 0;
    background: #79CEE;
    color: white;
    text-align: center;
    padding-top: 100px;
    font-family: Arial;
}

a {
    color: #C5E7F;
    text-decoration: none;
    font-size: 20px;
}
</style>
</head>

<body>

<h1>Welcome <%= user %></h1>

<a href="logout">ログアウト</a>

</body>
</html>