<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目更新完了</title>
    <style>
        /* 画面全体のスタイルと位置ズレ防止 */
        body {
            margin: 0;
            padding: 0;
            font-family: sans-serif;
            background-color: #ffffff;
        }

        /* ヘッダーの下のエリア（サイドバーとメインを横並びにする） */
        .wrapper {
            display: flex;
            width: 100%;
            min-height: calc(100vh - 60px);
        }

        /* サイドバーを固定する枠 */
        .sidebar-wrapper {
            width: 220px;
            min-width: 220px;
            border-right: 1px solid #e0e0e0;
            background-color: #ffffff;
        }

        /* 右側のメイン表示エリア */
        .main {
            flex: 1;
            padding: 30px;
            box-sizing: border-box;
        }

        /* ① 科目情報変更の見出し */
        .page-title {
            background-color: #f0f0f0;
            padding: 10px 15px;
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-top: 0;
            margin-bottom: 25px;
            width: 100%;
            box-sizing: border-box;
        }

        /* ② 変更が完了しました（緑色の通知バー） */
        .success-bar {
            background-color: #83bda4; /* 画像に合わせた落ち着いた緑色 */
            color: #333333;
            text-align: center;
            padding: 10px;
            font-size: 14px;
            margin-bottom: 30px;
            width: 100%;
            box-sizing: border-box;
        }

        /* ③ 科目一覧リンク */
        .back-link {
            color: #0066cc;
            text-decoration: underline;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <!-- 共通ヘッダーの読み込み -->
    <jsp:include page="../header.jsp" />

    <!-- ヘッダーより下のメイン領域 -->
    <div class="wrapper">

        <!-- 共通サイドバーの読み込み -->
        <div class="sidebar-wrapper">
            <jsp:include page="../tag.jsp" />
        </div>

        <!-- 右側のメインコンテンツ領域 -->
        <main class="main">
            
            <!-- ① ページ見出し（画像に合わせて変更） -->
            <h2 class="page-title">科目情報変更</h2>

            <!-- ② 緑色の完了通知バー -->
            <div class="success-bar">
                変更が完了しました
            </div>
            
            <!-- ③ 科目一覧へ戻るリンク -->
            <div style="margin-top: 20px;">
                <a href="SubjectList.action" class="back-link">科目一覧</a>
            </div>

        </main>

    </div>

</body>
</html>
