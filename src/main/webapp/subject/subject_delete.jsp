<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>科目情報削除</title>
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
            min-height: calc(100vh - 80px);
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
            display: flex;
            flex-direction: column; /* 中身を上から下に縦並びにする */
        }

        /* ① 科目情報削除の見出し */
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

        /* ② 確認テキスト */
        .confirm-text {
            font-size: 14px;
            color: #333;
            margin-left: 20px;
            margin-bottom: 20px;
        }

        /* ③ 赤い削除ボタン */
        .btn-delete {
            background-color: #e53935;
            color: white;
            border: none;
            padding: 8px 20px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            display: block;
            margin-left: 20px;
            margin-bottom: 0; /* 下の余白はform側で調整するため0に */
        }
        .btn-delete:hover {
            background-color: #c62828;
        }

        /* ④ 戻るリンク（右側エリア内で、左の「科目管理」の高さに合わせる） */
        .link-back {
            color: #0066cc;
            text-decoration: underline;
            font-size: 14px;
            display: inline-block;
            margin-left: 20px;
            
            /* ★削除ボタンの下からさらに大きく余白を空けて、高さを引き下げます */
            margin-top: 120px; 
        }
    </style>
</head>
<body>

    <!-- 共通ヘッダーの読み込み -->
    <jsp:include page="../header.jsp" />

    <!-- ヘッダーより下のメイン領域 -->
    <div class="wrapper">

        <!-- 共通サイドバーの読み込み枠 -->
        <div class="sidebar-wrapper">
            <jsp:include page="../tag.jsp" />
        </div>

        <!-- 右側のメインコンテンツ領域 -->
        <main class="main">
            
            <!-- ① ページ見出し -->
            <h2 class="page-title">科目情報削除</h2>

            <!-- ② 確認メッセージ -->
            <p class="confirm-text">「${subject.name}(${subject.cd})」を削除してもよろしいですか？</p>

            <!-- FrontControllerを通り、SubjectDeleteExecuteActionへ送信 -->
            <form action="SubjectDeleteExecute.action" method="post">
                <input type="hidden" name="cd" value="${subject.cd}">
                
                <!-- ③ 削除ボタン -->
                <button type="submit" class="btn-delete">削除</button>
            </form>
            
            <!-- ④ 戻るリンク（メインエリア内で高さを大きく下げて配置） -->
            <a href="SubjectList.action" class="link-back">戻る</a>

        </main>

    </div>

</body>
</html>
