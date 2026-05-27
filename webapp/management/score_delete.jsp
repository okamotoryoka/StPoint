<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>削除確認</title>
</head>

<body>

<h2>削除確認</h2>

本当に削除しますか？

<form action="../score/delete" method="post">

<input type="hidden"
name="student_id"
value="<%= request.getParameter("student_id") %>">

<input type="hidden"
name="subject_cd"
value="<%= request.getParameter("subject_cd") %>">

<input type="hidden"
name="school_cd"
value="<%= request.getParameter("school_cd") %>">

<input type="hidden"
name="no"
value="<%= request.getParameter("no") %>">

<button type="submit">
削除
</button>

</form>

</body>
</html>