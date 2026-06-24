<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="google" content="notranslate">
<title>得点管理システム</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
<style>
    .system-layout { display: flex; width: 100%; min-height: 100vh; }
    .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; padding-top: 20px; }
    .main-content { flex: 1; padding: 30px; }

    .search-section { display: flex; align-items: center; padding: 15px 0; }
    .search-section-border { border-bottom: 1px dashed #ddd; }
    .section-title { width: 100px; font-weight: bold; color: #666; }
    .form-margin { margin-right: 15px; }
    .input-student-id { width: 230px; background: #fff; border: 1px solid #ccc; border-radius: 4px; padding: 4px 8px; box-sizing: border-box; }
    .initial-message { text-align: center; color: #999; margin-top: 20px; }

    .grade-criteria-box {
        display: flex;
        align-items: center;
        background-color: #f8f9fa;
        border: 1px solid #e0e0e0;
        border-radius: 4px;
        padding: 10px 15px;
        margin-top: 20px;
        font-size: 13px;
        color: #555;
    }
    .criteria-title {
        font-weight: bold;
        margin-right: 15px;
        border-right: 2px solid #ccc;
        padding-right: 15px;
        color: #333;
    }
    .criteria-item {
        margin-right: 20px;
        display: flex;
        align-items: center;
    }
    .badge-red { color: red; font-weight: bold; }
    .badge-blue { color: #0066cc; font-weight: bold; }

    /* ★赤点のマス目だけを薄い赤（ピンク）にするスタイル */
    .score-cell-danger {
        background-color: #ffeaea !important;
    }
</style>
</head>
<body>

<%
String entYear = (String) request.getAttribute("selectedYear");
String classNum = (String) request.getAttribute("selectedClass");
String subjectCd = (String) request.getAttribute("selectedSubjectCd");
String studentId = (String) request.getAttribute("selectedStudentId");
String gradeStr = (String) request.getAttribute("selectedGrade");

if (entYear == null) entYear = "";
if (classNum == null) classNum = "";
if (subjectCd == null) subjectCd = "";
if (studentId == null) studentId = "";
if (gradeStr == null) gradeStr = "";

String selectedSubjectName = (String) request.getAttribute("selectedSubjectName");
List<Map<String, Object>> scoreDisplayList = (List<Map<String, Object>>) request.getAttribute("scoreDisplayList");
List<String> gradeList = (List<String>) request.getAttribute("gradeList");
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
                
                <div class="form-group form-margin">
                    <label class="form-label">学年</label>
                    <select name="grade" class="form-select">
                        <option value="" <%= gradeStr.equals("") ? "selected" : "" %>>--------</option>
                        <% if (gradeList != null) { for (String g : gradeList) { %>
                            <option value="<%= g %>" <%= gradeStr.equals(g) ? "selected" : "" %>><%= g %>年</option>
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
            <div class="subject-info-header" style="margin-top: 25px;">科目：<%= selectedSubjectName %></div>
        <% } %>
        <% if (scoreDisplayList != null && !scoreDisplayList.isEmpty()) { %>
            
            <!-- 評価基準の案内ボックス -->
            <div class="grade-criteria-box">
                <div class="criteria-title">評価基準</div>
                <div class="criteria-item"><span class="badge-red">赤点</span>：40点未満</div>
                <div class="criteria-item"><span>可</span>：40点〜59点</div>
                <div class="criteria-item"><span>良</span>：60点〜79点</div>
                <div class="criteria-item"><span class="badge-blue">優</span>：80点以上</div>
            </div>

            <table class="score-edit-table" style="margin-top: 15px;">
                <thead>
                    <tr>
                        <th>入学年度</th>
                        <th>クラス</th>
                        <th>学生番号</th>
                        <th style="text-align: left; padding-left: 20px;">氏名</th>
                        <th>学年</th>
                        <th>1回</th>
                        <th>1回判定</th>
                        <th>2回</th>
                        <th>2回判定</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Map<String, Object> row : scoreDisplayList) { 
                    // --- 1回目の点数と判定の処理 ---
                    Object score1Obj = row.get("score1");
                    String judgeStr1 = "-";
                    String judgeStyle1 = "color: #333;";
                    
                    if (score1Obj != null) {
                        try {
                            int s1 = Integer.parseInt(score1Obj.toString());
                            if (s1 < 40) { judgeStr1 = "赤点"; judgeStyle1 = "color: red; font-weight: bold;"; }
                            else if (s1 < 60) { judgeStr1 = "可"; }
                            else if (s1 < 80) { judgeStr1 = "良"; }
                            else { judgeStr1 = "優"; judgeStyle1 = "color: #0066cc; font-weight: bold;"; }
                        } catch (NumberFormatException e) {}
                    }

                    // --- 2回目の点数と判定の処理 ---
                    Object score2Obj = row.get("score2");
                    String judgeStr2 = "-";
                    String judgeStyle2 = "color: #333;";
                    
                    if (score2Obj != null) {
                        try {
                            int s2 = Integer.parseInt(score2Obj.toString());
                            if (s2 < 40) { judgeStr2 = "赤点"; judgeStyle2 = "color: red; font-weight: bold;"; }
                            else if (s2 < 60) { judgeStr2 = "可"; }
                            else if (s2 < 80) { judgeStr2 = "良"; }
                            else { judgeStr2 = "優"; judgeStyle2 = "color: #0066cc; font-weight: bold;"; }
                        } catch (NumberFormatException e) {}
                    }
                %>
                <tr>
                    <td><%= row.get("entYear") != null ? row.get("entYear") : "-" %></td>
                    <td><%= row.get("classNum") %></td>
                    <td><%= row.get("studentId") %></td>
                    <td style="text-align: left; padding-left: 20px;"><%= row.get("studentName") %></td>
                    <td><%= row.get("grade") != null && (Integer)row.get("grade") > 0 ? row.get("grade") + "年" : "-" %></td>
                    
                    <!-- 1回目：赤点ならマス目だけをピンクにする -->
                    <td class="<%= "赤点".equals(judgeStr1) ? "score-cell-danger" : "" %>"><%= score1Obj != null ? score1Obj : "-" %></td>
                    <td class="<%= "赤点".equals(judgeStr1) ? "score-cell-danger" : "" %>" style="<%= judgeStyle1 %>"><%= judgeStr1 %></td>
                    
                    <!-- 2回目：赤点ならマス目だけをピンクにする -->
                    <td class="<%= "赤点".equals(judgeStr2) ? "score-cell-danger" : "" %>"><%= score2Obj != null ? score2Obj : "-" %></td>
                    <td class="<%= "赤点".equals(judgeStr2) ? "score-cell-danger" : "" %>" style="<%= judgeStyle2 %>"><%= judgeStr2 %></td>
                </tr>
                <% } %>
                </tbody>
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
        