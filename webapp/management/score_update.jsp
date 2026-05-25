<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点更新</title>

<style>

body{
    font-family: "Yu Gothic", sans-serif;
    background: linear-gradient(135deg, #fdfbfb, #ebedee);
    margin: 0;
    padding: 40px;
}

.container{
    width: 500px;
    margin: auto;
    background: white;
    padding: 35px;
    border-radius: 20px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
}

h2{
    text-align: center;
    color: #555;
    margin-bottom: 30px;
    font-size: 28px;
}

table{
    width: 100%;
    border-collapse: collapse;
}

th{
    text-align: left;
    padding: 12px;
    color: #666;
    width: 35%;
}

td{
    padding: 12px;
}

input{
    width: 100%;
    padding: 10px;
    border: 2px solid #e0e0e0;
    border-radius: 10px;
    font-size: 15px;
    transition: 0.3s;
    box-sizing: border-box;
}

input:focus{
    border-color: #ffb6c1;
    outline: none;
    box-shadow: 0 0 8px rgba(255,182,193,0.5);
}

button{
    width: 100%;
    padding: 14px;
    background: linear-gradient(135deg, #ffb6c1, #ff8fab);
    border: none;
    border-radius: 12px;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
}

button:hover{
    transform: translateY(-2px);
    box-shadow: 0 6px 15px rgba(255,143,171,0.4);
}

</style>

</head>

<body>

<div class="container">

<h2>✎得点更新</h2>

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

</div>
</body>
</html>
