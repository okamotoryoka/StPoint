<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../header.html" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者ページ</title>
</head>
<body>

<!-- セッションスコープから管理者名を表示 -->
${sessionScope.admin_name} としてログイン中<br>



<a href="<%= request.getContextPath() %>/">ホーム画面 >>></a><br>
<br>


<%@ include file="../footer.html" %>

</body>
</html>