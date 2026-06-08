<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目更新</title>
</head>
<body>

    <h2>科目情報の更新</h2>

    <!-- FrontControllerを通り、SubjectUpdateExecuteActionへ送信 -->
    <form action="SubjectUpdateExecute.action" method="post">
        
        <table>
            <tr>
                <th>科目コード</th>
                <td>
                    <!-- 画面上は見せるが、ユーザーに変更させない（readonly） -->
                    <input type="text" value="${subject.cd}" disabled style="background-color: #f0f0f0; color: #666; border: 1px solid #ccc;">

                    <!-- disabledにすると値が送信されなくなるため、裏側で値を送るhiddenタグをセットで用意します -->
                    <input type="hidden" name="cd" value="${subject.cd}">
                </td>
            </tr>
            <tr>
                <th>科目名</th>
                <td>
                    <!-- 変更可能な入力欄（初期値に現在の科目名をEL式で表示） -->
                    <input type="text" name="name" value="${subject.name}" required>
                </td>
            </tr>
        </table>

        <br>
        <button type="submit">変更を保存</button>
        <a href="${pageContext.request.contextPath}/SubjectList.action">戻る</a>

    </form>

</body>
</html>