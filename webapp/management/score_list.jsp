<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点一覧</title>
</head>

<body>

<h2>得点一覧</h2>

<a href="<%=request.getContextPath()%>/management/score_insert.jsp">
    新規登録
</a>

<br><br>

<table border="1">

<tr>
    <th>学生番号</th>
    <th>氏名</th>
    <th>科目</th>
    <th>回数</th>
    <th>得点</th>
    <th>クラス</th>
    <th>更新</th>
    <th>削除</th>
</tr>

<%
ArrayList<Map<String, Object>> list =
    (ArrayList<Map<String, Object>>)
    request.getAttribute("list");

for(Map<String, Object> data : list){
%>

<tr>
    <td><%= data.get("student_id") %></td>
    <td><%= data.get("student_name") %></td>
    <td><%= data.get("subject_name") %></td>
    <td><%= data.get("no") %></td>
    <td><%= data.get("point") %></td>
    <td><%= data.get("class_num") %></td>

    <td>
<a href="<%=request.getContextPath()%>/score/update?student_id=<%= data.get("student_id") %>&subject_cd=<%= data.get("subject_cd") %>&school_cd=<%= data.get("school_cd") %>&no=<%= data.get("no") %>">
    更新
</a>
</td>

<td>
<a href="<%=request.getContextPath()%>/management/score_delete.jsp?student_id=<%= data.get("student_id") %>&subject_cd=<%= data.get("subject_cd") %>&school_cd=<%= data.get("school_cd") %>&no=<%= data.get("no") %>">
削除
</a>
</td>

</tr>


<%
}
%>

</table>

</body>
</html>