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

    <%-- タイトル領域とユーザー情報 --%>
    <div style="background-color: #f5f5f5; padding: 10px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
      <h1 style="margin: 0; font-size: 20px; background: none; padding: 0;">科目管理</h1>
      
      <div class="user-info" style="font-size: 14px;">
          ${sessionScope.teacher_name}様
          <a href="Logout.action" style="margin-left: 5px;">ログアウト</a>
      </div>
    </div>

    <%-- 削除確認のコンテンツエリア --%>
    <h2 style="font-size: 18px; margin-bottom: 10px;">科目削除確認</h2>
    
    <p style="color: #d9534f; font-weight: bold; margin-bottom: 15px;">以下の科目を削除します。よろしいですか？</p>

    <%-- 削除対象のデータ表示（提示いただいた更新画面と同じEL式を使用） --%>
    <table class="student-table" style="width: 50%; border-collapse: collapse; margin-top: 10px; margin-bottom: 20px;">
      <tr style="border-bottom: 1px solid #eee;">
        <th style="padding: 10px; background-color: #f9f9f9; width: 30%; text-align: left;">科目コード</th>
        <td style="padding: 10px;">${subject.cd}</td>
      </tr>
      <tr style="border-bottom: 1px solid #eee;">
        <th style="padding: 10px; background-color: #f9f9f9; text-align: left;">科目名</th>
        <td style="padding: 10px;">${subject.name}</td>
      </tr>
    </table>

    <!-- 削除を実行するActionへポストするフォーム -->
    <form action="SubjectDeleteExecute.action" method="post" style="margin-top: 20px;">
        <!-- 削除対象の主キー（cd）を隠しパラメータとして送信 -->
        <input type="hidden" name="cd" value="${subject.cd}">
        
        <input type="submit" value="削除を確定する" class="link-action" style="background-color: #d9534f; color: white; border: none; padding: 8px 15px; cursor: pointer; font-size: 14px; border-radius: 4px; margin-right: 10px;">
        <a href="SubjectList.action" style="text-decoration: none; color: #337ab7; font-size: 14px;">キャンセルして一覧に戻る</a>
    </form>

  </div>
</div>
