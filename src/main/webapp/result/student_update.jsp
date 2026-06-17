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
        body { margin: 0; padding: 0; font-family: sans-serif; background-color: #ffffff; }

        /* ヘッダーの下のエリア */
        .wrapper { display: flex; width: 100%; min-height: calc(100vh - 80px); }

        /* サイドバーを固定する枠 */
        .sidebar-wrapper { width: 220px; min-width: 220px; border-right: 1px solid #e0e0e0; background-color: #ffffff; }

        /* 右側のメイン表示エリア */
        .main { flex: 1; padding: 30px; box-sizing: border-box; }

        .page-title { background-color: #f0f0f0; padding: 10px 15px; font-size: 20px; font-weight: bold; color: #333; margin-top: 0; margin-bottom: 25px; width: 100%; box-sizing: border-box; }
        .form-label { font-size: 14px; color: #333; margin-bottom: 8px; }
        .readonly-text { font-size: 16px; color: #333; padding-left: 20px; margin-bottom: 20px; }
        .input-text, .input-select { width: 100%; max-width: 600px; padding: 8px 12px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; margin-bottom: 20px; }
        .checkbox-area { display: flex; align-items: center; font-size: 14px; color: #333; margin-bottom: 25px; }
        .checkbox-area input[type="checkbox"] { margin-right: 5px; }
        .submit-btn { background-color: #0066cc; color: #ffffff; border: none; padding: 8px 20px; font-size: 14px; border-radius: 4px; cursor: pointer; display: block; margin-bottom: 15px; }
        .submit-btn:hover { background-color: #0052a3; }
        .back-link { color: #0066cc; text-decoration: underline; font-size: 14px; }
    </style>
</head>
<body>

    <%
        Student student = (Student) request.getAttribute("student");
        List<String> classList = (List<String>) request.getAttribute("class_list");
        
        String no = (student != null) ? student.getNo() : "";
        String name = (student != null) ? student.getName() : "";
        int entYear = (student != null) ? student.getEntYear() : 0;
        boolean isAttend = (student != null) ? student.isAttend() : true;
        String currentClass = (student != null) ? student.getClassNum() : "";
    %>

    <jsp:include page="../header.jsp" />

    <div class="wrapper">
        <div class="sidebar-wrapper">
            <jsp:include page="../tag.jsp" />
        </div>

        <main class="main">
            <h2 class="page-title">学生情報変更</h2>

            <form action="${pageContext.request.contextPath}/StudentUpdatExecute.action" method="post">
                <input type="hidden" name="no" value="<%= no %>">

                <div class="form-label">入学年度</div>
                <div class="readonly-text"><%= entYear %></div>

                <div class="form-label">学生番号</div>
                <div class="readonly-text"><%= no %></div>

                <div class="form-label">氏名</div>
                <div><input type="text" name="name" value="<%= name %>" class="input-text" required></div>

                <div class="form-label">クラス</div>
                <div>
                    <select name="classNum" class="input-select">
                        <% if (classList != null) {
                            for (String c : classList) {
                                String selected = c.equals(currentClass) ? "selected" : "";
                        %>
                                <option value="<%= c %>" <%= selected %>><%= c %></option>
                        <%  }
                           } %>
                    </select>
                </div>

                <div class="checkbox-area">
                    <input type="checkbox" name="isAttend" value="true" <%= isAttend ? "checked" : "" %>>
                    <span>在学中</span>
                </div>

                <button type="submit" class="submit-btn">変更</button>
                <a href="${pageContext.request.contextPath}/StudentList.action" class="back-link">戻る</a>
            </form>
        </main>
    </div>

</body>
</html>