<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
</head>
<body>

<%
// 1. サーブレットから送られてきた選択状態（検索条件）を取得
String entYear = (String) request.getAttribute("entYear");
String classNum = (String) request.getAttribute("classNum");
String subjectCd = (String) request.getAttribute("subjectCd");
String noStr = (String) request.getAttribute("no");

// 2. 初回アクセスかどうかのフラグを受け取る
Boolean isFirstAccess = (Boolean) request.getAttribute("isFirstAccess");

// null の場合は空文字に変換して比較しやすくする
if (entYear == null) entYear = "";
if (classNum == null) classNum = "";
if (subjectCd == null) subjectCd = "";
if (noStr == null) noStr = "";
%>

<!-- 上部：水色のシステムヘッダー -->
<header class="system-header">
    <div class="header-title">得点管理システム</div>
    <div class="header-user">
        <span>大原 太郎 様</span>
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
            
            <div class="search-title">成績管理</div>

            <!-- 検索フォームエリア（送信先は検索専用Action） -->
            <form action="${pageContext.request.contextPath}/ScoreSearchAction.action" method="post" class="search-form">
                
                <!-- 入学年度 -->
                <div class="form-group">
                    <label class="form-label">入学年度</label>
                    <select name="entYear" class="form-select">
                        <option value="" <%= entYear.equals("") ? "selected" : "" %>>--------</option>
                        <option value="2024" <%= entYear.equals("2024") ? "selected" : "" %>>2024</option>
                        <option value="2025" <%= entYear.equals("2025") ? "selected" : "" %>>2025</option>
                        <option value="2026" <%= entYear.equals("2026") ? "selected" : "" %>>2026</option>
                    </select>
                </div>

                <!-- クラス -->
                <div class="form-group">
                    <label class="form-label">クラス</label>
                    <select name="classNum" class="form-select">
                        <option value="" <%= classNum.equals("") ? "selected" : "" %>>--------</option>
                        <option value="101" <%= classNum.equals("101") ? "selected" : "" %>>101</option>
                        <option value="102" <%= classNum.equals("102") ? "selected" : "" %>>102</option>
                    </select>
                </div>

                <!-- 科目（データベースから動的に取得したリストを展開） -->
                <div class="form-group form-group-wide">
                    <label class="form-label">科目</label>
                    <select name="subjectCd" class="form-select">
                        <option value="" <%= subjectCd.equals("") ? "selected" : "" %>>--------</option>
                        <%
                        // Actionから科目リストを取得して展開
                        List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjectList");
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

                <!-- 回数 -->
                <div class="form-group">
                    <label class="form-label">回数</label>
                    <select name="no" class="form-select">
                        <option value="" <%= noStr.equals("") ? "selected" : "" %>>--------</option>
                        <option value="1" <%= noStr.equals("1") ? "selected" : "" %>>1</option>
                        <option value="2" <%= noStr.equals("2") ? "selected" : "" %>>2</option>
                    </select>
                </div>

                <button type="submit" class="search-btn">検索</button>

            </form>

            <!-- 検索結果の表示エリア（一括編集・登録フォーム） -->
            <%
            ArrayList<Bean.Score> list = (ArrayList<Bean.Score>) request.getAttribute("list");

            // 初回アクセス（検索前）ではなく、かつリストにデータが入っている場合のみ表示
            if (isFirstAccess == null || !isFirstAccess) {
                if (list != null && !list.isEmpty()) {
                    
                    // 1行目のデータから科目名と回数を取得してヘッダーに表示
                    Bean.Score firstData = list.get(0);
                    String currentSubject = firstData.getSubjectName();
                    int currentNo = firstData.getNo();
            %>
                <!-- 科目情報の表示ヘッダー -->
                <div class="subject-info-header">
                    科目：<%= currentSubject %> （<%= currentNo %>回）
                </div>

                <!-- データベースに一括登録・更新するためのフォーム -->
                <form action="${pageContext.request.contextPath}/ScoreRegistAction.action" method="post">
                    
                    <table class="score-edit-table">
                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th style="width: 250px;">点数</th>
                        </tr>
                        <% for(Bean.Score data : list) { %>
                        <tr>
                            <!-- 入学年度（検索条件が空ならデータから取得、あれば選択値を表示） -->
                            <td><%= entYear.equals("") ? data.getClassNum() : entYear %></td> 
                            <td><%= data.getClassNum() %></td>
                            <td><%= data.getStudentId() %></td>
                            <td style="text-align: left; padding-left: 20px;"><%= data.getStudentName() %></td>
                            <td>
                                <!-- 点数入力欄（複数の学生の点数を一括識別するため、nameに学生番号を付与） -->
                                <input type="number" name="point_<%= data.getStudentId() %>" value="<%= data.getPoint() %>" min="0" max="100" class="point-input">
                                
                                <!-- サーブレット側で更新処理をするための隠しパラメータ（キー情報） -->
                                <input type="hidden" name="studentIds" value="<%= data.getStudentId() %>">
                                <input type="hidden" name="subjectCd" value="<%= data.getSubjectCd() %>">
                                <input type="hidden" name="no" value="<%= data.getNo() %>">
                            </td>
                        </tr>
                        <% } %>
                    </table>

                    <!-- 登録して終了ボタン -->
                    <div class="btn-area">
                        <button type="submit" class="regist-end-btn">登録して終了</button>
                    </div>

                </form>
            <% 
                }
            } 
            %>
            
        </div>
    </div>

</div>

</body>
</html>
