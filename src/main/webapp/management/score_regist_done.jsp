<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - 登録完了</title>
    <!-- 外部CSSファイルを読み込みます -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<!-- 共通ヘッダー（header.jsp）を一括読み込み -->
<jsp:include page="../header.jsp" />

<!-- style.css の .main-layout を使用 -->
<div class="main-layout">

    <!-- style.css の .left-menu-area を使用 -->
    <div class="left-menu-area">
        <jsp:include page="/tag.jsp" />
    </div>

    <!-- style.css の .content-body を使用 -->
    <main class="main-content content-body">
        
        <!-- グレーの見出し帯（一回り大きい24px・太さ8px仕様） -->
        <div style="background-color: #f2f2f2; font-size: 24px; font-weight: bold; padding: 8px 15px; color: #333333; margin-bottom: 20px; width: 100%; box-sizing: border-box;">
            成績管理
        </div>

        <!-- 
           ★修正ポイント：
           上下の余白（padding）を 4px に、全体の高さを決める min-height を 25px まで低くしました。
           これで外部CSSの太さを強制的に上書きし、お手本通りのシャープで細い緑色の帯になります。
        -->
        <div class="alert-success-box" style="padding: 4px 20px !important; min-height: 25px !important; height: 32px !important;">
            登録が完了しました
        </div>

        <!-- リンクエリア（科目管理の下に揃える余白設定） -->
        <div class="done-link-area" style="padding-top: 115px; display: flex; gap: 120px;">
            <!-- ③ 戻るリンク -->
            <a href="${pageContext.request.contextPath}/ScoreSearch.action">戻る</a>
            
            <!-- ④ 成績参照リンク -->
            <a href="${pageContext.request.contextPath}/ScoreSubject.action">成績参照</a>
        </div>
        
    </main>

</div>

</body>
</html>
