<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
<style>
    /* 成功している画面とレイアウト構造を統一 */
    .system-layout { display: flex; width: 100%; min-height: 100vh; }
    .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; padding-top: 20px; }
    .main-content { flex: 1; padding: 30px; }

    /* 既存の検索フォーム用のスタイル */
    .search-section { display: flex; align-items: center; padding: 15px 0; }
    .search-section-border { border-bottom: 1px dashed #ddd; }
    .section-title { width: 100px; font-weight: bold; color: #666; }
    .form-margin { margin-right: 15px; }
    .input-student-id { width: 230px; background: #fff; border: 1px solid #ccc; border-radius: 4px; padding: 4px 8px; box-sizing: border-box; }
    .initial-message { text-align: center; color: #999; margin-top: 20px; }
</style>
</head>
<body>

<%
String entYear = (String) request.getAttribute("selectedYear");
String classNum = (String) request.getAttribute("selectedClass");
String subjectCd = (String) request.getAttribute("selectedSubjectCd");
String studentId = (String) request.getAttribute("selectedStudentId");

if (entYear == null) entYear = "";
if (classNum == null) classNum = "";
if (subjectCd == null) subjectCd = "";
if (studentId == null) studentId = "";

String selectedSubjectName = (String) request.getAttribute("selectedSubjectName");
List<Map<String, Object>> scoreDisplayList = (List<Map<String, Object>>) request.getAttribute("scoreDisplayList");
%>

<jsp:include page="../header.jsp" />

<div class="system-layout">
    <div class="side-menu">
        <jsp:include page="/tag.jsp" />
    </div>

    <main class="main-content">
        <div class="search-title">成績一覧（科目）</div>

        <form action="${pageContext.request.contextPath}/ScoreSubject.action" method="get" class="search-form">
            <div class="search-section search-section-border">
                <div class="section-title">科目情報</div>
                <div class="form-group form-margin">
                    <label class="form-label">入学年度</label>
                    <select name="entYear" class="form-select">
                        <option value="" <%= entYear.equals("") ? "selected" : "" %>>--------</option>
                        <% List<String> entYearList = (List<String>) request.getAttribute("entYearList");
                           if (entYearList != null) { for (String year : entYearList) { %>
                            <option value="<%= year %>" <%= entYear.equals(year) ? "selected" : "" %>><%= year %></option>
                        <% } } %>
                    </select>
                </div>
                <div class="form-group form-margin">
                    <label class="form-label">クラス</label>
                    <select name="classNum" class="form-select">
                        <option value="" <%= classNum.equals("") ? "selected" : "" %>>--------</option>
                        <% List<String> classNumList = (List<String>) request.getAttribute("classNumList");
                           if (classNumList != null) { for (String clazz : classNumList) { %>
                            <option value="<%= clazz %>" <%= classNum.equals(clazz) ? "selected" : "" %>><%= clazz %></option>
                        <% } } %>
                    </select>
                </div>
                <div class="form-group form-group-wide form-margin">
                    <label class="form-label">科目</label>
                    <select name="subjectCd" class="form-select" style="width: 250px;">
                        <option value="" <%= subjectCd.equals("") ? "selected" : "" %>>--------</option>
                        <% List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjects");
                           if (subjectList != null) { for (Map<String, String> sub : subjectList) { %>
                            <option value="<%= sub.get("cd") %>" <%= subjectCd.equals(sub.get("cd")) ? "selected" : "" %>><%= sub.get("name") %></option>
                        <% } } %>
                    </select>
                </div>
                <button type="submit" class="search-btn">検索</button>
            </div>

            <div class="search-section">
                <div class="section-title">学生情報</div>
                <div class="form-group">
                    <label class="form-label">学生番号</label>
                    <input type="text" name="studentId" value="<%= studentId %>" class="input-student-id">
                </div>
                <button type="submit" class="search-btn" style="margin-left: 20px;">検索</button>
            </div>
        </form>

        <% if (selectedSubjectName != null && !selectedSubjectName.isEmpty()) { %>
            <div class="subject-info-header">科目：<%= selectedSubjectName %></div>
        <% } %>

        <% if (scoreDisplayList != null && !scoreDisplayList.isEmpty()) { %>
            <table class="score-edit-table" style="margin-top: 20px;">
                <tr>
                    <th>入学年度</th>
                    <th>クラス</th>
                    <th>学生番号</th>
                    <th>氏名</th>
                    <th>1回</th>
                    <th>2回</th>
                </tr>
                <% for (Map<String, Object> row : scoreDisplayList) { %>
                <tr>
                    <td><%= row.get("entYear") %></td>
                    <td><%= row.get("classNum") %></td>
                    <td><%= row.get("studentId") %></td>
                    <td style="text-align: left; padding-left: 20px;"><%= row.get("studentName") %></td>
                    <td><%= row.get("score1") %></td>
                    <td><%= row.get("score2") %></td>
                </tr>
                <% } %>
            </table>
        <% } else if (scoreDisplayList != null && scoreDisplayList.isEmpty()) { %>
            <div class="initial-message">該当する成績データが見つかりませんでした。</div>
        <% } else { %>
            <div class="initial-message">科目情報を選択または学生情報を入力して検索ボタンをクリックしてください</div>
        <% } %>
    </main>
</div>

</body>
</html>