<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Bean.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<%@ include file="../header.html" %>

<%
    Student student = (Student) request.getAttribute("student");
    List<String> classList = (List<String>) request.getAttribute("class_list");
    
    String no = (student != null) ? student.getNo() : "";
    String name = (student != null) ? student.getName() : "";
    int entYear = (student != null) ? student.getEntYear() : 0;
    boolean isAttend = (student != null) ? student.isAttend() : true;
    String currentClass = (student != null) ? student.getClassNum() : "";

    // 画面表示用の新しいリストを作り、そこにデータベースから届いたクラス一覧をコピーします
    List<String> displayClassList = new ArrayList<>();
    if (classList != null) {
        displayClassList.addAll(classList);
    }

    // 修正ポイント：新しく追加予定のクラス「1」を、誰を開いたときでも常に選択肢に含まれるように強制追加します
    if (!displayClassList.contains("1")) {
        displayClassList.add("1");
    }
%>

<div class="content-body">

    <h1>学生変更画面</h1>

    <form action="${pageContext.request.contextPath}/StudentUpdatExecute.action" method="post">
        
        <input type="hidden" name="no" value="<%= no %>">
        <input type="hidden" name="entYear" value="<%= entYear %>">

        <table class="student-table" style="margin-top: 20px;">
            <tr>
                <th style="width: 150px; background-color: #f2f2f2; text-align: left; padding: 10px;">入学年度</th>
                <td style="padding: 10px;"><%= entYear == 0 ? "" : entYear %></td>
            </tr>
            <tr>
                <th style="background-color: #f2f2f2; text-align: left; padding: 10px;">学生番号</th>
                <td style="padding: 10px;"><%= no %></td>
            </tr>
            <tr>
                <th style="background-color: #f2f2f2; text-align: left; padding: 10px;">氏名</th>
                <td style="padding: 10px;">
                    <input type="text" name="name" value="<%= name %>" required oninvalid="this.setCustomValidity('このフィールドを入力してください')" oninput="setCustomValidity(''); " style="padding: 5px; width: 200px;">
                </td>
            </tr>
            
            <tr>
                <th style="background-color: #f2f2f2; text-align: left; padding: 10px;">クラス</th>
                <td style="padding: 10px;">
                    <select name="classNum" style="padding: 5px; width: 212px;">
                        <% 
                            if (displayClassList != null) {
                                for (String c : displayClassList) {
                                    String selected = "";
                                    if (currentClass != null && !currentClass.isEmpty()) {
                                        // 現在の生徒のクラスと一致するものだけを正しく選択状態にします
                                        if (c.equals(currentClass)) {
                                            selected = "selected";
                                        }
                                    }
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
