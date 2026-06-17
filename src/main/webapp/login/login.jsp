<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ログイン - 得点管理システム</title>
    <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { min-height: 100vh; display: flex; flex-direction: column; font-family: "Noto Sans JP", sans-serif; background: #fdfdfd; }
    
    .main-content { flex: 1; display: flex; justify-content: center; align-items: center; }
    .login-box { width: 420px; background: #ffffff; border: 1px solid #e2e8f0; border-radius: 4px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); padding: 40px; text-align: center; }
    .error-message { background-color: #fff6f6; border: 1px solid #f9d3d3; color: #cd3d3d; padding: 16px; border-radius: 8px; margin-bottom: 24px; text-align: left; font-size: 14.5px; }
    .form-group { margin-bottom: 16px; text-align: left; }
    .input-label { display: block; font-size: 11px; color: #888; margin-bottom: 4px; }
    input[type="text"], input[type="password"] { width: 100%; height: 38px; padding: 0 10px; border: 1px solid #ccc; border-radius: 4px; }
    .checkbox-group { display: flex; align-items: center; font-size: 13px; color: #333; margin-top: 4px; margin-bottom: 24px; }
    .checkbox-group input { margin-right: 6px; cursor: pointer; }
    button { width: 40%; padding: 10px; border: none; border-radius: 6px; background: #0066ec; color: #fff; font-weight: bold; cursor: pointer; }
    .login-footer { background-color: #ebebeb; padding: 12px 0; text-align: center; font-size: 12px; color: #7a7a7a; border-top: 1px solid #dfdfdf; }
    </style>
</head>
<body>

    <%-- 共通ヘッダーを読み込み --%>
    <%@ include file="/header.jsp" %>

    <main class="main-content">
        <div class="login-box">
            <form action="${pageContext.request.contextPath}/Login.action" method="post">
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message"><%= request.getAttribute("error") %></div>
                <% } %>
                
                <div class="form-group">
                    <span class="input-label">ID</span>
                    <input type="text" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" required>
                </div>

                <div class="form-group">
                    <span class="input-label">パスワード</span>
                    <input type="password" name="password" id="password-input" required>
                </div>

                <div class="checkbox-group">
                    <input type="checkbox" id="show-password">
                    <label for="show-password">パスワードを表示</label>
                </div>

                <button type="submit">ログイン</button>
            </form>
        </div>
    </main>

    <footer class="login-footer">
        &copy; 2023 TIC<br>大原学園
    </footer>

    <script>
        document.getElementById('show-password').addEventListener('change', function() {
            const passwordInput = document.getElementById('password-input');
            passwordInput.type = this.checked ? 'text' : 'password';
        });
    </script>
</body>
</html>