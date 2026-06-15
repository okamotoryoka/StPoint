<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生情報変更完了</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<style>
    /* 成功メッセージを他の画面と統一 */
    .success-message {
        background-color: #c8e6c9; /* 淡い緑色 */
        padding: 15px;
        text-align: center;
        border: 1px solid #a5d6a7;
        margin: 20px 0;
        border-radius: 4px;
        font-weight: bold;
    }
    .back-link {
        display: block;
        text-align: center;
        margin-top: 20px;
    }
</style>
</head>
<body>

<header class="system-header">
    <div class="header-title">得点管理システム</div>
</header>

<div class="main-layout">
    <div class="left-menu-area">
        <jsp:include page="/tag.jsp" />
    </div>

    <div class="content-body">
        <div class="right-container">
            <div class="search-title">学生情報変更</div>

            <div class="success-message">
                変更が完了しました
            </div>

            <div class="back-link">
                <a href="${pageContext.request.contextPath}/StudentList.action">学生一覧へ戻る</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>