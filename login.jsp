<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Kiwi+Maru:wght@500&display=swap" rel="stylesheet">

<title>得点管理システム</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: "Yu Gothic", sans-serif;

    background: #575757;

    overflow: hidden;
}

.login-box {
    position: relative;
    z-index: 1;

    width: 350px;
    padding: 40px;

    background: #9f9a97;
    backdrop-filter: blur(15px);

    border-radius: 25px;

    box-shadow:
        0 8px 32px rgba(0,0,0,0.2),
        0 0 20px rgba(255,255,255,0.3);

    text-align: center;
}

.login-title {
    font-size: 42px;

    color: #000;

    margin-bottom: 30px;

    font-family: "Yu Gothic","メイリオ", serif;

    letter-spacing: 3px;

    font-weight: bold;

    text-shadow:
        0 0 8px rgba(255,255,255,0.5);
}

/* 入力欄 */
input {
    width: 100%;
    padding: 14px;
    margin-bottom: 18px;

    border: none;
    border-radius: 12px;

    background: rgba(255,255,255,0.9);

    font-size: 15px;
    outline: none;

    transition: 0.3s;
}

input:focus {
    transform: scale(1.03);
    box-shadow: 0 0 12px rgba(255,255,255,0.8);
}

/* パスワード表示 */
.show-password {
    display: flex;
    justify-content: center;
    align-items: center;

    margin-top: -8px;
    margin-bottom: 18px;

    font-size: 14px;
    color: #333;
}

.show-password input {
    width: auto;
    margin: 0 8px 0 0;
}

/* ボタン */
button {
    width: 100%;
    padding: 14px;

    border: none;
    border-radius: 12px;

    background: #D9D4C7;

    color: #333;
    font-size: 16px;
    font-weight: bold;

    cursor: pointer;

    transition: 0.3s;
}

/* ホバー */
button:hover {
    transform: translateY(-3px);
    background: #A69E94;
    box-shadow: 0 8px 15px rgba(176,224,230,0.5);
}

/* 下の文字 */
.sub-text {
    margin-top: 18px;
    color: white;
    font-size: 13px;
    opacity: 0.9;
}
</style>

</head>

<body>

<div class="login-box">

    <h2 class="login-title">得点管理</h2>

    <form action="login" method="post">

        <input
            type="text"
            name="username"
            placeholder="ユーザー名"
        >

        <input
            type="password"
            name="password"
            id="password"
            placeholder="パスワード"
        >

        <!-- パスワード表示 -->
        <div class="show-password">

            <input
                type="checkbox"
                id="showPassword"
            >

            <label for="showPassword">
                パスワードを表示
            </label>

        </div>

        <button type="submit">
            ログイン
        </button>

    </form>

    <p class="sub-text">
    </p>

</div>

<!-- JavaScript -->
<script>

const password = document.getElementById("password");
const showPassword = document.getElementById("showPassword");

showPassword.addEventListener("change", () => {

    if(showPassword.checked) {
        password.type = "text";
    } else {
        password.type = "password";
    }

});

</script>

</body>
</html>
