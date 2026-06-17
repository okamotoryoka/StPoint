<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ include file="../header.html" %>

<%
    Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
    String name = request.getAttribute("name") != null ? (String) request.getAttribute("name") : "";
    String no = request.getAttribute("no") != null ? (String) request.getAttribute("no") : "";
    String entYear = request.getAttribute("entYear") != null ? (String) request.getAttribute("entYear") : "";
    String classNum = request.getAttribute("classNum") != null ? (String) request.getAttribute("classNum") : "";
%>

<style>
    .page-panel { max-width: 800px; margin: 20px; font-family: sans-serif; }
    .page-title { background-color: #e9ecef; padding: 15px; font-weight: bold; font-size: 18px; margin-bottom: 25px; }
    .stacked-form { display: flex; flex-direction: column; gap: 20px; }
    .stacked-form label { display: block; font-weight: bold; margin-bottom: 5px; }
    .stacked-form input, .stacked-form select { width: 100%; height: 40px; padding: 0 10px; border: 1px solid #ced4da; border-radius: 4px; box-sizing: border-box; }
    .error-msg { color: #f59f00; font-weight: bold; font-size: 14px; margin-top: 5px; display: block; }
</style>

<%-- 全体を横並びにするコンテナ --%>
<div style="display: flex; min-height: 100vh;">

    <%-- 左側：共通メニュー --%>
    <jsp:include page="/tag.jsp" />

    <%-- 右側：メインコンテンツ --%>
    <main style="flex: 1; padding: 20px;">
        <div class="page-panel">
            <div class="page-title">学生情報登録</div>
            <form class="stacked-form" action="${pageContext.request.contextPath}/StudentCreateExecute.action" method="post">
                <label>入学年度
                    <select name="entYear">
                        <option value="">--------</option>
                        <c:forEach var="year" items="${entYears}">
                            <option value="${year}" ${String.valueOf(year) == entYear ? 'selected' : ''}>${year}</option>
                        </c:forEach>
                    </select>
                    <% if(errors != null && errors.get("entYear") != null) { %><span class="error-msg"><%= errors.get("entYear") %></span><% } %>
                </label>

                <label>学生番号
                    <input type="text" name="no" value="<%= no %>" placeholder="学生番号を入力してください">
                    <% if(errors != null && errors.get("no") != null) { %><span class="error-msg"><%= errors.get("no") %></span><% } %>
                </label>

                <label>氏名
                    <input type="text" name="name" value="<%= name %>" placeholder="氏名を入力してください">
                    <% if(errors != null && errors.get("name") != null) { %><span class="error-msg"><%= errors.get("name") %></span><% } %>
                </label>

                <label>クラス
                    <select name="classNum">
                        <option value="">--------</option>
                        <c:forEach var="cNum" items="${classNums}">
                            <option value="${cNum}" ${cNum == classNum ? 'selected' : ''}>${cNum}</option>
                        </c:forEach>
                    </select>
                    <% if(errors != null && errors.get("classNum") != null) { %><span class="error-msg"><%= errors.get("classNum") %></span><% } %>
                </label>

                <input type="submit" value="登録して終了" style="padding: 10px 20px; background-color: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer;">
            </form>
            <br>
            <a href="${pageContext.request.contextPath}/StudentList.action">戻る</a>
        </div>
    </main>
</div>