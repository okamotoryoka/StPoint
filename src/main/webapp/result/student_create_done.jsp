<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生情報登録</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<style>
    /* ヘッダーやレイアウト用CSSは style.css に集約し、ここでは微調整のみを行う */
    .success-message {
        background-color: #c8e6c9;
        padding: 15px;
        text-align: center;
        border: 1px solid #a5d6a7;
        margin: 20px 0;
        font-weight: bold;
    }
</style>
</head>
<body>

<header class="system-header">
    <div class="header-title">得点管理システム</div>
</header>

<div class="main-layout">
    <nav class="left-menu-area">
        <jsp:include page="/tag.jsp" />
    </nav>

    <main class="content-body">
        <div class="right-container">
            <div class="search-title">学生情報登録</div>

            <div class="success-message">
               登録が完了しました
            </div>

            <div class="back-link">
    <a href="javascript:history.back()">戻る</a>
    <a href="${pageContext.request.contextPath}/StudentList.action">学生一覧に戻る</a>
</div>

        </div>
    </main>
</div>

</body>
</html>