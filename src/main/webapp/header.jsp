<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header style="background-color: #e3f2fd; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #ccc; font-family: sans-serif;">
  <h1 style="margin: 0; font-size: 24px; color: #333;">得点管理システム</h1>
  
  <div style="font-size: 14px; color: #333;">
    <%-- ログインしている場合のみ名前とログアウトを表示 --%>
    <% if(session.getAttribute("teacher_name") != null) { %>
      <span>${sessionScope.teacher_name}様</span>
      <span style="margin-left: 15px;">
        <a href="${pageContext.request.contextPath}/Logout.action" style="text-decoration: underline; color: #007bff;">ログアウト</a>
      </span>
    <% } %>
  </div>
</header>