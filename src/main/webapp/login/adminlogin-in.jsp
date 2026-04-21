<%@ page contentType="text/html; charset=UTF-8" %>
<% request.setAttribute("pageTitle", "管理者ログイン"); %>
<%@ include file="../header.html" %>

<main class="page-panel">
  <h1>管理者ログイン</h1>

  <section class="info-card">
    <form class="stacked-form" action="${pageContext.request.contextPath}/AdminLogin.action" method="post">
      <p><label>ログイン名<br>
        <input type="text" name="admin_name" autocomplete="username"></label></p>

      <p><label>パスワード<br>
        <input type="password" name="password" autocomplete="current-password"></label></p>

      <p class="form-actions"><input type="submit" value="ログイン"></p>
    </form>
  </section>
</main>

<%@ include file="../footer.html" %>