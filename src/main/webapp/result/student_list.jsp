<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Student" %>
<%@ include file="../header.html" %>

<head>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: sans-serif; }
        .system-layout { display: flex; width: 100%; min-height: 100vh; }
        .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; }
        .main-content { flex: 1; padding: 30px; }
        .filter-box { display: flex; gap: 20px; align-items: center; padding: 20px; background-color: #f8f9fa; border: 1px solid #ddd; margin-bottom: 20px; }
        .filter-group { display: flex; align-items: center; gap: 10px; }
        .btn-submit { padding: 8px 20px; background-color: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .student-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .student-table th, .student-table td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; }
        .footer { background-color: #eee; padding: 15px; text-align: center; font-size: 12px; color: #666; margin-top: 30px; }
    </style>
</head>

<div class="system-layout">
    <div class="side-menu">
        <jsp:include page="/tag.jsp"/>
    </div>

    <main class="main-content">
        <h1>学生管理</h1>

        <form action="${pageContext.request.contextPath}/StudentList.action" method="post" class="filter-box">
            <div class="filter-group">
                <label>入学年度</label>
                <select name="entYear">
                    <option value="">--------</option>
                    <%
                        // Object型で取得してからtoString()で比較することで、型不一致エラーを防ぐ
                        List<?> yearList = (List<?>) request.getAttribute("yearList");
                        String sYear = String.valueOf(request.getAttribute("selectedYear") != null ? request.getAttribute("selectedYear") : "");
                        if (yearList != null) {
                            for (Object y : yearList) {
                                String val = String.valueOf(y);
                    %>
                                <option value="<%= val %>" <%= val.equals(sYear) ? "selected" : "" %>><%= val %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            <div class="filter-group">
                <label>クラス</label>
                <select name="classNum">
                    <option value="">--------</option>
                    <%
                        List<?> classList = (List<?>) request.getAttribute("classList");
                        String sClass = String.valueOf(request.getAttribute("selectedClass") != null ? request.getAttribute("selectedClass") : "");
                        if (classList != null) {
                            for (Object c : classList) {
                                String val = String.valueOf(c);
                    %>
                                <option value="<%= val %>" <%= val.equals(sClass) ? "selected" : "" %>><%= val %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            <div class="filter-group">
                <% Boolean isAttend = (Boolean) request.getAttribute("selectedAttend"); %>
                <input type="checkbox" name="isAttend" value="true" <%= (isAttend != null && isAttend) ? "checked" : "" %>> 在学中
            </div>
            <input type="submit" value="絞込み" class="btn-submit">
        </form>

        <table class="student-table">
            <thead>
                <tr><th>入学年度</th><th>学生番号</th><th>氏名</th><th>クラス</th><th>在学中</th><th></th></tr>
            </thead>
            <tbody>
                <%
                    List<Student> list = (List<Student>) request.getAttribute("students");
                    if (list != null && !list.isEmpty()) {
                        for (Student s : list) {
                %>
                            <tr>
                                <td><%= s.getEntYear() %></td>
                                <td><%= s.getNo() %></td>
                                <td><%= s.getName() %></td>
                                <td><%= s.getClassNum() %></td>
                                <td><%= s.isAttend() ? "〇" : "×" %></td>
                                <td></td>
                            </tr>
                <%
                        }
                    } else {
                %>
                        <tr><td colspan="6" style="text-align: center;">データが見つかりません。</td></tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </main>
</div>

<div class="footer">
    &copy; 2023 TIC 大原学園
</div>