<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Student" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<%@ include file="../header.html" %>

<%-- 画面全体を左メニューと右メインコンテンツに分割するコンテナ --%>
<div class="system-layout" style="display: flex; min-height: 80vh;">

  <%-- =========================================================
       左側サイドメニューエリア（追加箇所）
       ========================================================= --%>
  <div class="sidebar-menu" style="width: 200px; padding: 20px; background-color: #f5f5f5; border-right: 1px solid #ddd;">
    
    <%-- メニューへのリンク --%>
    <div style="margin-bottom: 15px;">
      <a href="${pageContext.request.contextPath}/result/admin_menu.jsp" style="font-weight: bold; text-decoration: none; color: #333;">メニュー</a>
    </div>

    <%-- 学生管理（現在のアクティブ画面） --%>
    <div style="margin-bottom: 15px;">
      <a href="${pageContext.request.contextPath}/StudentList.action" style="font-weight: bold; text-decoration: none; color: #0066cc;">学生管理</a>
    </div>

    <%-- 成績管理エリア（子メニュー付き） --%>
    <div style="margin-bottom: 15px;">
      <span style="font-weight: bold; color: #333;">成績管理</span>
      <ul style="list-style: none; padding-left: 15px; margin-top: 5px;">
        <%-- 成績登録へのアクションURLを接続 --%>
        <li style="margin-bottom: 5px;">
          <a href="${pageContext.request.contextPath}/ScoreRegister.action" style="text-decoration: none; color: #666;">成績登録</a>
        </li>
        <%-- 成績参照へのアクションURLを接続 --%>
        <li style="margin-bottom: 5px;">
          <a href="${pageContext.request.contextPath}/ScoreSearch.action" style="text-decoration: none; color: #666;">成績参照</a>
        </li>
      </ul>
    </div>

    <%-- 科目管理エリア --%>
    <div style="margin-bottom: 15px;">
      <%-- 科目管理へのアクションURLを接続 --%>
      <a href="${pageContext.request.contextPath}/ScoreListServlet.action" style="font-weight: bold; text-decoration: none; color: #333;">科目管理</a>
    </div>

  </div>


  <%-- =========================================================
       右側メインコンテンツエリア
       ========================================================= --%>
  <div class="content-body" style="flex: 1; padding: 20px;">

    <%-- タイトル --%>
    <h1>学生管理</h1>

    <%
      // 現在選択されている値と、動的選択肢リストを取得
      String selYear = (request.getAttribute("selectedYear") != null) ? (String)request.getAttribute("selectedYear") : "";
      String selClass = (request.getAttribute("selectedClass") != null) ? (String)request.getAttribute("selectedClass") : "";
      boolean selAttend = (request.getAttribute("selectedAttend") != null) ? (boolean)request.getAttribute("selectedAttend") : true;

      List<Integer> yearList = (List<Integer>) request.getAttribute("yearList");
      List<String> classList = (List<String>) request.getAttribute("classList");
    %>

    <%-- 絞り込みフォーム --%>
    <form action="${pageContext.request.contextPath}/StudentList.action" method="post" class="filter-box">
      
      <%-- 入学年度選択グループ --%>
      <div class="filter-group">
        <label for="entYear">入学年度</label>
        <select name="entYear" id="entYear">
          <option value="">--------</option>
          <%
            if (yearList != null) {
                for (int year : yearList) {
                    String yearStr = String.valueOf(year);
          %>
            <option value="<%= yearStr %>" <%= yearStr.equals(selYear) ? "selected" : "" %>><%= yearStr %></option>
          <%
                }
            }
          %>
        </select>
      </div>

      <%-- クラス選択グループ --%>
      <div class="filter-group">
        <label for="classNum">クラス</label>
        <select name="classNum" id="classNum">
          <option value="">--------</option>
          <%
            if (classList != null) {
                for (String cNum : classList) {
          %>
            <option value="<%= cNum %>" <%= cNum.equals(selClass) ? "selected" : "" %>><%= cNum %></option>
          <%
                }
            }
          %>
        </select>
      </div>

      <%-- 在学中チェックボックスグループ --%>
      <div class="checkbox-group">
        <input type="checkbox" name="isAttend" id="isAttend" value="true" <%= selAttend ? "checked" : "" %>>
        <label for="isAttend">在学中</label>
      </div>

      <%-- 絞込みボタン --%>
      <input type="submit" value="絞込み" class="btn-submit">
    </form>

    <%-- 新規登録リンク --%>
    <p style="text-align: right;">
      <a href="${pageContext.request.contextPath}/StudentCreate.action" class="link-create">新規登録</a>
    </p>

    <%
      // Actionクラスから送られてきたリストと件数の取得
      List<Student> students = (List<Student>) request.getAttribute("students");
      int count = (students != null) ? students.size() : 0;
    %>

    <%-- 検索結果件数表示 --%>
    <p class="result-count">検索結果：<%= count %>件</p>

    <%-- 学生一覧テーブル --%>
    <table class="student-table">
      <thead>
        <tr>
          <th>入学年度</th>
          <th>学生番号</th>
          <th>氏名</th>
          <th>クラス</th>
          <th style="text-align: center;">在学中</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <%
          if (students != null && !students.isEmpty()) {
              for (Student student : students) {
        %>
          <tr>
            <td><%= student.getEntYear() %></td>
            <td><%= student.getNo() %></td>
            <td><%= student.getName() %></td>
            <td><%= student.getClassNum() %></td>
            <td style="text-align: center;">
              <% if (student.isAttend()) { %>○<% } else { %>×<% } %>
            </td>
        
            <td>
              <a href="${pageContext.request.contextPath}/StudentUpdate.action?no=<%= student.getNo() %>" class="link-action">変更</a>
            </td>
          </tr>
        <%
              }
          } else {
        %>
          <tr>
            <td colspan="6" style="text-align: center; color: #999;">学生が登録されていません。</td>
          </tr>
        <%
          }
        %>
      </tbody>
    </table>

    <%-- メニュー戻るボタン --%>
    <p style="margin-top: 20px;">
      <a href="${pageContext.request.contextPath}/result/admin_menu.jsp" class="link-action">メニューへ戻る</a>
    </p>

  </div>
</div>

<%@ include file="../footer.html" %>
