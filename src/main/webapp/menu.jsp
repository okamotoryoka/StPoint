<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style3.css">
</head>

<body>

<!-- 1. ヘッダーエリア -->
<header class="header" style="display: flex; justify-content: space-between; align-items: center; padding: 10px 20px; background-color: #e8f0fe;">
    <div class="logo" style="font-size: 24px; font-weight: bold;">
        得点管理システム
    </div>
    <div class="user-info">
        ${sessionScope.admin_name}様　
        <a href="Logout.action">ログアウト</a>
    </div>
</header>


<!-- 2. 画面下部を「左メニュー」と「右コンテンツ」に分割する外枠 -->
<div class="main-layout" style="display: flex; min-height: 80vh;">

    <!-- 👈 エラーが出ないよう、以前完成させた左メニューのコードを直接ここに配置しました -->
    <aside class="sidebar" style="width: 220px; min-width: 220px; padding: 20px 10px 20px 20px; box-sizing: border-box; border: none; outline: none;">
        <ul style="list-style: none; padding-left: 0; margin: 0; line-height: 2.0; width: 100%; border: none; outline: none;">
            <li style="margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/Menu.action" style="border: none; outline: none; display: inline-block;">メニュー</a></li>
            <li class="menu-title" style="margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/StudentList.action" style="border: none; outline: none; display: inline-block;">学生管理</a></li>
            <li class="menu-title" style="margin-bottom: 8px; color: #333; font-weight: bold;">成績管理</li>
            <li style="padding-left: 20px; margin-bottom: 8px;"><a href="${pageContext.request.contextPath}/ScoreRegist.action" style="border: none; outline: none; display: inline-block;">成績登録</a></li>
            <li style="padding-left: 20px; margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/ScoreSearch.action" style="border: none; outline: none; display: inline-block;">成績参照</a></li>
            <li class="menu-title" style="margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/ScoreListServlet.action" style="border: none; outline: none; display: inline-block;">科目管理</a></li>
        </ul>
    </aside>

    <!-- 3. 右側メインコンテンツエリア -->
    <div class="content-body" style="flex: 1; padding: 20px;">

        <%-- ① タイトルバー --%>
        <h1 class="menu-title-bar" style="background-color: #f0f0f0; padding: 10px; font-size: 20px; margin-bottom: 30px; margin-top: 0;">メニュー</h1>

        <%-- パネルを横並びにするコンテナ --%>
        <div class="panel-container" style="display: flex; gap: 20px; justify-content: flex-start; align-items: stretch;">

            <%-- ② 学生管理パネル（赤系） --%>
            <div class="menu-panel panel-red" style="background-color: #e2c2c2; padding: 30px 20px; border-radius: 8px; width: 220px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: flex; align-items: center; justify-content: center;">
                <a href="${pageContext.request.contextPath}/StudentList.action" style="font-size: 22px; font-weight: bold; text-decoration: underline; color: #0000ee;">学生管理</a>
            </div>

            <%-- ③④⑤ 成績管理パネル（緑系） --%>
            <div class="menu-panel panel-green" style="background-color: #c2e2c2; padding: 20px; border-radius: 8px; width: 220px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: flex; flex-direction: column; justify-content: center; gap: 10px;">
                <div style="font-size: 22px; font-weight: bold; color: #333; margin-bottom: 5px; text-align: center;">成績管理</div>
                <div style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/ScoreRegist.action" style="font-size: 18px; text-decoration: underline; color: #0000ee;">成績登録</a></div>
                <div style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/ScoreSearch.action" style="font-size: 18px; text-decoration: underline; color: #0000ee;">成績参照</a></div>
            </div>

            <%-- ⑥ 科目管理パネル（青系） --%>
            <div class="menu-panel panel-blue" style="background-color: #c2c2e2; padding: 30px 20px; border-radius: 8px; width: 220px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: flex; align-items: center; justify-content: center;">
                <a href="${pageContext.request.contextPath}/ScoreListServlet.action" style="font-size: 22px; font-weight: bold; text-decoration: underline; color: #0000ee;">科目管理</a>
            </div>

        </div>

    </div> <!-- content-bodyの閉じタグ -->

</div> <!-- main-layoutの閉じタグ -->


<!-- フッター -->
<jsp:include page="/footer.jsp" />

</body>
</html>
