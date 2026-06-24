<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>得点管理システム</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: sans-serif; background-color: #ffffff; }

        .system-layout { display: flex; width: 100%; min-height: calc(100vh - 80px); }
        .side-menu { width: 220px; min-width: 220px; flex-shrink: 0; border-right: 1px solid #e0e0e0; background-color: #ffffff; }
        .main-content { flex: 1; padding: 30px; box-sizing: border-box; }

        .page-title { background-color: #f0f0f0; padding: 12px 25px; margin-bottom: 25px; width: 100%; max-width: 950px; }
        .page-title h2 { margin: 0; font-size: 26px; font-weight: bold; color: #333; }
    </style>
</head>
<body>

<%
    String entYear = (String) request.getAttribute("entYear");
    String classNum = (String) request.getAttribute("classNum");
    String subjectCd = (String) request.getAttribute("subjectCd");
    String noStr = (String) request.getAttribute("no");
    String gradeStr = (String) request.getAttribute("grade"); // ★学年の保持データ
    List<String> entYearList = (List<String>) request.getAttribute("entYearList");
    List<String> classList = (List<String>) request.getAttribute("classList");
    List<String> gradeList = (List<String>) request.getAttribute("gradeList"); // ★学年リストの受け取り
    Boolean isFirstAccess = (Boolean) request.getAttribute("isFirstAccess");

    if (entYear == null) entYear = "";
    if (classNum == null) classNum = "";
    if (subjectCd == null) subjectCd = "";
    if (noStr == null) noStr = "";
    if (gradeStr == null) gradeStr = "";
%>

<jsp:include page="../header.jsp" />

<div class="system-layout">
    <div class="side-menu">
        <jsp:include page="/tag.jsp" />
    </div>

    <main class="main-content content-body">
        <div class="page-title">
            <h2>成績管理</h2>
        </div>

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
            
            <!-- ★追加: 学年の絞り込みプルダウン -->
            <div class="form-group">
                <label class="form-label">学年</label>
                <select name="grade" class="form-select">
                    <option value="" <%= gradeStr.equals("") ? "selected" : "" %>>--------</option>
                    <% if (gradeList != null) { for (String g : gradeList) { %>
                        <option value="<%= g %>" <%= gradeStr.equals(g) ? "selected" : "" %>><%= g %>年</option>
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
                <label class="form-label">&nbsp;</label>
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
                    <thead>
                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>学年</th> <!-- ★追加: テーブルヘッダーに学年 -->
                            <th>点数</th>
                            <th>判定</th> <!-- ★追加: テーブルヘッダーに判定列を追加 -->
                        </tr>
                    </thead>
                    <tbody>
                        <% Set<String> displayedStudents = new HashSet<>();
                           for(Bean.Score data : list) { 
                               if (displayedStudents.contains(data.getStudentId())) continue;
                               displayedStudents.add(data.getStudentId());

                               // ★追加: 各学生の点数に応じた判定ロジック
                               int score = data.getPoint();
                               String judgeStr = "";
                               String judgeStyle = ""; 

                               if (score < 40) {
                                   judgeStr = "赤点";
                                   judgeStyle = "color: red; font-weight: bold;"; // 赤点時は赤文字かつ太字にする
                               } else if (score < 60) {
                                   judgeStr = "可";
                                   judgeStyle = "color: #333333;";
                               } else if (score < 80) {
                                   judgeStr = "良";
                                   judgeStyle = "color: #333333;";
                               } else {
                                   judgeStr = "優";
                                   judgeStyle = "color: #0066cc; font-weight: bold;"; // 優のときも少し目立たせる（青文字など）
                               }
                        %>
                        <tr>
                            <td><%= data.getEntYear() != null ? data.getEntYear() : "-" %></td>
                            <td><%= data.getClassNum() %></td>
                            <td><%= data.getStudentId() %></td>
                            <td class="student-name-td"><%= data.getStudentName() %></td>
                            <td><%= data.getGrade() > 0 ? data.getGrade() + "年" : "-" %></td> <!-- ★追加: テーブルデータ行に学年 -->
                            <td>
                                <input type="number" name="point_<%= data.getStudentId() %>" value="<%= data.getPoint() %>" min="0" max="100">
                                <input type="hidden" name="studentIds" value="<%= data.getStudentId() %>-<%= data.getSubjectCd() %>-<%= data.getNo() %>">
                            </td>
                            <!-- ★追加: 判定結果を出力する列 -->
                            <td style="<%= judgeStyle %>"><%= judgeStr %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="btn-area"><button type="submit" class="regist-end-btn">登録して終了</button></div>
            </form>
        <% } } %>
    </main>
</div>

<script>
    document.addEventListener("wheel", function(e) {
        if (document.activeElement.type === "number") document.activeElement.blur();
    });
</script>
</body>
</html>
