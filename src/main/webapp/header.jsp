<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<header style="
    width: 100%;
    height: 80px;
    background-color: #e6f2ff;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 40px;
    box-sizing: border-box;
    border-bottom: 1px solid #ccddee;
">
    <!-- 左側：システムタイトル -->
    <h1 style="margin: 0; font-size: 30px; color: #333; font-weight: bold;">得点管理システム</h1>

    <!-- 右側：ユーザー情報とログアウト -->
    <div style="font-size: 16px; color: #333; font-weight: bold;">
        <span>${sessionScope.userName} 様</span>
        <a href="${pageContext.request.contextPath}/Logout.action" style="margin-left: 20px; color: #0066cc; text-decoration: underline;">ログアウト</a>
    </div>
</header>
