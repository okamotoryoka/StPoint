<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点登録</title>
<style>
/* =========================================================
   全体のリセットと背景設定
   ========================================================= */
* { margin: 0; padding: 0; box-sizing: border-box; }

body { 
    min-height: 100vh; 
    display: flex; 
    flex-direction: column;
    font-family: "Meiryo", "Hiragino Kaku Gothic ProN", sans-serif !important; 
    background: #fdfdfd;
    position: relative;
    padding-bottom: 60px; /* フッター帯の高さ分の余白 */
}

/* メインコンテンツエリアの余白 */
.content-body {
    flex: 1;
    padding: 20px;
}

/* =========================================================
   タイトル領域（他の管理画面と共通の鼠色の枠）
   ========================================================= */
.title-box {
    background-color: #f5f5f5; 
    padding: 12px 20px; 
    margin-bottom: 25px;
    border-bottom: 1px solid #dfdfdf;
}

.title-box h2 {
    margin: 0; 
    font-size: 20px; 
    font-weight: bold;
    color: #000000;
}

/* =========================================================
   入力テーブルのデザイン
   ========================================================= */
.form-table {
    width: 100%;
    max-width: 600px; /* 横幅が広がりすぎないように制限 */
    border-collapse: collapse; /* 二重線を消して1本線にする */
    margin-bottom: 20px;
}

/* 左側の見出しセル */
.form-table th {
    background-color: #f8fafc;
    color: #333333;
    font-weight: bold;
    font-size: 14px;
    padding: 12px 15px;
    text-align: left;
    width: 30%;
    border: 1px solid #cbd5e1;
}

/* 右側の入力欄が入るセル */
.form-table td {
    padding: 10px 15px;
    border: 1px solid #cbd5e1;
    background-color: #ffffff;
}

/* 入力テキストボックス本体の調整 */
.form-table input[type="text"],
.form-table input[type="number"],
.form-table select {
    width: 100%;
    padding: 8px 10px;
    font-size: 14px;
    border: 1px solid #cbd5e1;
    border-radius: 4px;
    outline: none;
    background-color: #ffffff;
}

/* 入力欄をクリックした時の枠線変化 */
.form-table input:focus,
.form-table select:focus {
    border-color: #007bff;
}

/* =========================================================
   登録ボタン（ログイン画面等と合わせた鮮やかな青色）
   ========================================================= */
.btn-submit {
    display: inline-block;
    padding: 10px 30px;
    font-size: 15px;
    font-weight: bold;
    color: #ffffff;
    background-color: #007bff; /* 鮮やかな青 */
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.2s;
}

.btn-submit:hover {
    background-color: #0056b3;
}

/* =========================================================
   一番下のグレーのフッター帯
   ========================================================= */
.login-footer {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    background-color: #ebebeb;
    padding: 12px 0;
    text-align: center;
    line-height: 1.6;
    font-size: 12px;
    color: #7a7a7a;
    border-top: 1px solid #dfdfdf;
    z-index: 10;
}
</style>
</head>

<body>

<div class="content-body">

    <%-- タイトル領域を鼠色の枠の中に配置 --%>
    <div class="title-box">
        <h2>得点登録</h2>
    </div>

    <%-- メッセージ（科目名が存在しないなど）があれば出力 --%>
    <% if (request.getAttribute("message") != null) { %>
        <div style="color: #ff0000; font-weight: bold; margin-bottom: 15px;"><%= request.getAttribute("message") %></div>
    <% } %>

    <%-- URLパスに /score/ を追加し、ブラウザの自動入力をオフに設定 --%>
    <form action="<%=request.getContextPath()%>/ScoreInsertServlet.action" method="post" autocomplete="off">

        <%-- border="1"をクラス名に変更して細い1本線に調整 --%>
        <table class="form-table">

            <tr>
                <th>学生番号</th>
                <td>
                    <input type="text" name="student_id" required>
                </td>
            </tr>

            <tr>
                <th>名前</th>
                <td>
                    <input type="text" name="student_name" required>
                </td>
            </tr>

            <!-- ★追加: 学年の登録用プルダウン項目 -->
            <tr>
                <th>学年</th>
                <td>
                    <select name="grade" required>
                        <option value="">-- 学年を選択してください --</option>
                        <% 
                            List<String> gradeList = (List<String>) request.getAttribute("gradeList");
                            if (gradeList != null && !gradeList.isEmpty()) {
                                for (String g : gradeList) { 
                        %>
                                    <option value="<%= g %>"><%= g %>年</option>
                        <% 
                                } 
                            } else {
                                // 万が一DBが空の場合の初期デフォルト用（1〜3年）
                                for (int i = 1; i <= 3; i++) { 
                        %>
                                    <option value="<%= i %>"><%= i %>年</option>
                        <% 
                                } 
                            } 
                        %>
                    </select>
                </td>
            </tr>

            <tr>
                <th>科目名</th>
                <td>
                    <input type="text" name="subject_name" required>
                </td>
            </tr>

            <tr>
                <th>学校コード</th>
                <td>
                    <input type="text" name="school_cd" required>
                </td>
            </tr>

            <tr>
                <th>テスト回数</th>
                <td>
                    <input type="number" name="no" required>
                </td>
            </tr>

            <tr>
                <th>得点</th>
                <td>
                    <%-- type="number" に修正 --%>
                    <input type="number" name="point" required>
                </td>
            </tr>

            <tr>
                <th>クラス番号</th>
                <td>
                    <input type="text" name="class_num" required>
                </td>
            </tr>

        </table>

        <button type="submit" class="btn-submit">
            登録
        </button>

    </form>

</div>

<%-- 横いっぱいに広がるグレーのフッター帯 --%>
<div class="login-footer">
    &copy; 2023 TIC<br>
    大原学園
</div>

</body>
</html>
