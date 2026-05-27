<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム</title>
    <link rel="preconnect" href="https://googleapis.com">
    <link rel="preconnect" href="https://gstatic.com" crossorigin>
    <link href="https://googleapis.com/css2?family=Kiwi+Maru:wght@500&display=swap" rel="stylesheet">
    <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { height: 100vh; display: flex; justify-content: center; align-items: center; font-family: "Yu Gothic", sans-serif; background: #575757; overflow: hidden; }
    .login-box { position: relative; z-index: 1; width: 350px; padding: 40px; background: #9f9a97; backdrop-filter: blur(15px); border-radius: 25px; box-shadow: 0 8px 32px rgba(0,0,0,0.2), 0 0 20px rgba(255,255,255,0.3); text-align: center; }
    .login-title { font-size: 42px; margin-bottom: 30px; font-family: "Yu Gothic","メイリオ", serif; letter-spacing: 3px; font-weight: bold; text-shadow: 0 0 8px rgba(255,255,255,0.5); }
    input { width: 100%; padding: 14px; margin-bottom: 18px; border: none; border-radius: 12px; background: rgba(255,255,255,0.9); font-size: 15px; outline: none; transition: 0.3s; }
    input:focus { transform: scale(1.03); box-shadow: 0 0 12px rgba(255,255,255,0.8); }
    button { width: 100%; padding: 14px; border: none; border-radius: 12px; background: #D9D4C7; color: #333; font-size: 16px; font-weight: bold; cursor: pointer; transition: 0.3s; }
    button:hover { transform: translateY(-3px); background: #A69E94; box-shadow: 0 8px 15px rgba(176,224,230,0.5); }
    .sub-text { margin-top: 18px; color: white; font-size: 13px; opacity: 0.9; }
    </style>
</head>
<body>
<div class="login-box">
    <h2 class="login-title">管理者ログイン</h2>

    <!-- ⭕ 送信先を管理者用の「../AdminLogin.action」に設定 -->
    <form action="../Login.action" method="post">
    
        <!-- ⭕ パラメーター名は AdminLoginAction と合わせて「admin_name」 -->
        <input
            type="text"
            name="admin_name"
            placeholder="管理者名"
            required
        >

        <!-- ⭕ パラメーター名は「password」 -->
        <input
            type="password"
            name="password"
            placeholder="パスワード"
            required
        >

        <button type="submit">
            ログイン
        </button>
    </form>
    <p class="sub-text"></p>
</div>
</body>
</html>
