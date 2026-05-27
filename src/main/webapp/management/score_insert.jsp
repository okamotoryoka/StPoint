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

<%-- URLパスに /score/ を追加し、ブラウザの自動入力をオフに設定 --%>
<form action="<%=request.getContextPath()%>/ScoreInsertServlet.action" method="post" autocomplete="off">

<table border="1">

<tr>
<th>学生番号</th>
<td>
<input type="text" name="student_id" required>
</td>
</tr>

<tr>
<th>名前</th>
<td>
<input type="text" name="student_name" required>
</td>
</tr>

<tr>
<th>科目名</th>
<td>
<input type="text" name="subject_name" required>
</td>
</tr>

<tr>
<th>学校コード</th>
<td>
<input type="text" name="school_cd" required>
</td>
</tr>

<tr>
<th>テスト回数</th>
<td>
<input type="number" name="no" required>
</td>
</tr>

<tr>
<th>得点</th>
<td>
<%-- type="number" に修正 --%>
<input type="number" name="point" required>
</td>
</tr>

<tr>
<th>クラス番号</th>
<td>
<input type="text" name="class_num" required>
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
