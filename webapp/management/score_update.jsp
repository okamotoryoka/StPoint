<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点更新</title>
</head>

<body>

<h2>得点更新</h2>

<%
Map<String, Object> data =
    (Map<String, Object>)
    request.getAttribute("data");
%>

<form
action="../score/update"
method="post">

<input type="hidden"
name="student_id"
value="<%= data.get("student_id") %>">

<input type="hidden"
name="subject_cd"
value="<%= data.get("subject_cd") %>">

<input type="hidden"
name="school_cd"
value="<%= data.get("school_cd") %>">

<input type="hidden"
name="no"
value="<%= data.get("no") %>">

<table border="1">

<tr>
<th>学生番号</th>
<td>
<%= data.get("student_id") %>
</td>
</tr>

<tr>
<th>科目コード</th>
<td>
<%= data.get("subject_cd") %>
</td>
</tr>

<tr>
<th>得点</th>
<td>

<input
type="number"
name="point"
value="<%= data.get("point") %>">

</td>
</tr>

<tr>
<th>学校コード</th>
<td>

<%= data.get("school_cd") %>

</td>
</tr>

<tr>
<th>クラス番号</th>
<td>

<input
type="text"
name="class_num"
value="<%= data.get("class_num") %>">

</td>
</tr>

</table>

<br>

<button type="submit">
更新
</button>

</form>

</body>
</html>