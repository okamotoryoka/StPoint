<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Bean.Student" %>
<%@ page import="java.util.List" %>
<%@ include file="../header.html" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

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

<div class="content-body">
    <h1>学生変更画面</h1>

    <form action="${pageContext.request.contextPath}/StudentUpdatExecute.action" method="post">
        <input type="hidden" name="no" value="<%= no %>">
        
        <table class="student-table" style="margin-top: 20px;">
            <tr>
                <th style="width: 150px; background-color: #f2f2f2; padding: 10px;">入学年度</th>
                <td style="padding: 10px;"><%= entYear %></td>
            </tr>
            <tr>
                <th style="background-color: #f2f2f2; padding: 10px;">学生番号</th>
                <td style="padding: 10px;"><%= no %></td>
            </tr>
            <tr>
                <th style="background-color: #f2f2f2; padding: 10px;">氏名</th>
                <td style="padding: 10px;">
                    <input type="text" name="name" value="<%= name %>" required style="padding: 5px; width: 200px;">
                </td>
            </tr>
            <tr>
                <th style="background-color: #f2f2f2; padding: 10px;">クラス</th>
                <td style="padding: 10px;">
                    <select name="classNum" style="padding: 5px; width: 212px;">
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
                </td>
            </tr>       
            <tr>
                <th style="background-color: #f2f2f2; padding: 10px;">在学中</th>
                <td style="padding: 10px;">
                    <input type="checkbox" name="isAttend" value="true" <%= isAttend ? "checked" : "" %>> 在学中
                </td>
            </tr>
        </table>

        <div style="margin-top: 20px;">
            <input type="submit" value="変更" class="btn-submit" style="width: 100px;">
        </div>
    </form>

    <p style="margin-top: 20px;">
        <a href="${pageContext.request.contextPath}/StudentList.action" class="link-action">戻る</a>
    </p>
</div>

<%@ include file="../footer.jsp" %>