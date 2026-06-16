<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ログアウト | 得点管理システム</title>
    
    <style type="text/css">
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: sans-serif;
        }

        body {
            display: flex;
            flex-direction: column;
        }

        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        /* ヘッダー：左寄せ */
        .header-main {
            background-color: #ebf4ff;
            padding: 24px;
            font-size: 28px;
            font-weight: bold;
            color: #000000;
        }

        /* 中央のコンテンツ幅を統一 */
        .content-container {
            max-width: 800px;
            width: 100%;
            margin: 0 auto;
            padding: 0 20px;
            box-sizing: border-box;
            flex: 1; 
            display: flex;
            flex-direction: column;
        }

        /* ① ログアウトの見出し：太字 */
        .sub-header {
            background-color: #f2f2f2;
            padding: 16px 24px;
            font-size: 20px;
            font-weight: bold;
            color: #000000;
            margin-top: 20px;
            width: 100%;
            box-sizing: border-box;
        }

        /* ② ログアウトしました：中央寄せ */
        .message-bar {
            background-color: #7cbd9a;
            padding: 12px 0;
            text-align: center;
            color: #000000;
            font-weight: normal;
            font-size: 14px;
            margin-top: 10px;
            width: 100%;
            box-sizing: border-box;
        }

        /* ③ ログインリンク：左寄せで下に配置 */
        .link-container {
            padding: 40px 24px;
            text-align: left; /* 左寄せに変更 */
            margin-top: auto; /* リンクを下に押し下げる */
        }

        .link-container a {
            color: #3182ce;
            text-decoration: underline;
            font-size: 16px;
        }

        .login-footer {
            background-color: #edf2f7;
            text-align: center;
            padding: 15px 0;
            font-size: 12px;
            color: #718096;
        }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="header-main">
            得点管理システム
        </div>
        
        <div class="content-container">
            <div class="sub-header">ログアウト</div>
            <div class="message-bar">ログアウトしました。</div>
            
            <div class="link-container">
                <a href="${pageContext.request.contextPath}/login/login.jsp">ログイン</a>
            </div>
        </div>
    </div>

    <div class="login-footer">
        &copy; 2023 TIC <br>大原学園
    </div>
</body>
</html>