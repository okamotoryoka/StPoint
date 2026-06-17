<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    border-bottom: 2px solid #ccc;
    font-family: sans-serif;
">
    <h1 style="margin: 0; font-size: 30px; color: #333; font-weight: bold;">得点管理システム</h1>

    <div style="font-size: 16px; color: #333; font-weight: bold;">
        <%-- ログインしている場合のみ表示 --%>
        <% if(session.getAttribute("teacher_name") != null) { %>
            <span>${sessionScope.teacher_name} 様</span>
            <a href="${pageContext.request.contextPath}/Logout.action" 
               style="margin-left: 20px; color: #0066cc; text-decoration: underline;">ログアウト</a>
        <% } %>
    </div>
</header>