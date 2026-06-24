<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Student" %>

<html lang="ja">
<head>
<title>学生検索</title>
</head>

<body>

<h2>学生検索</h2>

<form action="/StPoint/StudentSearch.action" method="post">

    名前：
    <input type="text" name="name">

    クラス：
    <input type="text" name="classNum">

    ソート：
    <select name="sort">

        <option value="">なし</option>
        <option value="no">学籍番号順</option>
        <option value="class">クラス順</option>

    </select>

    <input type="submit" value="検索">

</form>

<hr>

<table border="1">

<tr>
    <th>学籍番号</th>
    <th>名前</th>
    <th>入学年</th>
    <th>クラス</th>
</tr>

<%
List<Student> list =
    (List<Student>)request.getAttribute("students");

if (list != null) {

    for (Student s : list) {
%>

<tr>

    <td><%= s.getNo() %></td>
    <td><%= s.getName() %></td>
    <td><%= s.getEntYear() %></td>
    <td><%= s.getClassNum() %></td>

</tr>

<%
    }
}
%>

</table>

</body>
</html>