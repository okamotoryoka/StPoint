<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
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

            <!-- ② 変更完了通知バー -->
            <div class="alert-success-box">
                変更が完了しました
            </div>
            
            <!-- ③ 左寄せ ＋ 下方向に調整されたリンクエリア -->
            <div class="done-link-area">
                <!-- 「学生一覧」の遷移先アクションに書き換えています -->
                <a href="${pageContext.request.contextPath}/StudentList.action" class="done-link">学生一覧</a>
            </div>

        </main>

    </div>

</body>
</html>
