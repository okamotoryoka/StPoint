<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "生徒登録"); %>
<%@ include file="../header.html" %>

<main class="page-panel">
  <h1>生徒登録</h1>

  <section class="info-card">

    <%-- エラーメッセージの表示（Java側のキー名と完全連動） --%>
    <% String err = (String)request.getAttribute("err"); %>
    <% if (err != null) { %>
      <p class="msg msg-error" style="color: red; font-weight: bold; background: #ffe0e0; padding: 10px;">
        <% if ("required".equals(err)) { %>名前・学籍番号は必須入力です。<% } %>
        <% if ("year_empty".equals(err)) { %>入学年度を選択してください。<% } %>
        <% if ("year_invalid".equals(err)) { %>入学年度を正しい数値で入力してください。<% } %>
        <% if ("duplicate".equals(err)) { %>学生番号が重複しています。<% } %>
        <% if ("insert_failed".equals(err)) { %>登録に失敗しました。<% } %>
      </p>
    <% } %>

    <form class="stacked-form" action="<%= request.getContextPath() %>/StudentCreateExecute.action" method="post">
      
      <%-- 
        エラー時にJava側から戻された値を取り出す 
        （値がなければ空文字にする処理）
      --%>
      <%
        String nameVal = request.getAttribute("name") != null ? (String)request.getAttribute("name") : "";
        String noVal = request.getAttribute("no") != null ? (String)request.getAttribute("no") : "";
        String entYearVal = request.getAttribute("entYear") != null ? (String)request.getAttribute("entYear") : "";
        String classNumVal = request.getAttribute("classNum") != null ? (String)request.getAttribute("classNum") : "";
      %>
      
      <p><label>名前<br>
        <input type="text" name="name" value="<%= nameVal %>"></label></p>
      
      <p><label>学籍番号<br>
        <input type="text" name="no" value="<%= noVal %>"></label></p>
      
      <p><label>入学年度<br>
        <input type="number" name="entYear" value="<%= entYearVal %>"></label></p>
      
      <p><label>クラス<br>
        <input type="text" name="classNum" value="<%= classNumVal %>"></label></p>
      
      <p class="form-actions"><input type="submit" value="登録"></p>
    </form>
  </section>

  <p class="actions">
    <%-- 同じresultフォルダ内にあるため直接ファイル名を指定します --%>
    <a class="link-next" href="result/admin_menu.jsp">メニューへ戻る</a>
  </p>
</main>

<%@ include file="../footer.html" %>
