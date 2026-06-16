<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム - 登録完了</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<!-- 上部：水色のシステムヘッダー -->
<header class="system-header">
    <div class="header-title">得点管理システム</div>
    <div class="header-user">
        <span>${sessionScope.teacher_name}様</span>
        <a href="#" class="logout-btn">ログアウト</a>
    </div>
</header>

<div class="main-layout">

    <!-- 左側：メニューエリア -->
    <div class="left-menu-area">
        <jsp:include page="/tag.jsp" />
    </div>

    <!-- 右側：メインコンテンツエリア -->
    <div class="content-body">
        <div class="right-container">
            
            <!-- ① 成績管理 タイトル -->
            <div class="search-title">成績管理</div>

            <!-- ② 登録が完了しました メッセージボックス -->
            <div class="alert-success-box">
                登録が完了しました
            </div>

            <!-- ③・④ リンクエリア -->
                        <!-- ③・④ リンクエリア（「科目管理」の真下に完全一致） -->
            <!-- 💡 margin-top を 115px にすることで、左メニューの「科目管理」のすぐ真下の高さに揃います -->
            <div class="done-link-area" style="margin-left: 0; padding-left: 0; justify-content: flex-start; margin-top: 115px;">
                
                <!-- ③ 戻るリンク -->
                <a href="${pageContext.request.contextPath}/ScoreSearch.action" class="done-link">戻る</a>
                
                <!-- ④ 成績参照リンク -->
                <a href="${pageContext.request.contextPath}/ScoreSubject.action" class="done-link" style="margin-left: 120px;">成績参照</a>
                
            </div>
            
            
        </div>
    </div>

</div>

</body>
</html>
