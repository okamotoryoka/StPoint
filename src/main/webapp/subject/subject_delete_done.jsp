<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<%@ include file="../header.html" %>

<%-- 画面全体を左メニューと右メインコンテンツに分割するコンテナ --%>
<div class="system-layout" style="display: flex; min-height: 80vh;">

  <jsp:include page="../tag.jsp" />

  <%-- =========================================================
       Right Main Content Area
       ========================================================= --%>
  <div class="content-body" style="flex: 1; padding: 20px;">

    <%-- タイトル領域とユーザー情報（更新画面などと統一） --%>
    <div style="background-color: #f5f5f5; padding: 10px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
      <h1 style="margin: 0; font-size: 20px; background: none; padding: 0;">科目管理</h1>
      
      <div class="user-info" style="font-size: 14px;">
          ${sessionScope.teacher_name}様
          <a href="Logout.action" style="margin-left: 5px;">ログアウト</a>
      </div>
    </div>

    <%-- 💡 ご提示いただいた完了メッセージ部分 --%>
    <h2>科目情報の削除</h2>
    <p style="color: green; font-weight: bold; margin-bottom: 20px;">科目の削除が完了しました。</p>
    
    <br>
    <a href="SubjectList.action" style="text-decoration: none; color: #337ab7;">科目一覧へ戻る</a>

  </div>
</div>
