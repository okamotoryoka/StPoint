<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>削除完了</title>
    <style>
        /* 見出しのグレー帯（共通） */
        .page-header {
            background-color: #f1f3f5;
            padding: 15px;
            border-left: 5px solid #dee2e6;
            margin-bottom: 20px;
        }
        /* 完了メッセージの緑色の帯 */
      
        .done-message {
            background-color: #a3c9a8; /* 背景色（緑） */
            color: black;              /* ここを black に変更 */
            padding: 15px;
            margin-bottom: 20px;
            font-weight: bold;
            text-align: center;
            border-radius: 4px;
        }
        /* リンクのスタイル */
        .link-back {
            color: #3182ce;
            text-decoration: none;
            font-size: 14px;
        }
        .link-back:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<%@ include file="../header.html" %>

<div class="system-layout" style="display: flex;">
    <jsp:include page="../tag.jsp" />

    <main style="flex: 1; padding: 20px;">
        
        <div class="page-header">
            <h2 style="margin: 0;">科目情報削除</h2>
        </div>

        <div class="done-message">
            削除が完了しました
        </div>
        
        <a href="SubjectList.action" class="link-back">科目一覧</a>

    </main>
</div>

<%@ include file="../footer.jsp" %>
</body>
</html>