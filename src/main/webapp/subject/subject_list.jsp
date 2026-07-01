<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Subject" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>科目管理 - 得点管理システム</title>
    <style>
        /* レイアウト構造 */
        body { margin: 0; font-family: sans-serif; }
        .system-layout { display: flex; flex-direction: column; min-height: 100vh; }
        .main-container { display: flex; flex: 1; }
        
        /* サイドメニューとコンテンツ */
        .side-menu { width: 220px; flex-shrink: 0; border-right: 1px solid #ddd; background-color: #f8f9fa; }
        .content-body { flex: 1; padding: 30px; }
        
        /* コンポーネントスタイル */
        .page-header { background-color: #f5f5f5; padding: 15px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid #ddd; }
        .student-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .student-table th, .student-table td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; }
        .footer { background-color: #eee; padding: 15px; text-align: center; font-size: 12px; color: #666; margin-top: auto; }
    </style>
</head>
<body>

<%-- 共通ヘッダー --%>
<jsp:include page="/header.jsp" />

<div class="system-layout">
    <div class="main-container">
        
        <%-- サイドメニュー --%>
        <div class="side-menu">
            <jsp:include page="../tag.jsp" />
        </div>

        <%-- メインコンテンツ --%>
        <main class="content-body">
            <div class="page-header">
                <h1 style="margin: 0; font-size: 20px;">科目管理</h1>
                <a href="SubjectCreate.action">新規登録</a>
            </div>

            <%
                List<Subject> subjects = (List<Subject>) request.getAttribute("subjects");
            %>

            <table class="student-table">
                <thead>
                    <tr>
                        <th>科目コード</th>
                        <th>科目名</th>
                        <th style="text-align: center;">変更</th>
                        <th style="text-align: center;">削除</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (subjects != null && !subjects.isEmpty()) {
                            for (Subject sub : subjects) {
                    %>
                        <tr>
                            <td><%= sub.getCd() %></td>
                            <td><%= sub.getName() %></td>
                            <td style="text-align: center;">
                                <a href="SubjectUpdate.action?cd=<%= sub.getCd() %>">変更</a>
                            </td>
                            <td style="text-align: center;">
                                <a href="${pageContext.request.contextPath}/SubjectDelete.action?cd=<%= sub.getCd() %>">削除</a>
                            </td>
                        </tr>
                    <%      }
                        } else {
                    %>
                        <tr><td colspan="4" style="text-align: center; padding: 20px;">登録されている科目がありません。</td></tr>
                    <%  } %>
                </tbody>
            </table>

            <p style="margin-top: 30px;">
                <a href="${pageContext.request.contextPath}/menu.jsp">メニューへ戻る</a>
            </p>
        </main>
    </div>

    

</body>
</html>