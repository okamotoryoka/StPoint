<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>得点管理システム</title>
    <!-- ★外部CSSファイルの読み込みをしっかりと維持します -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    
    <style>
        /* 
           外部CSSに影響させず、画面遷移時のサイドバーの位置・高さを
           1ピクセルもズレなく完全に固定させるためのJSP固有の骨組み設定です。
        */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: sans-serif; background-color: #ffffff; }

        /* 全体の2カラムレイアウト（太くなった80pxのヘッダーに適合） */
        .system-layout { 
            display: flex; 
            width: 100%; 
            min-height: calc(100vh - 80px); 
        }

        /* 左側メニュー枠：これまでの画面と全く同じ幅220pxに固定します */
        .side-menu { 
            width: 220px; 
            min-width: 220px; 
            flex-shrink: 0; 
            border-right: 1px solid #e0e0e0;
            background-color: #ffffff;
        }

        /* 右側メインエリア：内側の余白を30pxに統一 */
        .main-content { 
            flex: 1; 
            padding: 30px; 
            box-sizing: border-box;
        }

        /* 各画面共通のグレーの見出し帯 */
        .page-title { 
            background-color: #f0f0f0; 
            padding: 12px 25px; 
            margin-top: 0;
            margin-bottom: 25px; 
            width: 100%;
            max-width: 950px; 
            box-sizing: border-box;
        }
        .page-title h2 {
            margin: 0;
            font-size: 26px;
            font-weight: bold;
            color: #333;
        }
    </style>
</head>
<body>

<%
// 1. サーブレットから送られてきた選択状態（検索条件）を取得
String entYear = (String) request.getAttribute("entYear");
String classNum = (String) request.getAttribute("classNum");
String subjectCd = (String) request.getAttribute("subjectCd");
String noStr = (String) request.getAttribute("no");

List<String> entYearList = (List<String>) request.getAttribute("entYearList");
List<String> classList = (List<String>) request.getAttribute("classList");

// 2. 初回アクセスかどうかのフラグを受け取る
Boolean isFirstAccess = (Boolean) request.getAttribute("isFirstAccess");

if (entYear == null) entYear = "";
if (classNum == null) classNum = "";
if (subjectCd == null) subjectCd = "";
if (noStr == null) noStr = "";
%>

<!-- ★共通ヘッダー（header.jsp）を一括読み込み（直書きのヘッダーは削除） -->
<jsp:include page="../header.jsp" />

<!-- 全体の2カラムレイアウト -->
<div class="system-layout">

    <!-- 左側：共通メニュー（tag.jsp）を一括読み込み -->
    <div class="side-menu">
        <jsp:include page="/tag.jsp" />
    </div>

    <!-- 右側：メインコンテンツエリア（style.cssのcontent-bodyと合体させます） -->
    <main class="main-content content-body">
        
        <!-- グレーの見出し帯（学生登録画面などと大きさを完全一致） -->
        <div class="page-title">
            <h2>成績管理</h2>
        </div>

        <!-- 検索フォームエリア（style.cssのスタイルが自動適用されます） -->
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
                    <%
                    List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjectList");
                    if (subjectList != null) { for (Map<String, String> sub : subjectList) {
                    %>
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
            <!-- 点数入力エリア（style.cssのスタイルが自動適用されます） -->
            <div class="subject-info-header">
                科目：<%= firstData.getSubjectName() %> （<%= firstData.getNo() %>回）
            </div>

            <form action="${pageContext.request.contextPath}/ScoreRegist.action" method="post">
                <table class="score-edit-table">
                    <thead>
                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>点数</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        Set<String> displayedStudents = new HashSet<>();
                        for(Bean.Score data : list) { 
                            if (displayedStudents.contains(data.getStudentId())) {
                                continue;
                            }
                            displayedStudents.add(data.getStudentId());
                        %>
                        <tr>
                            <td><%= entYear.equals("") ? data.getEntYear() : entYear %></td>
                            <td><%= data.getClassNum() %></td>
                            <td><%= data.getStudentId() %></td>
                            <td class="student-name-td"><%= data.getStudentName() %></td>
                            <td>
                                <input type="number" name="point_<%= data.getStudentId() %>" value="<%= data.getPoint() %>" min="0" max="100">
                                <input type="hidden" name="studentIds" value="<%= data.getStudentId() %>-<%= data.getSubjectCd() %>-<%= data.getNo() %>">
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="btn-area">
                    <button type="submit" class="regist-end-btn">登録して終了</button>
                </div>
            </form>
        <% } } %>
    </main>

</div>

<script>
document.addEventListener("wheel", function() {
    if (document.activeElement.type === "number") {
        document.activeElement.blur();
    }
});
</script>
</body>
</html>
