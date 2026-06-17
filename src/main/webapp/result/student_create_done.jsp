<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生情報登録完了</title>
    <!-- すべてのスタイルは外部CSSファイルから読み込みます -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

    <!-- 共通ヘッダーの読み込み -->
    <jsp:include page="../header.jsp" />

    <!-- style.cssで定義されている2カラムコンテナ -->
    <div class="main-layout">

        <!-- 左側：メニューエリア -->
        <div class="left-menu-area">
            <jsp:include page="../tag.jsp" />
        </div>

        <!-- 右側：メインコンテンツエリア -->
        <main class="content-body">
            
            <!-- ① グレーの見出し帯 -->
            <h2 class="page-title">学生情報登録</h2>

            <!-- ② 通知バー -->
            <div class="alert-success-box">
                登録が完了しました
            </div>
            
            <!-- ③④ 2つのリンクを完全に左寄せ＆40pxの隙間で横並びにするエリア -->
            <div class="done-link-area">
                <!-- ③ 戻るリンク -->
                <a href="${pageContext.request.contextPath}/menu.jsp">戻る</a>
                
                <!-- ④ 科目一覧リンク -->
                <a href="${pageContext.request.contextPath}/StudentList.action">学生一覧</a>
            </div>

        </main>

    </div>

</body>
</html>
