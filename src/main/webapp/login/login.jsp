<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム</title>
    <link rel="preconnect" href="https://googleapis.com">
    <link rel="preconnect" href="https://gstatic.com" crossorigin>
    <link href="https://googleapis.com/css2?family=Noto+Sans+JP:wght@400;700&display=swap" rel="stylesheet">
    <style>
    /* =========================================================
       全体のリセットと背景設定
       ========================================================= */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    
    body { 
        height: 100vh; 
        display: flex; 
        flex-direction: column;
        justify-content: center; 
        align-items: center; 
        font-family: "Noto Sans JP", "Yu Gothic", sans-serif; 
        background: #fdfdfd;
        overflow: hidden; 
        position: relative;
    }

    /* =========================================================
       ① ログインボックス（白いカード型の枠）
       ========================================================= */
    .login-box { 
        width: 420px; 
        background: #ffffff; 
        border: 1px solid #e2e8f0;
        border-radius: 8px; 
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); 
        text-align: center; 
        overflow: hidden;
        margin-bottom: 60px;
    }

    /* 「ログイン」のヘッダータイトル（鼠色の枠） */
    .login-title { 
        background-color: #f5f5f5;
        padding: 16px;
        font-size: 20px; 
        font-weight: bold; 
        color: #333333;
        border-bottom: 1px solid #e2e8f0;
        margin-bottom: 0;
    }

    /* フォームの内側の余白 */
    form {
        padding: 30px 24px;
    }

    /* =========================================================
       ②・③ 入力欄（薄青色のボックス）の共通デザイン
       ========================================================= */
    .input-container {
        background-color: #edf3fa;
        border-radius: 6px;
        padding: 8px 14px;
        margin-bottom: 16px;
        text-align: left;
    }

    /* 入力欄の上の小さなラベル文字（教員ID / パスワード） */
    .input-label {
        display: block;
        font-size: 11px;
        color: #75869c;
        margin-bottom: 2px;
        font-weight: bold;
    }

    /* inputタグ本体（枠線や背景を消して透かす） */
    input { 
        width: 100%; 
        padding: 4px 0; 
        border: none; 
        background: transparent; 
        font-size: 15px; 
        color: #333333;
        outline: none; 
    }

    /* =========================================================
       ④・⑤ パスワードを表示チェックボックス
       ========================================================= */
    .checkbox-group {
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 13px;
        color: #333333;
        margin-top: 4px;
        margin-bottom: 24px;
    }

    .checkbox-group input[type="checkbox"] {
        width: auto;
        margin-right: 6px;
        cursor: pointer;
    }

    .checkbox-group label {
        cursor: pointer;
        user-select: none;
    }

    /* =========================================================
       ⑥ ログインボタン（鮮やかな青色・少し短め）
       ========================================================= */
    button { 
        display: block;
        width: 55%; 
        margin: 0 auto;
        padding: 12px; 
        border: none; 
        border-radius: 6px; 
        background: #007bff; 
        color: #ffffff; 
        font-size: 15px; 
        font-weight: bold; 
        cursor: pointer; 
        transition: background 0.2s; 
    }
    
    button:hover { 
        background: #0056b3;
    }

    /* =========================================================
       一番下のグレーのフッター（大原学園対応版）
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
    }
    </style>
</head>
<body>

<!-- ログインメインボックス -->
<div class="login-box">
    <!-- ① タイトル部分 -->
    <h2 class="login-title">ログイン</h2>

    <form action="../Login.action" method="post">
    
        <!-- ② 教員ID入力ボックス -->
        <div class="input-container">
            <span class="input-label">教員ID</span>
            <input
                type="text"
                name="username"
                placeholder=""
                required
            >
        </div>

        <!-- ③ パスワード入力ボックス -->
        <div class="input-container">
            <span class="input-label">パスワード</span>
            <input
                type="password"
                name="password"
                id="password-input"
                placeholder=""
                required
            >
        </div>

        <!-- ④ ⑤ パスワードを表示チェックボックス -->
        <div class="checkbox-group">
            <input type="checkbox" id="show-password">
            <label for="show-password">パスワードを表示</label>
        </div>

        <!-- ⑥ ログインボタン -->
        <button type="submit">
            ログイン
        </button>
    </form>
</div>

<!-- 横いっぱいに広がるグレーのフッター帯 -->
<div class="login-footer">
    &copy; 2023 TIC<br>
    大原学園
</div>

<!-- パスワードの表示/非表示を切り替えるスクリプト -->
<script>
    document.getElementById('show-password').addEventListener('change', function() {
        const passwordInput = document.getElementById('password-input');
        if (this.checked) {
            passwordInput.type = 'text';
        } else {
            passwordInput.type = 'password';
        }
    });
</script>
</body>
</html>
