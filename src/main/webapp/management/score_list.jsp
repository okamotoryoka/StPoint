<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<style>
    .system-layout { display: flex; width: 100%; min-height: 100vh; }
    .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; padding-top: 20px; }
    .main-content { flex: 1; padding: 30px; }

    /* 見出しデザイン：全体の配置を上に調整 */
    .main-content h2 { 
        background-color: #f5f5f5; 
        padding: 20px 25px; 
        font-size: 26px; 
        font-weight: bold; 
        border-bottom: 2px solid #dfdfdf; 
        margin-bottom: 30px; 
        margin-top: -20px; /* ブロック自体を上に上げる調整 */
    }
</style>
</head>
<body>

<%
String entYear = (String) request.getAttribute("entYear");
String classNum = (String) request.getAttribute("classNum");
String subjectCd = (String) request.getAttribute("subjectCd");
String noStr = (String) request.getAttribute("no");
List<String> entYearList = (List<String>) request.getAttribute("entYearList");
List<String> classList = (List<String>) request.getAttribute("classList");
Boolean isFirstAccess = (Boolean) request.getAttribute("isFirstAccess");

if (entYear == null) entYear = "";
if (classNum == null) classNum = "";
if (subjectCd == null) subjectCd = "";
if (noStr == null) noStr = "";
%>

<header class="system-header">
    <div class="header-title">得点管理システム</div>
    <div class="header-user">
        <span>${sessionScope.teacher_name}様</span>
        <a href="Logout.action" class="logout-btn">ログアウト</a>
    </div>
</header>

<div class="system-layout">

    <div class="side-menu">
        <jsp:include page="/tag.jsp" />
    </div>

    <main class="main-content">
        
        <h2>成績管理</h2>

        <div class="right-container">
            <form action="${pageContext.request.contextPath}/ScoreSearch.action" method="post" class="search-form">
                <div class="form-group">
                    <label class="form-label">入学年度</label>
                    <select name="entYear" class="form-select">
                        <option value="" <%= entYear.equals("") ? "selected" : "" %>>--------</option>
                        <% if (entYearList != null) { for (String year : entYearList) { %>
                            <option value="<%= year %>" <%= entYear.equals(year) ? "selected" : "" %>><%= year %></option>
                        <% } } %>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">クラス</label>
                    <select name="classNum" class="form-select">
                        <option value="" <%= classNum.equals("") ? "selected" : "" %>>--------</option>
                        <% if (classList != null) { for (String cNum : classList) { %>
                            <option value="<%= cNum %>" <%= classNum.equals(cNum) ? "selected" : "" %>><%= cNum %></option>
                        <% } } %>
                    </select>
                </div>
                <div class="form-group form-group-wide">
                    <label class="form-label">科目</label>
                    <select name="subjectCd" class="form-select">
                        <option value="" <%= subjectCd.equals("") ? "selected" : "" %>>--------</option>
                        <% List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjectList");
                           if (subjectList != null) { for (Map<String, String> sub : subjectList) { %>
                            <option value="<%= sub.get("cd") %>" <%= subjectCd.equals(sub.get("cd")) ? "selected" : "" %>><%= sub.get("name") %></option>
                        <% } } %>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">回数</label>
                    <select name="no" class="form-select">
                        <option value="" <%= noStr.equals("") ? "selected" : "" %>>--------</option>
                        <option value="1" <%= noStr.equals("1") ? "selected" : "" %>>1</option>
                        <option value="2" <%= noStr.equals("2") ? "selected" : "" %>>2</option>
                    </select>
                </div>
                <div class="form-group form-group-btn">
                    <button type="submit" class="search-btn">検索</button>
                </div>
            </form>

            <%
            ArrayList<Bean.Score> list = (ArrayList<Bean.Score>) request.getAttribute("list");
            if (isFirstAccess == null || !isFirstAccess) {
                if (list != null && !list.isEmpty()) {
                    Bean.Score firstData = list.get(0);
            %>
                <div class="subject-info-header">科目：<%= firstData.getSubjectName() %> （<%= firstData.getNo() %>回）</div>
                <form action="${pageContext.request.contextPath}/ScoreRegist.action" method="post">
                    <table class="score-edit-table">
                        <tr><th>入学年度</th><th>クラス</th><th>学生番号</th><th>氏名</th><th>点数</th></tr>
                        <% Set<String> displayedStudents = new HashSet<>();
                        for(Bean.Score data : list) { 
                            if (displayedStudents.contains(data.getStudentId())) continue;
                            displayedStudents.add(data.getStudentId());
                        %>
                        <tr>
                            <td><%= entYear.equals("") ? data.getEntYear() : entYear %></td>
                            <td><%= data.getClassNum() %></td>
                            <td><%= data.getStudentId() %></td>
                            <td class="student-name-td"><%= data.getStudentName() %></td>
                            <td><input type="number" name="point_<%= data.getStudentId() %>" value="<%= data.getPoint() %>" min="0" max="100">
                                <input type="hidden" name="studentIds" value="<%= data.getStudentId() %>-<%= data.getSubjectCd() %>-<%= data.getNo() %>">
                            </td>
                        </tr>
                        <% } %>
                    </table>
                    <div class="btn-area"><button type="submit" class="regist-end-btn">登録して終了</button></div>
                </form>
            <% } } %>
        </div>
    </main>
</div>
</body>
</html>