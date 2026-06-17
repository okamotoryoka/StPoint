<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生変更完了</title>
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
            
            <!-- ① グレーの見出し帯（前回作成した共通設定に連動） -->
            <h2 class="page-title">学生情報変更</h2>

            <!-- ② style.cssの指定色・細身文字を反映した完了通知バー -->
            <div class="alert-success-box">
                変更が完了しました
            </div>
            
            <!-- ③ 左寄せ ＋ 上部45px余白が効いたリンクエリア -->
            <div class="done-link-area">
                <!-- 既存の back-link a の装飾がそのまま適用されます -->
                <a href="StudentList.action">学生一覧</a>
            </div>

        </main>

    </div>

</body>
</html>
