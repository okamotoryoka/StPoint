<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目登録</title>
</head>
<body>

    <h2>科目情報の登録</h2>

    <!-- 重複エラーや登録失敗時のメッセージ（空のときは何も表示されません） -->
    <p style="color: red;">${error}</p>

    <!-- FrontControllerを通り、SubjectCreateExecuteActionへ送信 -->
    <form action="SubjectCreateExecute.action" method="post">
        
        <table>
            <tr>
                <th>科目コード</th>
                <td>
                    <!-- 新規追加なので、今回は入力できるように設定します -->
                    <input type="text" name="cd" required placeholder="例: K01">
                </td>
            </tr>
            <tr>
                <th>科目名</th>
                <td>
                    <input type="text" name="name" required placeholder="例: 基本情報技術">
                </td>
            </tr>
        </table>

        <br>
        <button type="submit">登録を保存</button>
        <a href="SubjectList.action">戻る</a>

    </form>

</body>
</html>
