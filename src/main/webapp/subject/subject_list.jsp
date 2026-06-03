<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="Bean.Subject" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<%@ include file="../header.html" %>

<%-- 画面全体を左メニューと右メインコンテンツに分割するコンテナ --%>
<div class="system-layout" style="display: flex; min-height: 80vh;">

  <jsp:include page="../tag.jsp" />

  <%-- =========================================================
       右側メインコンテンツエリア
       ========================================================= --%>
  <div class="content-body" style="flex: 1; padding: 20px;">

    <h1>科目一覧</h1>

    <%
      // 1. 現在選択されている値と、動的選択肢リストを取得
      String selYear = (request.getAttribute("selectedYear") != null) ? (String)request.getAttribute("selectedYear") : "";
      String selClass = (request.getAttribute("selectedClass") != null) ? (String)request.getAttribute("selectedClass") : "";
      String selSubject = (request.getAttribute("selectedSubject") != null) ? (String)request.getAttribute("selectedSubject") : "";
      String selNo = (request.getAttribute("selectedNo") != null) ? (String)request.getAttribute("selectedNo") : "";

      List<Integer> yearList = (List<Integer>) request.getAttribute("yearList");
      List<String> classList = (List<String>) request.getAttribute("classList");
      
      // 設計図およびJava側の仕様に合わせて List<Subject> 型として受け取るように変更
      List<Subject> subjectList = (List<Subject>) request.getAttribute("subjectList");
      
      List<Integer> countList = (List<Integer>) request.getAttribute("countList"); // 回数リスト（1回、2回など）

      // 設計図に記載されている「いずれかが未入力の場合」の警告メッセージ
      String errorMsg = (request.getAttribute("errorMsg") != null) ? (String)request.getAttribute("errorMsg") : "";
    %>

    <%-- 入力不備がある場合の警告表示 --%>
    <% if (!errorMsg.isBlank()) { %>
      <p style="color: red; font-weight: bold;"><%= errorMsg %></p>
    <% } %>

    <%-- 絞り込みフォーム（送信先を TestRegist.action に変更） --%>
    <form action="${pageContext.request.contextPath}/TestRegist.action" method="post" class="filter-box">
      
      <%-- 入学年度選択 --%>
      <div class="filter-group">
        <label for="entYear">入学年度</label>
        <select name="entYear" id="entYear">
          <option value="">--------</option>
          <% if (yearList != null) { for (int year : yearList) { String yearStr = String.valueOf(year); %>
            <option value="<%= yearStr %>" <%= yearStr.equals(selYear) ? "selected" : "" %>><%= yearStr %></option>
          <% } } %>
        </select>
      </div>

      <%-- クラス選択 --%>
      <div class="filter-group">
        <label for="classNum">クラス</label>
        <select name="classNum" id="classNum">
          <option value="">--------</option>
          <% if (classList != null) { for (String cNum : classList) { %>
            <option value="<%= cNum %>" <%= cNum.equals(selClass) ? "selected" : "" %>><%= cNum %></option>
          <% } } %>
        </select>
      </div>

      <%-- 科目選択 --%>
      <div class="filter-group">
        <label for="subjectCd">科目</label>
        <select name="subjectCd" id="subjectCd">
          <option value="">--------</option>
          <%-- 設計図のクラス定義に基づき、Subjectオブジェクトからゲッターを呼び出すループ処理へ変更 --%>
          <% if (subjectList != null) { for (Subject sub : subjectList) { %>
            <option value="<%= sub.getCd() %>" <%= sub.getCd().equals(selSubject) ? "selected" : "" %>><%= sub.getName() %></option>
          <% } } %>
        </select>
      </div>

      <%-- 回数選択 --%>
      <div class="filter-group">
        <label for="no">回数</label>
        <select name="no" id="no">
          <option value="">--------</option>
          <% if (countList != null) { for (int cnt : countList) { String cntStr = String.valueOf(cnt); %>
            <option value="<%= cntStr %>" <%= cntStr.equals(selNo) ? "selected" : "" %>><%= cntStr %></option>
          <% } } %>
        </select>
      </div>

      <input type="submit" value="検索" class="btn-submit">
    </form>

    <%
      // 学生・成績情報を保持するリストを取得
      List<Map<String, Object>> students = (List<Map<String, Object>>) request.getAttribute("students");
      int count = (students != null) ? students.size() : 0;
    %>

    <p class="result-count">検索結果：<%= count %>件</p>

    <%-- 点数を一括送信して保存するためのフォーム --%>
    <form action="${pageContext.request.contextPath}/TestRegistExecute.action" method="post">
      
      <%-- 登録時に必要な条件を引き継ぐための隠しパラメータ --%>
      <input type="hidden" name="entYear" value="<%= selYear %>">
      <input type="hidden" name="classNum" value="<%= selClass %>">
      <input type="hidden" name="subjectCd" value="<%= selSubject %>">
      <input type="hidden" name="no" value="<%= selNo %>">

      <table class="student-table">
        <thead>
          <tr>
            <th>学生番号</th>
            <th>氏名</th>
            <th>クラス</th>
            <th>点数</th>
          </tr>
        </thead>
        <tbody>
          <%
            if (students != null && !students.isEmpty()) {
                int index = 0;
                for (Map<String, Object> student : students) {
                    String studentId = (String) student.get("student_id");
                    String studentName = (String) student.get("student_name");
                    String classNum = (String) student.get("class_num");
                    String point = (student.get("point") != null) ? String.valueOf(student.get("point")) : "";
          %>
            <tr>
              <td>
                <%= studentId %>
                <input type="hidden" name="studentId_<%= index %>" value="<%= studentId %>">
              </td>
              <td><%= studentName %></td>
              <td><%= classNum %></td>
              <td>
                <input type="text" name="point_<%= index %>" value="<%= point %>" style="width: 60px; text-align: right;">
              </td>
            </tr>
          <%
                  index++;
                }
          %>
            <input type="hidden" name="studentCount" value="<%= index %>">
          <%
            } else {
          %>
            <tr>
              <td colspan="4" style="text-align: center; color: #999;">条件を入力して検索を行ってください。</td>
            </tr>
          <%
            }
          %>
        </tbody>
      </table>

      <%-- 設計図に記載されている「登録して終了」ボタン --%>
      <% if (count > 0) { %>
        <p style="text-align: right; margin-top: 20px;">
          <input type="submit" value="登録して終了" class="btn-submit" style="background-color: #28a745;">
        </p>
      <% } %>
    </form>

    <%-- メニュー戻るボタン --%>
    <p style="margin-top: 20px;">
      <a href="${pageContext.request.contextPath}/result/admin_menu.jsp" class="link-action">メニューへ戻る</a>
    </p>

  </div>
</div>
