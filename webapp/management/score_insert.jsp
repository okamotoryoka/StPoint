<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点登録</title>
</head>

<body>

<h2>得点登録</h2>

<form action="<%=request.getContextPath()%>/score/insert" method="post">

<table border="1">

<tr>
<th>学生番号</th>
<td>
<input type="text"
name="student_id">
</td>
</tr>

<tr>
<th>名前</th>
<td>
<input type="text"
name="sutudent_name">
</td>
</tr>

<tr>
<th>科目名</th>
<td>
<input type="text"
name="subject_name">
</td>
</tr>

<tr>
<th>学校コード</th>
<td>
<input type="text"
name="school_cd">
</td>
</tr>

<tr>
<th>テスト回数</th>
<td>
<input type="number"
name="no">
</td>
</tr>

<tr>
<th>得点</th>
<td>
<input type="point"
name="point">
</td>
</tr>

<tr>
<th>クラス番号</th>
<td>
<input type="text"
name="class_num">
</td>
</tr>

</table>

<br>

<button type="submit">
登録
</button>

</form>

</body>
</html>
