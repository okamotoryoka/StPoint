<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生変更完了</title>
</head>
<body>
<h1>学生情報変更</h1>
<p>変更が完了しました。</p>

<%-- ⭕ 修正：JSPファイルを直接開くのではなく、Actionクラスを呼び出すように変更します --%>
<a href="<%= request.getContextPath() %>/StudentList.action">学生一覧</a><br>
</body>
</html>
