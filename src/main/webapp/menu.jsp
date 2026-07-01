<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>メニュー - 得点管理システム</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style3.css">
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: "Meiryo", "Hiragino Kaku Gothic ProN", sans-serif !important; background-color: #fdfdfd; min-height: 100vh; display: flex; flex-direction: column; }
    
    .container { display: flex; flex: 1; width: 100%; }
    
    /* サイドメニュー（tag.jsp）用エリア */
    .sidebar { width: 200px; flex-shrink: 0; border-right: 1px solid #ddd; padding: 20px 0; background-color: #f9f9f9; }
    
    .main { flex: 1; padding: 20px; }
    .main h2 { background-color: #f5f5f5; padding: 12px 20px; font-size: 20px; font-weight: bold; border-bottom: 1px solid #dfdfdf; margin-bottom: 40px; }
    
    /* 💡 4つのパネルが綺麗に横に並び、画面幅が狭いときは折り返すように flex-wrap: wrap を追加しました */
    .card-area { display: flex; gap: 20px; justify-content: flex-start; align-items: stretch; padding: 0 10px; flex-wrap: wrap; }
    .menu-panel-custom { width: 220px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; padding: 25px 20px; }
    .menu-panel-custom a { color: #0000ee !important; text-decoration: underline !important; font-size: 22px !important; }
    
    /* 各パネルの背景色設定 */
    .panel-red-custom { background-color: #e2bdbe; }
    .panel-green-custom { background-color: #b9dcb8; }
    .panel-blue-custom { background-color: #b8b9df; }
    .panel-purple-custom { background-color: #dfb8de; }
    /* 💡追加：既存のパネルとトーンを合わせた「席替え」用のオレンジカラー */
    .panel-orange-custom { background-color: #fce1c3; }
    
    /* 💡追加：既存のパネルとトーンを合わせた「エラー共有」用のイエローカラー */
    .panel-yellow-custom { background-color: #fcf6c3; }
    
    .score-title-custom { font-size: 22px !important; font-weight: bold !important; color: #333333 !important; margin-bottom: 5px !important; }
    .score-links-custom { display: flex; flex-direction: column; gap: 10px; width: 100%; }
    .score-links-custom a { font-size: 18px !important; text-align: center !important; }
    
    .login-footer { background-color: #ebebeb; padding: 12px 0; text-align: center; font-size: 12px; color: #7a7a7a; border-top: 1px solid #dfdfdf; margin-top: auto; }
</style>
</head>
<body>

<%-- 共通ヘッダーを読み込み --%>
<%@ include file="/header.jsp" %>

<div class="container">
    <%-- サイドメニューとして tag.jsp を配置 --%>
    <div class="sidebar">
        <jsp:include page="tag.jsp" />
    </div>

    <main class="main">
        <h2>メニュー</h2>
        <div class="card-area">
            <!-- 学生管理（赤） -->
            <div class="menu-panel-custom panel-red-custom">
                <a href="${pageContext.request.contextPath}/StudentList.action">学生管理</a>
            </div>
            
            <!-- 成績管理（緑） -->
            <div class="menu-panel-custom panel-green-custom">
                <div class="score-title-custom">成績管理</div>
                <div class="score-links-custom">
                    <a href="${pageContext.request.contextPath}/ScoreListServlet.action">成績登録</a>
                    <a href="${pageContext.request.contextPath}/ScoreSubject.action">成績参照</a>
                </div>
            </div>
            
            <!-- 科目管理（青） -->
            <div class="menu-panel-custom panel-blue-custom">
                <a href="${pageContext.request.contextPath}/SubjectList.action">科目管理</a>
            </div>

            <!-- 年度末一括処理（紫） -->
            <div class="menu-panel-custom panel-purple-custom">
                <a href="${pageContext.request.contextPath}/StudentPromote.action">年度末処理</a>
            </div>

            <!-- 成績考慮自動席替え（オレンジ） -->
            <div class="menu-panel-custom panel-orange-custom">
                <a href="${pageContext.request.contextPath}/SeatChange.action">席替え機能</a>
            </div>

                        <!-- 💡追加：エラー投稿＆検索機能（イエロー） -->
            <div class="menu-panel-custom panel-yellow-custom">
                <div class="score-title-custom">エラー共有</div>
                <div class="score-links-custom">
                    <a href="${pageContext.request.contextPath}/ErrorPostInput.action">エラー投稿</a>
                    <a href="${pageContext.request.contextPath}/ErrorPostList.action">エラー検索</a>
                </div>
            </div>
            
        </div>
    </main>
</div>

<div class="login-footer">
    &copy; 2023 TIC<br>大原学園
</div>
</body>
</html>
