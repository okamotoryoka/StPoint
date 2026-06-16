<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
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

// null の場合は空文字に変換して比較しやすくする
if (entYear == null) entYear = "";
if (classNum == null) classNum = "";
if (subjectCd == null) subjectCd = "";
if (noStr == null) noStr = "";
%>

<header class="system-header">
    <div class="header-title">得点管理システム</div>
    <div class="header-user">
        <span>${sessionScope.teacher_name}様</span>
        <a href="#" class="logout-btn">ログアウト</a>
    </div>
</header>

<div class="main-layout">

    <div class="left-menu-area">
        <jsp:include page="/tag.jsp" />
    </div>

    <div class="content-body">
        <div class="right-container">
            
            <div class="search-title">成績管理</div>
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
                <div class="subject-info-header">
                    科目：<%= firstData.getSubjectName() %> （<%= firstData.getNo() %>回）
                </div>

                <form action="${pageContext.request.contextPath}/ScoreRegistAction.action" method="post">
                    <table class="score-edit-table">
                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>点数</th>
                        </tr>
                        <% 
                        // すでに画面に表示した学生番号を記憶するセットを用意
                        Set<String> displayedStudents = new HashSet<>();
                        
                        for(Bean.Score data : list) { 
                            // すでに同じ学生番号が表示済みの場合は、この行のループをスキップ
                            if (displayedStudents.contains(data.getStudentId())) {
                                continue;
                            }
                            // 新しい学生番号ならセットに記憶
                            displayedStudents.add(data.getStudentId());
                        %>
                        <tr>
                            <td><%= entYear.equals("") ? data.getEntYear() : entYear %></td>
                            <td><%= data.getClassNum() %></td>
                            <td><%= data.getStudentId() %></td>
                            <td class="student-name-td"><%= data.getStudentName() %></td>
                            <td>
                                <!-- 点数入力欄 -->
                                <input type="number" name="point_<%= data.getStudentId() %>" value="<%= data.getPoint() %>" min="0" max="100">
                                
                                <!-- 💡 3つのキー情報をハイフンで連結して1本のパラメータとして送信。これで配列の順番のズレを完璧に防ぎます -->
                                <input type="hidden" name="studentIds" value="<%= data.getStudentId() %>-<%= data.getSubjectCd() %>-<%= data.getNo() %>">
                            </td>
                        </tr>
                        <% } %>
                    </table>
                    <div class="btn-area">
                        <button type="submit" class="regist-end-btn">登録して終了</button>
                    </div>
                </form>
            <% } } %>
        </div>
    </div>
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
