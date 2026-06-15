<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style3.css">

<style>
/* =========================================================
   全体レイアウトの調整とフッター固定用設定
   ========================================================= */
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: "Meiryo", "Hiragino Kaku Gothic ProN", sans-serif !important;
    background-color: #fdfdfd;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    position: relative;
    padding-bottom: 60px; /* フッター帯の高さ分の余白 */
}

/* メイン部分のコンテナ（サイドバーとメインコンテンツを横並び） */
.container {
    display: flex;
    flex: 1;
    width: 100%;
}

/* =========================================================
   メニューのヘッダータイトル（メイン領域内の鼠色の枠）
   ========================================================= */
.main h2 {
    background-color: #f5f5f5;
    padding: 12px 20px;
    font-size: 20px;
    font-weight: bold;
    color: #000000;
    border-bottom: 1px solid #dfdfdf;
    margin-bottom: 40px;
}

/* メインコンテンツ全体の余白 */
.main {
    flex: 1;
    padding: 20px;
}

/* =========================================================
   パネル（カード）の共通デザインと配置
   ========================================================= */
.card-area {
    display: flex;
    gap: 20px; /* カード同士の間隔をお手本に合わせて20pxに調整 */
    justify-content: flex-start;
    align-items: stretch; /* すべてのカードの高さを自動で一番高いものに揃えます */
    padding: 0 10px;
}

/* 各カードの共通基本スタイル（画像再現） */
.menu-panel-custom {
    width: 220px; /* 横幅をお手本に合わせて220pxに調整 */
    height: auto !important; /* stretchの効果を有効にします */
    border-radius: 8px; /* 角の丸みをお手本に合わせて8pxに調整 */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* お手本に合わせたソフトな影 */
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: 25px 20px; 
    transform: none !important;
}

/* カード内の通常のリンク文字（学生管理・科目管理） */
.menu-panel-custom a {
    color: #0000ee !important; /* お手本の鮮やかな青色 */
    text-decoration: underline !important;
    font-size: 22px !important; /* お手本の文字サイズ22pxに統一 */
    font-weight: normal !important; /* 線の太さを通常にしてすき間を確保します */
    letter-spacing: 0.5px !important; 
    line-height: 1.4 !important;
    transform: none !important;
    display: inline-block !important;
}

.menu-panel-custom a:hover {
    color: #0000cc !important;
}

/* 学生管理パネル（淡い赤） */
.panel-red-custom {
    background-color: #e2bdbe;
}

/* 成績管理パネル（淡い緑） */
.panel-green-custom {
    background-color: #b9dcb8;
}

/* 成績管理のタイトル文字 */
.score-title-custom {
    font-size: 22px !important; /* お手本の文字サイズ22pxに統一 */
    font-weight: bold !important; /* タイトル部分のみ太字 */
    color: #333333 !important; /* お手本の濃いグレー */
    margin-bottom: 5px !important; /* 下のリンクとの隙間を調整 */
    letter-spacing: 0.5px !important; 
    line-height: 1.4 !important;
}

/* 成績登録・成績参照リンクの縦並び */
.score-links-custom {
    display: flex;
    flex-direction: column;
    gap: 10px; /* リンク同士の間隔をお手本に調整 */
    width: 100%;
}

/* 成績管理の中のリンク文字（成績登録・成績参照） */
.score-links-custom a {
    font-size: 18px !important; /* お手本の文字サイズ18pxに統一 */
    font-weight: normal !important; /* 線の太さを通常にしてすき間を確保します */
    line-height: 1.4 !important;
    text-align: center !important;
}

/* 科目管理パネル（淡い紫） */
.panel-blue-custom {
    background-color: #b8b9df;
}

/* =========================================================
   一番下のグレーのフッター帯
   ========================================================= */
.login-footer {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    background-color: #ebebeb;
    padding: 12px 0;
    text-align: center;
    line-height: 1.6;
    font-size: 12px;
    color: #7a7a7a;
    border-top: 1px solid #dfdfdf;
    z-index: 10;
}
</style>
</head>

<body>

<!-- ヘッダー -->
<header class="header">
    <div class="logo">
        得点管理システム
    </div>
    <div class="user-info">
        ${sessionScope.teacher_name}様
        <a href="Logout.action">ログアウト</a>
    </div>
</header>

<!-- 全体 -->
<div class="container">

    <!-- サイドバー -->
    <aside class="sidebar" style="width: 220px; min-width: 220px; padding: 20px 10px 20px 20px; box-sizing: border-box; border: none; outline: none;">
        <ul style="list-style: none; padding-left: 0; margin: 0; line-height: 2.0; width: 100%; border: none; outline: none;">
            <li style="margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/Menu.action" style="border: none; outline: none; display: inline-block;">メニュー</a></li>
            <li class="menu-title" style="margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/StudentList.action" style="border: none; outline: none; display: inline-block;">学生管理</a></li>
            <li class="menu-title" style="margin-bottom: 8px; color: #333; font-weight: bold;">成績管理</li>
            <li style="padding-left: 20px; margin-bottom: 8px;"><a href="${pageContext.request.contextPath}/ScoreListServlet.action" style="border: none; outline: none; display: inline-block;">成績登録</a></li>
            <li style="padding-left: 20px; margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/ScoreInsertServlet.action" style="border: none; outline: none; display: inline-block;">成績参照</a></li>
            <li class="menu-title" style="margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/SubjectList.action" style="border: none; outline: none; display: inline-block;">科目管理</a></li>
        </ul>
    </aside>

    <!-- メインコンテンツ -->
    <main class="main">

        <!-- メニューヘッダータイトル（グレー枠） -->
        <h2>メニュー</h2>

        <div class="card-area">

            <!-- 学生管理パネル -->
            <div class="menu-panel-custom panel-red-custom">
                <a href="${pageContext.request.contextPath}/StudentList.action">学生管理</a>
            </div>

            <!-- 成績管理パネル -->
            <div class="menu-panel-custom panel-green-custom">
                <div class="score-title-custom">成績管理</div>
                <div class="score-links-custom">
                    <!-- 成績登録 -->
                    <a href="${pageContext.request.contextPath}/ScoreListServlet.action">成績登録</a>
                    <!-- 成績参照 -->
                    <a href="${pageContext.request.contextPath}/ScoreInsertServlet.action">成績参照</a>
                </div>
            </div>

            <!-- 科目管理パネル -->
            <div class="menu-panel-custom panel-blue-custom">
                <a href="${pageContext.request.contextPath}/SubjectList.action">科目管理</a>
            </div>

        </div>

    </main>

</div>

<!-- 横いっぱいに広がるグレーのフッター帯 -->
<div class="login-footer">
    &copy; 2023 TIC<br>
    大原学園
</div>

</body>
</html>
