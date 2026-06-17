<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Bean.Student" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生情報変更</title>
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
            min-height: calc(100vh - 80px); /* 太くなったヘッダー(80px)に合わせて固定 */
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

        /* ① 学生情報変更の見出し */
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

        /* ②④⑥⑧⑩ フォームの項目名ラベル */
        .form-label {
            font-size: 14px;
            color: #333;
            margin-bottom: 8px;
        }

        /* ③⑤ 入学年度・学生番号の値表示 */
        .readonly-text {
            font-size: 16px;
            color: #333;
            padding-left: 20px;
            margin-bottom: 20px;
        }

        /* ⑦ 氏名の入力欄 */
        .input-text {
            width: 100%;
            max-width: 600px;
            padding: 8px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 20px;
        }

        /* ⑨ クラスのセレクトボックス */
        .input-select {
            width: 100%;
            max-width: 600px;
            padding: 8px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 20px;
            background-color: #ffffff;
        }

        /* ⑪ 在学中のチェックボックスエリア */
        .checkbox-area {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #333;
            margin-bottom: 25px;
        }
        .checkbox-area input[type="checkbox"] {
            margin-right: 5px;
        }

        /* ⑫ 変更ボタン */
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

        /* ⑬ 戻るリンク */
        .back-link {
            color: #0066cc;
            text-decoration: underline;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <%
        Student student = (Student) request.getAttribute("student");
        List<String> classList = (List<String>) request.getAttribute("class_list");
        
        // 値の初期化（null安全）
        String no = (student != null) ? student.getNo() : "";
        String name = (student != null) ? student.getName() : "";
        int entYear = (student != null) ? student.getEntYear() : 0;
        boolean isAttend = (student != null) ? student.isAttend() : true;
        String currentClass = (student != null) ? student.getClassNum() : "";
    %>

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
            <h2 class="page-title">学生情報変更</h2>

            <!-- FrontControllerを通り、StudentUpdateExecuteActionへ送信 -->
            <form action="${pageContext.request.contextPath}/StudentUpdatExecute.action" method="post">
                
                <!-- 裏側で値を送るhiddenタグ（画面には見えない） -->
                <input type="hidden" name="no" value="<%= no %>">

                <!-- ② 入学年度の見出し -->
                <div class="form-label">入学年度</div>
                <!-- ③ 入学年度の値表示 -->
                <div class="readonly-text"><%= entYear %></div>

                <!-- ④ 学生番号の見出し -->
                <div class="form-label">学生番号</div>
                <!-- ⑤ 学生番号の値表示 -->
                <div class="readonly-text"><%= no %></div>

                <!-- ⑥ 氏名の見出し -->
                <div class="form-label">氏名</div>
                <!-- ⑦ 氏名の入力欄 -->
                <div>
                    <input type="text" name="name" value="<%= name %>" class="input-text" required>
                </div>

                <!-- ⑧ クラスの見出し -->
                <div class="form-label">クラス</div>
                <!-- ⑨ クラスの選択肢 -->
                <div>
                    <select name="classNum" class="input-select">
                        <% 
                            if (classList != null) {
                                for (String c : classList) {
                                    String selected = c.equals(currentClass) ? "selected" : "";
                        %>
                                    <option value="<%= c %>" <%= selected %>><%= c %></option>
                        <% 
                                }
                            } 
                        %>
                    </select>
                </div>

                <!-- ⑩⑪ 在学中の見出しとチェックボックス -->
                <div class="checkbox-area">
                    <input type="checkbox" name="isAttend" value="true" <%= isAttend ? "checked" : "" %>>
                    <span>在学中</span>
                </div>

                <!-- ⑫ 変更ボタン -->
                <button type="submit" class="submit-btn">変更</button>
                
                <!-- ⑬ 戻るリンク -->
                <a href="${pageContext.request.contextPath}/StudentList.action" class="back-link">戻る</a>

            </form>

        </main>

    </div>

</body>
</html>
