<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Bean.Student" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<%@ include file="../header.html" %>

<%
    // StudentUpdateAction から送られてきた学生データを取得する
    Student student = (Student) request.getAttribute("student");
    
    // 万が一データが空だった場合の対策
    String no = (student != null) ? student.getNo() : "";
    String name = (student != null) ? student.getName() : "";
    int entYear = (student != null) ? student.getEntYear() : 0;
    boolean isAttend = (student != null) ? student.isAttend() : true;
%>

<div class="content-body">

    <h1>学生変更画面</h1>

    <%-- 変更ボタンを押したら更新処理を行うActionへ送信 --%>
    <form action="${pageContext.request.contextPath}/StudentUpdatExecute.action" method="post">
        
        <%-- どの学生を更新するか裏で保持しておくための隠し項目 --%>
        <input type="hidden" name="no" value="<%= no %>">

        <table class="student-table" style="margin-top: 20px;">
            <tr>
                <th style="width: 150px; background-color: #f2f2f2; text-align: left; padding: 10px;">入学年度</th>
                <%-- ⭕ 入力欄にせず、文字として表示するだけで書き換えを防ぎます --%>
                <td style="padding: 10px;"><%= entYear == 0 ? "" : entYear %></td>
                <%-- 更新用Action（Java側）に値を送るための隠し項目 --%>
                <input type="hidden" name="entYear" value="<%= entYear %>">
            </tr>
            <tr>
                <th style="background-color: #f2f2f2; text-align: left; padding: 10px;">学生番号</th>
                <td style="padding: 10px;"><%= no %></td>
            </tr>
            <tr>
                <th style="background-color: #f2f2f2; text-align: left; padding: 10px;">氏名</th>
                <td style="padding: 10px;">
                    <%-- 未入力チェック（required）を設定 --%>
                    <input type="text" name="name" value="<%= name %>" required oninvalid="this.setCustomValidity('このフィールドを入力してください')" oninput="setCustomValidity('')" style="padding: 5px; width: 200px;">
                </td>
            </tr>
            <tr>
                <th style="background-color: #f2f2f2; text-align: left; padding: 10px;">在学中</th>
                <td style="padding: 10px;">
                    <input type="checkbox" name="isAttend" value="true" <%= isAttend ? "checked" : "" %>> 在学中
                </td>
            </tr>
        </table>

        <br>
        <input type="submit" value="変更" class="btn-submit" style="width: 100px;">
    </form>

    <p style="margin-top: 20px;">
        <a href="${pageContext.request.contextPath}/StudentList.action" class="link-action">戻る</a>
    </p>

</div>

<%@ include file="../footer.html" %>
