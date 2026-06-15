<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<style>
    /* 全体レイアウト */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: "Meiryo", sans-serif; display: flex; flex-direction: column; min-height: 100vh; }
    .layout-wrapper { display: flex; flex: 1; width: 100%; }

    /* サイドメニュー */
    .side-menu { 
        width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #e2e8f0; 
        padding: 20px; font-size: 18px; font-weight: normal;
    }
    .side-menu div, .side-menu a, .side-menu span {
        display: block !important; 
        text-align: center !important; 
        margin: 0 auto 10px auto !important; 
        font-weight: normal !important;      
        width: 100%;
    }
    
    /* メインコンテンツ */
    .main-content { flex: 1; padding: 40px; }
    .page-title { background-color: #f5f5f5; padding: 15px; font-size: 24px; font-weight: bold; border-bottom: 2px solid #ddd; margin-bottom: 40px; }

    /* パネル配置 */
    .card-area { display: flex; gap: 30px; }
    .menu-panel { 
        width: 250px; height: 150px; padding: 20px; border-radius: 8px; 
        box-shadow: 0 4px 6px rgba(0,0,0,0.1); text-align: center; font-size: 20px; 
        display: flex; flex-direction: column; justify-content: center; align-items: center;
    }
    
    /* 修正点：成績管理パネル専用のリンクスタイル */
    .score-links {
        display: flex;
        flex-direction: column; /* 強制的に縦並び */
        width: 100%;
        align-items: center;
    }
    .score-links a {
        display: block; /* 1行を占有させる */
        color: #0000ee;
        text-decoration: underline;
        font-size: 16px;
        margin-top: 8px;
    }
</style>
</head>
<body>
    <%@ include file="../header.html" %>

    <div class="layout-wrapper">
        <aside class="side-menu">
            <jsp:include page="/tag.jsp" />
        </aside>

        <main class="main-content">
            <div class="page-title">メニュー</div>
            
            <div class="card-area">
                <div class="menu-panel" style="background-color: #e2bdbe;">
                    <a href="StudentList.action">学生管理</a>
                </div>

                <div class="menu-panel" style="background-color: #b9dcb8;">
                    <div style="font-size: 20px;">成績管理</div>
                    <div class="score-links">
                        <a href="ScoreInsertServlet.action">成績登録</a>
                        <a href="ScoreListServlet.action">成績参照</a>
                    </div>
                </div>

                <div class="menu-panel" style="background-color: #b8b9df;">
                    <a href="SubjectList.action">科目管理</a>
                </div>
            </div>
        </main>
    </div>

    <%@ include file="../footer.jsp" %>
</body>
</html>