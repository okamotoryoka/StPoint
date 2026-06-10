<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "生徒登録"); %>
<%@ include file="../header.html" %>

<style>
    /* 左右レイアウトの枠組み */
    .layout-wrapper { display: flex; width: 100%; min-height: 100vh; }
    
    /* 左側メニューの幅指定 */
    .side-menu { width: 200px; background-color: #f8f9fa; border-right: 1px solid #e2e8f0; padding: 20px 0; }
    
    /* 右側メインエリア */
    .main-content { flex: 1; padding: 24px; }
    .page-panel { max-width: 800px; margin: 0 auto; }
    
    h1 { font-size: 20px; color: #333; margin-bottom: 20px; }
    .info-card { background: #fff; padding: 20px; border: 1px solid #e2e8f0; border-radius: 4px; }
    
    .msg-error { background-color: #fff6f6; border: 1px solid #f9d3d3; color: #cd3d3d; padding: 16px; border-radius: 8px; margin-bottom: 24px; font-size: 14px; }
    .stacked-form { display: flex; flex-direction: column; gap: 16px; }
    .stacked-form label { font-size: 13px; font-weight: bold; color: #4a5568; }
    .stacked-form input { width: 100%; height: 38px; padding: 0 10px; border: 1px solid #cbd5e0; border-radius: 4px; margin-top: 4px; }
    .form-actions input[type="submit"] { background-color: #4a5568; color: white; padding: 10px 24px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
    .actions { margin-top: 20px; }
    .link-next { color: #3182ce; text-decoration: none; font-size: 14px; }
</style>

<div class="layout-wrapper">
    <div class="side-menu">
        <jsp:include page="../tag.jsp" />
    </div>

    <main class="main-content">
        <div class="page-panel">
            <h1>学生情報登録</h1>
            <section class="info-card">
                <%-- エラー表示 --%>
                <% String err = (String)request.getAttribute("err"); %>
                <% if (err != null) { %>
                  <div class="msg-error">
                    <% if ("required".equals(err)) { %>名前・学籍番号は必須入力です。<% }
                       else if ("duplicate".equals(err)) { %>学生番号が重複しています。<% }
                       else { %>エラーが発生しました。<% } %>
                  </div>
                <% } %>

                <form class="stacked-form" action="<%= request.getContextPath() %>/StudentCreateExecute.action" method="post">
                    <label>名前<input type="text" name="name" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"></label>
                    <label>学籍番号<input type="text" name="no" value="<%= request.getAttribute("no") != null ? request.getAttribute("no") : "" %>"></label>
                    <label>入学年度<input type="number" name="entYear" value="<%= request.getAttribute("entYear") != null ? request.getAttribute("entYear") : "" %>"></label>
                    <label>クラス<input type="text" name="classNum" value="<%= request.getAttribute("classNum") != null ? request.getAttribute("classNum") : "" %>"></label>
                    <div class="form-actions"><input type="submit" value="登録"></div>
                </form>
            </section>
            <p class="actions"><a class="link-next" href="<%= request.getContextPath() %>/StudentList.action?isAttend=false">戻る</a></p>
        </div>
    </main>
</div>

<%@ include file="../footer.jsp" %>