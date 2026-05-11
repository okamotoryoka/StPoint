<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "生徒登録"); %>
<%@ include file="../header.html" %>

<main class="page-panel">
  <h1>生徒登録</h1>

  <section class="info-card">
    <%-- 成功メッセージの表示 --%>
    <% if ("1".equals(request.getAttribute("ok"))) { %>
      <p class="msg msg-ok" style="color: blue; font-weight: bold; background: #e0f0ff; padding: 10px;">
        生徒の登録が完了しました。
      </p>
    <% } %>

    <%-- エラーメッセージの表示 --%>
    <% String err = (String)request.getAttribute("err"); %>
    <% if (err != null) { %>
      <p class="msg msg-error" style="color: red; font-weight: bold; background: #ffe0e0; padding: 10px;">
        <% if ("required".equals(err)) { %>名前・学籍番号は必須入力です。<% } %>
        <% if ("year".equals(err)) { %>入学年度を数値で入力してください。<% } %>
        <% if ("insert".equals(err)) { %>登録に失敗しました（学籍番号重複など）。<% } %>
      </p>
    <% } %>

    <form class="stacked-form" action="<%= request.getContextPath() %>/StudentCreateExecute.action" method="post">
      <%-- 成功（ok）の時は値を空にし、エラー（err）の時は値を保持する --%>
      <% boolean isOk = "1".equals(request.getAttribute("ok")); %>
      
      <p><label>名前<br>
        <input type="text" name="name" value="<%= !isOk && request.getParameter("name") != null ? request.getParameter("name") : "" %>"></label></p>
      
      <p><label>学籍番号<br>
        <input type="text" name="no" value="<%= !isOk && request.getParameter("no") != null ? request.getParameter("no") : "" %>"></label></p>
      
      <p><label>入学年度<br>
        <input type="number" name="entYear" value="<%= !isOk && request.getParameter("entYear") != null ? request.getParameter("entYear") : "" %>"></label></p>
      
      <p><label>クラス<br>
        <input type="text" name="classNum" value="<%= !isOk && request.getParameter("classNum") != null ? request.getParameter("classNum") : "" %>"></label></p>
      
      <p class="form-actions"><input type="submit" value="登録"></p>
    </form>
  </section>

  <p class="actions">
    <a class="link-next" href="admin_menu.jsp">メニューへ戻る</a>
  </p>
</main>

<%@ include file="../footer.html" %>
