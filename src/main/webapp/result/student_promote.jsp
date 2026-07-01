<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>年度末一括処理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
    <style>
        .system-layout { display: flex; width: 100%; min-height: 100vh; }
        .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; padding-top: 20px; }
        .main-content { flex: 1; padding: 30px; }
        .page-title { background-color: #f0f0f0; padding: 10px 15px; font-size: 20px; font-weight: bold; color: #333; margin-bottom: 25px; }
        
        .alert-box { padding: 15px; border-radius: 4px; margin-bottom: 20px; font-weight: bold; }
        .alert-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .warning-card { background-color: #fff3cd; border: 1px solid #ffeeba; color: #856404; padding: 20px; border-radius: 4px; line-height: 1.6; margin-bottom: 25px; max-width: 700px; }
        
        .action-btn { background-color: #dc3545; color: #ffffff; border: none; padding: 12px 30px; font-size: 15px; font-weight: bold; border-radius: 4px; cursor: pointer; }
        .action-btn:hover { background-color: #bd2130; }
    </style>
</head>
<body>

    <jsp:include page="../header.jsp" />

    <div class="system-layout">
        <div class="side-menu">
            <jsp:include page="/tag.jsp" />
        </div>

        <main class="main-content">
            <h2 class="page-title">年度末一括処理（進級・卒業）</h2>

            <!-- 成功・失敗メッセージの動的表示 -->
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert-box alert-success"><%= request.getAttribute("successMessage") %></div>
            <% } %>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert-box alert-danger"><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <div class="warning-card">
                <strong>⚠️ 注意事項を確認してください</strong><br>
                この処理を実行すると、データベース内のすべての学生に対して以下の変更が**一括で即座に適用**されます。<br>
                ・現在 <strong>1年〜3年</strong> の在学生 → 学年が自動的に <strong>+1年</strong> 進級します。<br>
                ・現在 <strong>4年</strong> の在学生 → 在学状況が自動的に <strong>「卒業（非在学）」</strong> に切り替わります。<br>
                ※元に戻すことはできません。年度末の締めくくり時のみ慎重に実行してください。
            </div>

            <!-- ボタンの二重押し防止と最終確認のJavaScriptを設置 -->
            <form action="${pageContext.request.contextPath}/StudentPromote.action" method="post" onsubmit="return confirm('本当にすべての学生の進級・卒業処理を実行しますか？');">
                <button type="submit" class="action-btn">進級・卒業処理を実行する</button>
            </form>
        </main>
    </div>

</body>
</html>
