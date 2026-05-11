<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% request.setAttribute("pageTitle", "教師登録"); %>
<%@ include file="../header.html" %>

<main class="page-panel">
  <h1>教師登録</h1>

  <section class="info-card">
  <% if ("1".equals(request.getParameter("ok"))) { %>
  <p class="msg msg-ok">更新しました。</p>
<% } %>

<% if ("required".equals(request.getParameter("err"))) { %>
  <p class="msg msg-error">教師ID・名前・パスワードは必須です。</p>
<% } else if ("year".equals(request.getParameter("err"))) { %>
  <p class="msg msg-error">学年は数値で入力してください。</p>
<% } else if ("insert".equals(request.getParameter("err"))) { %>
  <p class="msg msg-error">教師登録に失敗しました。</p>
<% } else if ("system".equals(request.getParameter("err"))) { %>
  <p class="msg msg-error">登録中にエラーが発生しました。</p>
<% } %>
    <form class="stacked-form" action="<%= request.getContextPath() %>/Admin.action" method="post">
      <p><label>名前<br><input type="text" name="name"></label></p>
      <p><label>教師ID<br><input type="text" name="teacherId"></label></p>
      <p><label>パスワード<br><input type="password" name="password"></label></p>
      <p><label>担当科目<br><input type="text" name="courseId"></label></p>
      <p><label>学年<br><input type="text" name="year"></label></p>
      <p class="form-actions"><input type="submit" value="登録"></p>
    </form>
  </section>


  <p class="actions">
    <a class="link-next" href="<%= request.getContextPath() %>/login_function/logout-out.jsp">ログアウトする</a>
  </p>
</main>

<%@ include file="../footer.html" %>


