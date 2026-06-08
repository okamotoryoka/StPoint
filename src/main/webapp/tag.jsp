<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー</title> <!-- headタグ内には本来タイトルを入れます -->
</head>

<body> <!-- 画面の表示内容は本来bodyタグの中に書きます -->

<!-- 全体 -->
<div class="container">

    <!-- 左メニュー：横幅を220pxに広げて固定し、右側にゆとりを持たせました -->
    <aside class="sidebar" style="width: 220px; min-width: 220px; padding: 20px 10px 20px 20px; box-sizing: border-box;">

        <!-- すべての文字の左端を綺麗に揃えるため、内側の余白を0にリセットしています -->
        <ul style="list-style: none; padding-left: 0; margin: 0; line-height: 2.0; width: 100%;">
            <!-- トップ画面（自分自身）へのリンク -->
            <li style="margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/menu.jsp">メニュー</a></li>

            <!-- 学生管理 -->
            <li class="menu-title" style="margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/StudentList.action">学生管理</a></li>

            <!-- 成績管理（大項目はリンクなし、見出しとして表示） -->
            <li class="menu-title" style="margin-bottom: 8px; color: #333; font-weight: bold;">成績管理</li>
            
            <!-- 左メニューの成績リンク群（内側にきれいに20px字下げ） -->
            <li style="padding-left: 20px; margin-bottom: 8px;"><a href="${pageContext.request.contextPath}/ScoreInsertServlet.action">成績登録</a></li>
            <li style="padding-left: 20px; margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/ScoreListServlet.action">成績参照</a></li>

            <!-- 科目管理（二重になっていたダブルクォーテーションを修正しました） -->
            <li class="menu-title" style="margin-bottom: 16px;"><a href="${pageContext.request.contextPath}/SubjectList.action">科目管理</a></li>
        </ul>

    </aside>

</div>

</body>
</html>
