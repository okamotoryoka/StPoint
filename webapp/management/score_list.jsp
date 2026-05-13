<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点一覧</title>

<style>
/* 全体の背景 */
body {
    background-color: #f7f3e9; /* 淡いベージュ */
    font-family: "Hiragino Maru Gothic ProN", "Yu Gothic", sans-serif;
}

/* 外枠 */
.container {
    width: 90%;
    max-width: 900px;
    margin: 40px auto;
    background: #fff;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    border: 4px solid #d8c7a1;
}

/* タイトル */
.title {
    text-align: center;
    font-size: 32px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #6b4f2d;
}

/* 新規登録リンク */
.add-link {
    display: inline-block;
    margin-bottom: 20px;
    font-size: 18px;
    color: #6b4f2d;
    text-decoration: none;
    border-bottom: 2px solid #6b4f2d;
}

/* 表 */
.score-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

.score-table th, .score-table td {
    border: 3px solid #d8c7a1;
    padding: 10px;
    text-align: center;
    font-size: 18px;
}

.score-table th {
    background-color: #f0e6d2;
    font-weight: bold;
    color: #6b4f2d;
}

.score-table tr:nth-child(even) {
    background-color: #faf7f0;
}
</style>

</head>

<body>

<div class="container">

    <div class="title">得点一覧</div>

    <a class="add-link" href="<%=request.getContextPath()%>/management/score_insert.jsp">
        ＋ 新規登録
    </a>

    <table class="score-table">

        <tr>
            <th>学生番号</th>
            <th>氏名</th>
            <th>科目</th>
            <th>回数</th>
            <th>得点</th>
            <th>クラス</th>
            <th>更新</th>
            <th>削除</th>
        </tr>

        <%
        ArrayList<Map<String, Object>> list =
            (ArrayList<Map<String, Object>>) request.getAttribute("list");

        for(Map<String, Object> data : list){
        %>

        <tr>
            <td><%= data.get("student_id") %></td>
            <td><%= data.get("student_name") %></td>
            <td><%= data.get("subject_name") %></td>
            <td><%= data.get("no") %></td>
            <td><%= data.get("point") %></td>
            <td><%= data.get("class_num") %></td>

            <td>
                <a href="<%=request.getContextPath()%>/score/update?student_id=<%= data.get("student_id") %>&subject_cd=<%= data.get("subject_cd") %>&school_cd=<%= data.get("school_cd") %>&no=<%= data.get("no") %>">
                    更新
                </a>
            </td>

            <td>
                <a href="<%=request.getContextPath()%>/management/score_delete.jsp?student_id=<%= data.get("student_id") %>&subject_cd=<%= data.get("subject_cd") %>&school_cd=<%= data.get("school_cd") %>&no=<%= data.get("no") %>">
                    削除
                </a>
            </td>
        </tr>

        <% } %>

    </table>

</div>

</body>
</html>
