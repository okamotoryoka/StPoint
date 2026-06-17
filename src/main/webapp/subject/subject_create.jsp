<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>科目登録</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        /* 左右レイアウト用スタイル */
        
        .system-layout { display: flex; width: 100%; min-height: 80vh; }
        .side-menu-container { width: 200px; background-color: #f8f9fa; border-right: 1px solid #e2e8f0; }
        .content-body { flex: 1; padding: 24px; }
        
        /* フォームの見た目調整 */
        table { width: 100%; max-width: 500px; border-collapse: collapse; margin-bottom: 20px; }
        th { text-align: left; padding: 12px; width: 120px; color: #4a5568; }
        td { padding: 8px; }
        input[type="text"] { width: 100%; padding: 8px; border: 1px solid #cbd5e0; border-radius: 4px; }
        button { padding: 8px 16px; background-color: #4a5568; color: white; border: none; border-radius: 4px; cursor: pointer; }
    </style>
</head>
<body>

<%-- ヘッダーの読み込み --%>
<%@ include file="../header.jsp" %>

<div class="system-layout">
    <%-- 左側メニュー --%>
    <div class="side-menu-container">
        <jsp:include page="../tag.jsp" />
    </div>

    <%-- 右側メインコンテンツ --%>
    <main class="content-body">
        <h2>科目情報の登録</h2>

        <p style="color: #cd3d3d; font-weight: bold; margin-bottom: 20px;">${error}</p>

        <form action="SubjectCreateExecute.action" method="post">
            <table>
                <tr>
                    <th>科目コード</th>
                    <td><input type="text" name="cd" required placeholder="例: K01"></td>
                </tr>
                <tr>
                    <th>科目名</th>
                    <td><input type="text" name="name" required placeholder="例: 基本情報技術"></td>
                </tr>
            </table>

            <button type="submit">登録を保存</button>
            <a href="SubjectList.action" style="margin-left: 15px; text-decoration: none; color: #3182ce;">戻る</a>
        </form>
    </main>
</div>

<%-- フッターの読み込み --%>
<%@ include file="../footer.jsp" %>

</body>
</html>