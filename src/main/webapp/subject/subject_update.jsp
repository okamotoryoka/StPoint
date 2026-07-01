<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>科目更新</title>
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

        /* ②④ フォームのラベル項目 */
        .form-label {
            font-size: 14px;
            color: #333;
            margin-bottom: 8px;
        }

        /* ③ 科目コードの表示（入力不可） */
        .readonly-text {
            font-size: 16px;
            color: #333;
            padding-left: 20px;
            margin-bottom: 20px;
        }

        /* ⑤ 科目名の入力欄 */
        .input-text {
            width: 100%;
            max-width: 600px;
            padding: 8px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 25px;
        }

        /* ⑥ 変更ボタン */
        .submit-btn {
            background-color: #0066cc;
            color: #ffffff;
            border: none;
            padding: 8px 20px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            margin-bottom: 15px;
        }
        .submit-btn:hover {
            background-color: #0052a3;
        }

        /* ⑦ 戻るリンク */
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
            
            <!-- ① ページ見出し -->
            <h2 class="page-title">科目情報変更</h2>

            <!-- FrontControllerを通り、SubjectUpdateExecuteActionへ送信 -->
            <form action="SubjectUpdateExecute.action" method="post">
                
                <!-- 裏側で値を送るhiddenタグ（画面には見えない） -->
                <input type="hidden" name="cd" value="${subject.cd}">

                <!-- ② 科目コードの見出し -->
                <div class="form-label">科目コード</div>
                <!-- ③ 科目コードの値表示 -->
                <div class="readonly-text">${subject.cd}</div>

                <!-- ④ 科目名の見出し -->
                <div class="form-label">科目名</div>
                <!-- ⑤ 科目名の入力欄 -->
                <div>
                    <input type="text" name="name" value="${subject.name}" class="input-text" required>
                </div>

                <!-- ⑥ 変更ボタン -->
                <button type="submit" class="submit-btn">変更</button>
                
                <!-- ⑦ 戻るリンク -->
                <a href="${pageContext.request.contextPath}/SubjectList.action" class="back-link">戻る</a>

            </form>

        </main>

    </div>

</body>
</html>
