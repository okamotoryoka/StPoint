<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>科目情報削除</title>
    <style>
        /* 画像の①：見出しの帯 */
        .page-header {
            background-color: #f1f3f5;
            padding: 15px;
            border-left: 5px solid #dee2e6;
            margin-bottom: 20px;
        }
        /* 画像の③：赤い削除ボタン */
        .btn-delete {
            background-color: #d32f2f;
            color: white;
            border: none;
            padding: 8px 20px;
            cursor: pointer;
            font-weight: bold;
            border-radius: 4px;
        }
        /* 画像の④：戻るリンク */
        .link-back {
            color: #3182ce;
            text-decoration: none;
            margin-left: 15px;
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

        <p>「${subject.name}(${subject.cd})」を削除してもよろしいですか？</p>

        <form action="SubjectDeleteExecute.action" method="post">
            <input type="hidden" name="cd" value="${subject.cd}">
            <button type="submit" class="btn-delete">削除</button>
            
            <a href="SubjectList.action" class="link-back">戻る</a>
        </form>
    </main>
</div>

<%@ include file="../footer.jsp" %>
</body>
</html>