<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生情報変更完了</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<style>
    /* 成功メッセージを左寄せ（検索フォームの最大幅950pxと統一） */
    .success-message {
        background-color: #c8e6c9; /* 淡い緑色 */
        padding: 15px 20px;
        text-align: left;        /* 中央寄せから左寄せに変更 */
        border: 1px solid #a5d6a7;
        margin: 20px 0 30px 0;
        border-radius: 4px;
        font-weight: bold;
        color: #2e7d32;
        max-width: 950px;         /* 検索フォームやテーブルと横幅を合わせる */
        box-sizing: border-box;
    }
    
    /* JSP内の .back-link 独自スタイルを削除、または外部CSSを活かす設定に修正 */
    .back-link {
        /* text-align: center; と display: block; を削除し、外部CSSの flex などを活かします */
    }
</style>
</head>
<body>

<header class="system-header">
    <div class="header-title">得点管理システム</div>
</header>

<div class="main-layout">
    <div class="left-menu-area">
        <jsp:include page="/tag.jsp" />
    </div>

    <div class="content-body">
        <div class="right-container">
            <div class="search-title">学生情報変更</div>

            <div class="success-message">
                変更が完了しました
            </div>

            <!-- 外部CSSの .back-link（左寄せ・横並び設定）がそのまま適用されます -->
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/StudentList.action">学生一覧へ戻る</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
