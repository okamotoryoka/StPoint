<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 
    【修正のポイント】
    1. padding-top: 0; にして上部の隙間を完全になくしました
    2. line-height: 1.6; にして、行間を詰めました
    3. margin-bottom を 5px にして、項目同士の距離を縮めました
--%>
<aside class="sidebar" style="width: 200px; padding: 0 0 20px 20px; box-sizing: border-box; background-color: #ffffff; height: 100vh;">
    <style>
        .sidebar ul { list-style: none; padding: 0; margin: 0; }
        
        /* 行間を詰める設定 */
        .sidebar li { line-height: 1.6; margin-bottom: 5px; }
        
        /* リンクの青色設定 */
        .sidebar a {
            color: #0000EE;
            text-decoration: none;
            display: block;
            padding: 4px 0; /* リンクの上下余白を最小化 */
        }
        .sidebar a:hover { text-decoration: underline; }
        
        /* タイトル（見出し）のスタイル */
        .menu-title { font-weight: bold; color: #333; margin-top: 10px; }
    </style>

    <ul>
        <li><a href="${pageContext.request.contextPath}/menu.jsp">メニュー</a></li>
        <li><a href="${pageContext.request.contextPath}/StudentList.action">学生管理</a></li>

        <li class="menu-title">成績管理</li>
        <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/ScoreListServlet.action">成績登録</a></li>
        <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/ScoreSubject.action">成績参照</a></li>

        <li class="menu-title"><a href="${pageContext.request.contextPath}/SubjectList.action">科目管理</a></li>
    </ul>
</aside>