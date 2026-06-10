<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - エラー</title>
    <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    
    body { 
        min-height: 100vh; 
        display: flex; 
        flex-direction: column; /* 縦並びに設定 */
        font-family: "Noto Sans JP", sans-serif; 
        background: #fdfdfd;
    }
    
    /* 画面横いっぱいに広がるヘッダー */
    .error-title { 
        width: 100%;
        background-color: #edf4ff; 
        padding: 40px 24px; /* 上下の余白を調整 */
        font-size: 24px; 
        font-weight: bold; 
        color: #2c3e50;
        border-bottom: 1px solid #e2e8f0;
    }
    
    /* エラーメッセージを左寄せ（インデント）にする */
    .error-content { 
        padding: 40px 48px; /* 左側に少し広めの余白を設定 */
        font-size: 14px; 
        color: #333333; 
    }
    
    .login-footer {
        position: fixed; /* フッターを最下部に固定 */
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
    <!-- 外側の error-box を削除し、構造をシンプルにしました -->
    <h2 class="error-title">得点管理システム</h2>
    <div class="error-content">エラーが発生しました</div>

    <div class="login-footer">&copy; 2023 TIC<br>大原学園</div>
</body>
</html>
