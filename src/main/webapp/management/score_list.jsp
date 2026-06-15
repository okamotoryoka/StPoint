<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>得点一覧</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
<style>
    body { background-color: #f7f3e9; font-family: "Hiragino Maru Gothic ProN", "Yu Gothic", sans-serif; margin: 0; }
    .main-layout { display: flex; min-height: 80vh; width: 100%; box-sizing: border-box; padding: 40px; gap: 30px; }
    .left-menu-area { width: 220px !important; min-width: 220px !important; max-width: 220px !important; background: #fff; border-radius: 20px; border: 4px solid #d8c7a1; box-shadow: 0 4px 10px rgba(0,0,0,0.1); box-sizing: border-box; }
    .left-menu-area *, .left-menu-area div, .left-menu-area aside { width: 100% !important; max-width: 220px !important; margin: 0 !important; background: transparent !important; box-shadow: none !important; border: none !important; box-sizing: border-box !important; }
    .left-menu-area ul { list-style: none !important; padding: 30px 15px 30px 25px !important; }
    .left-menu-area li { font-size: 18px !important; line-height: 2.2 !important; margin-bottom: 8px !important; }
    .content-body { flex: 1; padding: 0; box-sizing: border-box; display: flex; }
    .right-container { width: 100%; max-width: 1000px; background: #fff; border-radius: 20px; padding: 30px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); border: 4px solid #d8c7a1; box-sizing: border-box; }
    .title { text-align: center; font-size: 32px; font-weight: bold; margin-bottom: 20px; color: #6b4f2d; }
    .add-link { display: inline-block; margin-bottom: 20px; font-size: 18px; color: #6b4f2d; text-decoration: none; border-bottom: 2px solid #6b4f2d; }
    .score-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    .score-table th, .score-table td { border: 3px solid #d8c7a1; padding: 12px 10px; text-align: center; font-size: 18px; white-space: nowrap; }
    .score-table th { background-color: #f0e6d2; font-weight: bold; color: #6b4f2d; }
    .score-table tr:nth-child(even) { background-color: #faf7f0; }
</style>
</head>
<body>

<%
// サーブレットから受け取る検索条件の初期化
String entYear = (String) request.getAttribute("entYear");
String classNum = (String) request.getAttribute("classNum");
String subjectCd = (String) request.getAttribute("subjectCd");
String noStr = (String) request.getAttribute("no");

if (entYear == null) entYear = "";
if (classNum == null) classNum = "";
if (subjectCd == null) subjectCd = "";
if (noStr == null) noStr = "";
%>

<header class="system-header">
    <div class="header-title">得点管理システム</div>
    <div class="header-user">
        <span>${sessionScope.teacher_name}様</span>
        <a href="#" class="logout-btn">ログアウト</a>
    </div>
</header>

<div class="main-layout">
    <div class="left-menu-area"><jsp:include page="/tag.jsp" /></div>

    <div class="content-body">
        <div class="right-container">
            <div class="title">得点一覧</div>

            <a class="add-link" href="${pageContext.request.contextPath}/management/score_insert.jsp">
                ＋ 新規登録
            </a>

            <table class="score-table">
                <tr>
                    <th>学生番号</th><th>氏名</th><th>科目</th><th>回数</th><th>得点</th><th>クラス</th><th>更新</th><th>削除</th>
                </tr>
                <%
                ArrayList<Map<String, Object>> list = (ArrayList<Map<String, Object>>) request.getAttribute("list");
                if(list != null) {
                    for(Map<String, Object> data : list){
                %>
                <tr>
                    <td><%= data.get("student_id") %></td>
                    <td><%= data.get("student_name") %></td>
                    <td><%= data.get("subject_name") %></td>
                    <td><%= data.get("no") %></td>
                    <td><%= data.get("point") %></td>
                    <td><%= data.get("class_num") %></td>
                    <td><a href="${pageContext.request.contextPath}/ScoreUpdateServlet.action?student_id=<%= data.get("student_id") %>&subject_cd=<%= data.get("subject_cd") %>&school_cd=<%= data.get("school_cd") %>&no=<%= data.get("no") %>">更新</a></td>
                    <td><a href="${pageContext.request.contextPath}/management/score_delete.jsp?student_id=<%= data.get("student_id") %>&subject_cd=<%= data.get("subject_cd") %>&school_cd=<%= data.get("school_cd") %>&no=<%= data.get("no") %>">削除</a></td>
                </tr>
                <% 
                    } 
                } 
                %>
            </table>
        </div>
    </div>
</div>
</body>
</html>