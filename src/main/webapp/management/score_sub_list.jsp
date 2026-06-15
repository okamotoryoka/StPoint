<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
<style>
    /* 2段の検索フォームを綺麗に整えるための追加スタイル */
    .search-section {
        display: flex;
        align-items: center;
        padding: 15px 0;
    }
    .search-section-border {
        border-bottom: 1px dashed #ddd;
    }
    .section-title {
        width: 100px;
        font-weight: bold;
        color: #666;
    }
    .form-margin {
        margin-right: 15px;
    }
    .input-student-id {
        width: 230px;
        background: #fff;
        border: 1px solid #ccc;
        border-radius: 4px;
        padding: 4px 8px;
        box-sizing: border-box;
    }
</style>
</head>
<body>

<%
// 1. Actionから送られてきた検索状態（選択された条件）を取得
String entYear = (String) request.getAttribute("selectedYear");
String classNum = (String) request.getAttribute("selectedClass");
String subjectCd = (String) request.getAttribute("selectedSubjectCd");
String studentId = (String) request.getAttribute("selectedStudentId");

if (entYear == null) entYear = "";
if (classNum == null) classNum = "";
if (subjectCd == null) subjectCd = "";
if (studentId == null) studentId = "";

// 2. 表示用の科目名と成績リストを取得
String selectedSubjectName = (String) request.getAttribute("selectedSubjectName");
List<Map<String, Object>> scoreDisplayList = (List<Map<String, Object>>) request.getAttribute("scoreDisplayList");
%>

<!-- 上部：水色のシステムヘッダー -->
<header class="system-header">
    <div class="header-title">得点管理システム</div>
    <div class="header-user">
        <span>${sessionScope.teacher_name}様</span>
        <a href="#" class="logout-btn">ログアウト</a>
    </div>
</header>

<div class="main-layout">

    <!-- 左側：メニューエリア -->
    <div class="left-menu-area">
        <jsp:include page="/tag.jsp" />
    </div>

    <!-- 右側：メインコンテンツエリア -->
    <div class="content-body">
        <div class="right-container">
            
            <div class="search-title">成績一覧（科目）</div>

            <!-- 検索フォームエリア（送信先は ScoreSubjectAction） -->
            <!-- 1つの大きなformタグで囲むことで、どちらの検索ボタンを押してもすべての条件が同時に送信されます -->
            <form action="${pageContext.request.contextPath}/ScoreSubjectAction.action" method="get" class="search-form">
                
                <!-- 【 1段目：科目情報エリア 】 -->
                <div class="search-section search-section-border">
                    <div class="section-title">科目情報</div>
                    
                    <!-- 入学年度（DBから取得したリストで動的生成） -->
                    <div class="form-group form-margin">
                        <label class="form-label">入学年度</label>
                        <select name="entYear" class="form-select">
                            <option value="" <%= entYear.equals("") ? "selected" : "" %>>--------</option>
                            <%
                            List<String> entYearList = (List<String>) request.getAttribute("entYearList");
                            if (entYearList != null) {
                                for (String year : entYearList) {
                            %>
                                <option value="<%= year %>" <%= entYear.equals(year) ? "selected" : "" %>>
                                    <%= year %>
                                </option>
                            <%
                                }
                            }
                            %>
                        </select>
                    </div>

                    <!-- クラス（DBから取得したリストで動的生成） -->
                    <div class="form-group form-margin">
                        <label class="form-label">クラス</label>
                        <select name="classNum" class="form-select">
                            <option value="" <%= classNum.equals("") ? "selected" : "" %>>--------</option>
                            <%
                            List<String> classNumList = (List<String>) request.getAttribute("classNumList");
                            if (classNumList != null) {
                                for (String clazz : classNumList) {
                            %>
                                <option value="<%= clazz %>" <%= classNum.equals(clazz) ? "selected" : "" %>>
                                    <%= clazz %>
                                </option>
                            <%
                                }
                            }
                            %>
                        </select>
                    </div>

                    <!-- 科目（DBから取得したリストで動的生成） -->
                    <div class="form-group form-group-wide form-margin">
                        <label class="form-label">科目</label>
                        <select name="subjectCd" class="form-select" style="width: 250px;">
                            <option value="" <%= subjectCd.equals("") ? "selected" : "" %>>--------</option>
                            <%
                            List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjects");
                            if (subjectList != null) {
                                for (Map<String, String> sub : subjectList) {
                            %>
                                <option value="<%= sub.get("cd") %>" <%= subjectCd.equals(sub.get("cd")) ? "selected" : "" %>>
                                    <%= sub.get("name") %>
                                </option>
                            <%
                                }
                            }
                            %>
                        </select>
                    </div>

                    <button type="submit" class="search-btn">検索</button>
                </div>

                <!-- 【 2段目：学生情報エリア 】 -->
                <div class="search-section">
                    <div class="section-title">学生情報</div>
                    
                    <!-- 学生番号入力欄 -->
                    <div class="form-group">
                        <label class="form-label">学生番号</label>
                        <input type="text" name="studentId" value="<%= studentId %>" placeholder="学生番号を入力してください" class="input-student-id">
                    </div>
                    
                    <button type="submit" class="search-btn" style="margin-left: 20px;">検索</button>
                </div>

            </form>

            <!-- ① 科目情報の表示ヘッダー -->
            <% if (selectedSubjectName != null && !selectedSubjectName.isEmpty()) { %>
                <div class="subject-info-header">
                    科目：<%= selectedSubjectName %>
                </div>
            <% } %>

            <!-- ② 成績一覧の表示テーブル -->
            <% if (scoreDisplayList != null && !scoreDisplayList.isEmpty()) { %>
                
                <table class="score-edit-table">
                    <tr>
                        <th>入学年度</th>
                        <th>クラス</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>1回</th>
                        <th>2回</th>
                    </tr>
                    <% 
                    for (Map<String, Object> row : scoreDisplayList) { 
                    %>
                    <tr>
                        <td><%= row.get("entYear") %></td> <!-- ③ / ⑨ -->
                        <td><%= row.get("classNum") %></td> <!-- ④ / ⑩ -->
                        <td><%= row.get("studentId") %></td> <!-- ⑤ / ⑪ -->
                        <td style="text-align: left; padding-left: 20px;"><%= row.get("studentName") %></td> <!-- ⑥ / ⑫ -->
                        <td><%= row.get("score1") %></td> <!-- ⑦ / ⑬ -->
                        <td><%= row.get("score2") %></td> <!-- ⑧ / ⑭ -->
                    </tr>
                    <% } %>
                </table>

                        <% 
            } else if (scoreDisplayList != null && scoreDisplayList.isEmpty()) { 
            %>
                <div style="text-align: center; color: #999; margin-top: 20px;">
                    該当する成績データが見つかりませんでした。
                </div>
            <% 
            } else { 
                // 🌟 まだ検索していない初回アクセス時
            %>
                <!-- 先ほど追加したCSSのクラス（initial-message）をここで指定します -->
                <div class="initial-message">
                    科目情報を選択または学生情報を入力して検索ボタンをクリックしてください
                </div>
            <% } %>
            
            
        </div>
    </div>

</div>

</body>
</html>
