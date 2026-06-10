<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - ログアウト</title>
    <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    
    body { 
        min-height: 100vh; 
        display: flex; 
        flex-direction: column; 
        font-family: "Noto Sans JP", sans-serif; 
        background: #fdfdfd;
    }
    
    /* 青いメインヘッダー */
    .header-main { 
        width: 100%;
        background-color: #edf4ff; 
        padding: 40px 24px; 
        font-size: 24px; 
        font-weight: bold; 
        color: #2c3e50;
        border-bottom: 1px solid #e2e8f0;
    }

    /* ① 薄グレーのサブヘッダー（ログアウト） */
    .sub-header {
        width: 100%;
        background-color: #f2f2f2;
        padding: 12px 48px;
        font-size: 16px;
        color: #333333;
        border-bottom: 1px solid #e2e8f0;
    }
    
    /* ② 緑色のログアウト完了メッセージバー */
    .message-bar { 
        width: 100%;
        background-color: #8fcaad; /* 画像のような緑色 */
        padding: 10px 0;
        text-align: center;
        font-size: 14px; 
        color: #333333; 
    }
    
    /* ③ ログインリンクのエリア */
    .link-container {
        padding: 40px 48px;
    }
    .link-container a {
        color: #3182ce;
        text-decoration: none;
        font-size: 14px;
    }
    .link-container a:hover {
        text-decoration: underline;
    }
    
    /* フッター */
    .login-footer {
        position: fixed; 
        bottom: 0; 
        width: 100%;
        background-color: #ebebeb; 
        padding: 12px 0; 
        text-align: center;
        font-size: 12px; 
        color: #7a7a7a; 
        border-top: 1px solid #dfdfdf;
    }
    </style>
</head>
<body>

    <!-- メインヘッダー -->
    <div class="header-main">得点管理システム</div>

    <!-- ① サブヘッダー -->
    <div class="sub-header">ログアウト</div>

    <!-- ② メッセージバー -->
    <div class="message-bar">ログアウトしました</div>

    <!-- ③ ログインリンク -->
    <div class="link-container">
        <a href="login.jsp">ログイン</a>
    </div>

    <!-- フッター -->
    <div class="login-footer">&copy; 2023 TIC<br>大原学園</div>

</body>
</html>
