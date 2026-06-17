<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style3.css">
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: "Meiryo", "Hiragino Kaku Gothic ProN", sans-serif !important; background-color: #fdfdfd; min-height: 100vh; display: flex; flex-direction: column; position: relative; padding-bottom: 60px; }
    .container { display: flex; flex: 1; width: 100%; }
    .main { flex: 1; padding: 20px; }
    .main h2 { background-color: #f5f5f5; padding: 12px 20px; font-size: 20px; font-weight: bold; border-bottom: 1px solid #dfdfdf; margin-bottom: 40px; }
    .card-area { display: flex; gap: 20px; justify-content: flex-start; align-items: stretch; padding: 0 10px; }
    .menu-panel-custom { width: 220px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; padding: 25px 20px; }
    .menu-panel-custom a { color: #0000ee !important; text-decoration: underline !important; font-size: 22px !important; }
    .panel-red-custom { background-color: #e2bdbe; }
    .panel-green-custom { background-color: #b9dcb8; }
    .panel-blue-custom { background-color: #b8b9df; }
    .score-title-custom { font-size: 22px !important; font-weight: bold !important; color: #333333 !important; margin-bottom: 5px !important; }
    .score-links-custom { display: flex; flex-direction: column; gap: 10px; width: 100%; }
    .score-links-custom a { font-size: 18px !important; text-align: center !important; }
    .login-footer { position: absolute; bottom: 0; left: 0; width: 100%; background-color: #ebebeb; padding: 12px 0; text-align: center; font-size: 12px; color: #7a7a7a; border-top: 1px solid #dfdfdf; }
</style>
</head>
<body>

<header class="header">
    <div class="logo">得点管理システム</div>
    <div class="user-info">
        ${sessionScope.teacher_name}様
        <a href="Logout.action">ログアウト</a>
    </div>
</header>

<div class="container">
    <jsp:include page="tag.jsp" />

    <main class="main">
        <h2>メニュー</h2>
        <div class="card-area">
            <div class="menu-panel-custom panel-red-custom">
                <a href="${pageContext.request.contextPath}/StudentList.action">学生管理</a>
            </div>
            <div class="menu-panel-custom panel-green-custom">
                <div class="score-title-custom">成績管理</div>
                <div class="score-links-custom">
                    <a href="${pageContext.request.contextPath}/ScoreListServlet.action">成績登録</a>
                    <a href="${pageContext.request.contextPath}/ScoreSubject.action">成績参照</a>
                </div>
            </div>
            <div class="menu-panel-custom panel-blue-custom">
                <a href="${pageContext.request.contextPath}/SubjectList.action">科目管理</a>
            </div>
        </div>
    </main>
</div>

<div class="login-footer">
    &copy; 2023 TIC<br>大原学園
</div>
</body>
</html>