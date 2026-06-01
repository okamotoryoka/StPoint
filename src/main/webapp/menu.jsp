<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style3.css">

</head>

<body>

<!-- ヘッダー -->
<header class="header">

    <div class="logo">
        得点管理システム
    </div>

    <div class="user-info">
        ${sessionScope.admin_name}様　
        <a href="login/logout.jsp">ログアウト</a>
    </div>

</header>


<!-- 全体 -->
<div class="container">

    <!-- 左メニュー -->
    <aside class="sidebar">

        <ul>
            <li class="menu-title">メニュー</li>

            <li><a href="${pageContext.request.contextPath}/StudentList.action">学生管理</a></li>

            <li><a href="${pageContext.request.contextPath}/ScoreListServlet.action">成績管理</a></li>
            <li><a href="${pageContext.request.contextPath}/management/score_insert.jsp">成績登録</a></li>
            <li><a href="#">成績参照</a></li>

            <li><a href="#">科目管理</a></li>
        </ul>

    </aside>


    <!-- メイン -->
    <main class="main">

        <h2>メニュー</h2>

        <div class="card-area">

            <!-- 学生管理 -->
            <div class="card student">
                <a href="${pageContext.request.contextPath}/StudentList.action">学生管理</a>
            </div>

            <!-- 成績管理 -->
            <div class="card score">

                <div><a href="${pageContext.request.contextPath}/ScoreListServlet.action">成績管理</a></div>
                <div><a href="${pageContext.request.contextPath}/management/score_insert.jsp">成績登録</a></div>
                <div><a href="#">成績参照</a></div>

            </div>

            <!-- 科目管理 -->
            <div class="card subject">
                <a href="#">科目管理</a>
            </div>

        </div>

    </main>

</div>

</body>
</html>