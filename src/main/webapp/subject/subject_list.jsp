<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Subject" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<%@ include file="../header.jsp" %>

<%-- 画面全体を左メニューと右メインコンテンツに分割するコンテナ --%>
<div class="system-layout" style="display: flex; min-height: 80vh; flex-direction: column; position: relative; padding-bottom: 60px;">

  <div style="display: flex; flex: 1;">
    <jsp:include page="../tag.jsp" />

    <%-- =========================================================
         Right Main Content Area
         ========================================================= --%>
    <div class="content-body" style="flex: 1; padding: 20px;">

      <%-- ① タイトル領域とユーザー情報を鼠色の枠の中に統合 --%>
      <div style="background-color: #f5f5f5; padding: 10px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
        <h1 style="margin: 0; font-size: 20px; background: none; padding: 0;">科目管理</h1>
        
      </div>

      <%-- ② 新規登録リンク（右上に配置するためのスタイル） --%>
      <div style="text-align: right; margin-bottom: 10px;">
        <a href="SubjectCreate.action" class="link-action" style="font-size: 14px; text-decoration: none;">新規登録</a>
      </div>

      <%
        // Java側からセットされた科目の全件リストを取得
        List<Subject> subjects = (List<Subject>) request.getAttribute("subjects");
      %>

      <%-- ③〜⑨ 科目一覧テーブル --%>
      <table class="student-table" style="width: 100%; border-collapse: collapse; margin-top: 10px;">
        <thead>
          <tr style="border-bottom: 2px solid #ccc; text-align: left;">
            <th style="padding: 10px; width: 20%;">科目コード</th>
            <th style="padding: 10px; width: 50%;">科目名</th>
            <th style="padding: 10px; width: 15%;"></th>
            <th style="padding: 10px; width: 15%;"></th>
          </tr>
        </thead>
        <tbody>
          <%
            if (subjects != null && !subjects.isEmpty()) {
                for (Subject sub : subjects) {
          %>
            <tr style="border-bottom: 1px solid #eee;">
              <%-- ⑥ 科目コード --%>
              <td style="padding: 12px 10px;"><%= sub.getCd() %></td>
              
              <%-- ⑦ 科目名 --%>
              <td style="padding: 12px 10px;"><%= sub.getName() %></td>
              
              <%-- ⑧ 変更リンク（主キーとなる科目コードをパラメータに付与） --%>
              <td style="padding: 12px 10px; text-align: center;">
                <a href="SubjectUpdate.action?cd=<%= sub.getCd() %>" style="text-decoration: none; color: #337ab7;">変更</a>
              </td>
              
              <%-- ⑨ 削除リンク（主キーとなる科目コードをパラメータに付与） --%>
              <td style="padding: 12px 10px; text-align: center;">
            <a href="${pageContext.request.contextPath}/SubjectDelete.action?cd=<%= sub.getCd() %>" style="text-decoration: none; color: #337ab7;">削除</a>
          
              </td>
            </tr>
          <%
                }
            } else {
          %>
            <tr>
              <td colspan="4" style="text-align: center; padding: 20px; color: #999;">登録されている科目がありません。</td>
            </tr>
          <%
            }
          %>
        </tbody>
      </table>

      <%-- メメニュー戻るボタン --%>
      <p style="margin-top: 30px;">
        <a href="${pageContext.request.contextPath}/menu.jsp" class="link-action">メニューへ戻る</a>
      </p>

    </div>
  </div>

  <%-- 横いっぱいに広がるグレーのフッター帯 --%>
  <div style="position: absolute; bottom: 0; left: 0; width: 100%; background-color: #ebebeb; padding: 12px 0; text-align: center; line-height: 1.6; font-size: 12px; color: #7a7a7a; border-top: 1px solid #dfdfdf;">
      &copy; 2023 TIC<br>
      大原学園
  </div>

</div>
