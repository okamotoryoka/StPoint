<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Student" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<%@ include file="../header.html" %>
<%-- 全体を囲むメインコンテナ --%>
<div class="content-body">

  <%-- ① タイトル --%>
  <h1>学生管理</h1>

  <%
    // 現在選択されている値と、動的選択肢リストを取得
    String selYear = (request.getAttribute("selectedYear") != null) ? (String)request.getAttribute("selectedYear") : "";
    String selClass = (request.getAttribute("selectedClass") != null) ? (String)request.getAttribute("selectedClass") : "";
    boolean selAttend = (request.getAttribute("selectedAttend") != null) ? (boolean)request.getAttribute("selectedAttend") : true;

    List<Integer> yearList = (List<Integer>) request.getAttribute("yearList");
    List<String> classList = (List<String>) request.getAttribute("classList");
  %>

  <%-- ②〜⑨ 絞り込みフォーム --%>
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

  <%-- ⑧ 新規登録リンク（右寄せ） --%>
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

  <%-- ⑫〜㉒ 学生一覧テーブル --%>
  <table class="student-table">
    <thead>
      <tr>
        <th>入学年度</th>
        <th>学生番号</th>
        <th>氏名</th>
        <th>クラス</th>
        <th style="text-align: center;">在学中</th>
        <th></th> <%-- 操作（変更リンク）用の空見出し --%>
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

<%@ include file="../footer.html" %>
