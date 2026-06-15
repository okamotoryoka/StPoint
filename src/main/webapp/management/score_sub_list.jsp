<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
<style>
    .search-section { display: flex; align-items: center; padding: 15px 0; }
    .search-section-border { border-bottom: 1px dashed #ddd; }
    .section-title { width: 100px; font-weight: bold; color: #666; }
    .form-margin { margin-right: 15px; }
    .input-student-id { width: 230px; background: #fff; border: 1px solid #ccc; border-radius: 4px; padding: 4px 8px; }
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

<header class="system-header">
    <div class="header-title">得点管理システム</div>
</header>

<div class="main-layout">
    <div class="left-menu-area"><jsp:include page="/tag.jsp" /></div>
    <div class="content-body">
        <div class="right-container">
            <div class="search-title">成績一覧（科目）</div>

            <form action="${pageContext.request.contextPath}/ScoreSubjectAction.action" method="get" class="search-form">
                <div class="search-section search-section-border">
                    <div class="section-title">科目情報</div>
                    <div class="form-group form-margin">
                        <label class="form-label">入学年度</label>
                        <select name="entYear" class="form-select">
                            <option value="">--------</option>
                            <%
                            List<String> entYearList = (List<String>) request.getAttribute("entYearList");
                            if (entYearList != null) {
                                for (String year : entYearList) {
                            %>
                                <option value="<%= year %>" <%= entYear.equals(year) ? "selected" : "" %>><%= year %></option>
                            <% } } %>
                        </select>
                    </div>
                    <div class="form-group form-margin">
                        <label class="form-label">クラス</label>
                        <select name="classNum" class="form-select">
                            <option value="">--------</option>
                            <%
                            List<String> classNumList = (List<String>) request.getAttribute("classNumList");
                            if (classNumList != null) {
                                for (String clazz : classNumList) {
                            %>
                                <option value="<%= clazz %>" <%= classNum.equals(clazz) ? "selected" : "" %>><%= clazz %></option>
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

            <% if (selectedSubjectName != null) { %>
                <div class="subject-info-header">科目：<%= selectedSubjectName %></div>
            <% } %>

            <table class="score-edit-table">
                <tr>
                    <th>入学年度</th><th>クラス</th><th>学生番号</th><th>氏名</th><th>1回</th><th>2回</th>
                </tr>
                <% if (scoreDisplayList != null && !scoreDisplayList.isEmpty()) { 
                    for (Map<String, Object> row : scoreDisplayList) { %>
                <tr>
                    <td><%= row.get("entYear") %></td>
                    <td><%= row.get("classNum") %></td>
                    <td><%= row.get("studentId") %></td>
                    <td><%= row.get("studentName") %></td>
                    <td><%= row.get("score1") %></td>
                    <td><%= row.get("score2") %></td>
                </tr>
                <% } } else { %>
                <tr><td colspan="6" style="text-align: center;">データが見つかりませんでした。</td></tr>
                <% } %>
            </table>
        </div>
    </div>
</div>
</body>
</html>