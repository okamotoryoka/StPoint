<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点一覧</title>
<style>
body {
    background-color: #f7f3e9;
    font-family: "Hiragino Maru Gothic ProN", "Yu Gothic", sans-serif;
    margin: 0;
}
/* 画面全体を左と右に正しく切り分ける外枠（上下の余白を統一） */
.main-layout {
    display: flex;
    min-height: 80vh;
    width: 100%;
    box-sizing: border-box;
    padding: 40px; 
    gap: 30px;     
}

/* 左側のメニューエリア（右側のボックスと高さやデザインを統一） */
.left-menu-area {
    width: 220px !important;
    min-width: 220px !important;
    max-width: 220px !important;
    background: #fff;
    border-radius: 20px;
    border: 4px solid #d8c7a1;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

/* footer.jsp内にある余計な枠や影、はみ出す横幅を強制リセット */
.left-menu-area *,
.left-menu-area div,
.left-menu-area aside {
    width: 100% !important;
    max-width: 220px !important;
    margin: 0 !important;
    background: transparent !important;
    box-shadow: none !important;
    border: none !important;
    box-sizing: border-box !important;
}

/* 
  【最重要】リセットされて小さくなってしまったメニュー内の文字のバランスを
  右側のテーブル（18px）に等しく合わせるためのスタイル指定
*/
.left-menu-area ul {
    list-style: none !important;
    padding: 30px 15px 30px 25px !important; /* メニュー内の内側余白をゆったり配置 */
}
.left-menu-area li {
    font-size: 18px !important;       /* 文字の大きさを右側のテーブルと同じ18pxに拡大 */
    line-height: 2.2 !important;      /* 行間をさらにゆったり広げて窮屈さを解消 */
    margin-bottom: 8px !important;    /* 項目ごとの隙間を確保 */
}
/* 大項目の「成績管理」などの見出しを目立たせる設定 */
.left-menu-area li.menu-title,
.left-menu-area li:has(+ li[style*="padding-left"]) {
    font-weight: bold !important;
    color: #6b4f2d !important;        /* テーブルのテーマカラーに合わせた茶色に変更 */
    margin-top: 10px !important;
}

/* 右側のコンテンツエリア：偏りをなくし、左メニューと高さを揃えます */
.content-body {
    flex: 1;
    padding: 0; 
    box-sizing: border-box;
    display: flex;
}
.right-container {
    width: 100%;
    max-width: 1000px; 
    background: #fff;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    border: 4px solid #d8c7a1;
    box-sizing: border-box;
}
.title {
    text-align: center;
    font-size: 32px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #6b4f2d;
}
.add-link {
    display: inline-block;
    margin-bottom: 20px;
    font-size: 18px;
    color: #6b4f2d;
    text-decoration: none;
    border-bottom: 2px solid #6b4f2d;
}
.score-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}
.score-table th, .score-table td {
    border: 3px solid #d8c7a1;
    padding: 12px 10px;
    text-align: center;
    font-size: 18px;
    white-space: nowrap;
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

<div class="main-layout">

    <!-- 左メニュー：文字サイズを大きくし、窮屈感を解消しました -->
    <div class="left-menu-area">
        <jsp:include page="/footer.jsp" />
    </div>

    <!-- 右側メインコンテンツエリア -->
    <div class="content-body">
        <div class="right-container">
            <div class="title">得点一覧</div>

            <a class="add-link" href="${pageContext.request.contextPath}/management/score_insert.jsp">
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
                ArrayList<Map<String, Object>> list = (ArrayList<Map<String, Object>>) request.getAttribute("list");
                if(list != null) {
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
                        <a href="${pageContext.request.contextPath}/ScoreUpdateServlet.action?student_id=<%= data.get("student_id") %>&subject_cd=<%= data.get("subject_cd") %>&school_cd=<%= data.get("school_cd") %>&no=<%= data.get("no") %>">
                            更新
                        </a>
                    </td>

                    <td>
                        <a href="${pageContext.request.contextPath}/management/score_delete.jsp?student_id=<%= data.get("student_id") %>&subject_cd=<%= data.get("subject_cd") %>&school_cd=<%= data.get("school_cd") %>&no=<%= data.get("no") %>">
                            削除
                        </a>
                    </td>
                </tr>
                <% 
                    } 
                } 
                %>
            </table>
            
        </div>
    </div>

</div>

</body>
</html>
