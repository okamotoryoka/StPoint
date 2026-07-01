<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>メニュー - 得点管理システム</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style5.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>

<%-- 1. 共通ヘッダー --%>
<%@ include file="/header.jsp" %>

<%-- 2. コンテナエリア --%>
<div class="container">
    
    <%-- サイドメニュー (tag.jsp) --%>
    <jsp:include page="tag.jsp" />

    <%-- メインコンテンツ --%>
    <main class="main">
        <div class="welcome">
            <img src="${pageContext.request.contextPath}/images/welcome_banner.png" alt="Welcome Banner">
            <div class="welcome-text">
                <h1>ようこそ！</h1>
                <h2>得点管理システムへ</h2>
                <p>各種管理メニューから操作を選択してください。</p>
            </div>
        </div>
        
        <div class="card-area">
            <div class="card student-card">
                <div class="card-icon"><i class="fa-solid fa-user-graduate"></i></div>
                <h3>学生管理</h3>
                <p>学生情報の登録・編集・管理を行います。</p>
                <a href="${pageContext.request.contextPath}/StudentList.action" class="student-btn">
                    学生一覧へ →
                </a>
            </div>

            <div class="card score-card">
                <div class="card-icon"><i class="fa-solid fa-chart-line"></i></div>
                <h3>成績管理</h3>
                <p>成績の登録や参照を行います。</p>
                <a href="${pageContext.request.contextPath}/ScoreListServlet.action" class="score-btn">
                    成績登録 →
                </a>
                <a href="${pageContext.request.contextPath}/ScoreSubject.action" class="score-btn">
                    成績参照 →
                </a>
            </div>

            <div class="card subject-card">
                <div class="card-icon"><i class="fa-solid fa-book-open"></i></div>
                <h3>科目管理</h3>
                <p>科目情報の登録・編集・管理を行います。</p>
                <a href="${pageContext.request.contextPath}/SubjectList.action" class="subject-btn">
                    科目一覧へ →
                </a>
            </div>
        </div>
        </main>
</div> <%-- 💡 container の閉じタグ --%>

<%-- 💡 3. フッターを画面全体の最下部（containerの外、bodyの直下）に配置 --%>
<div class="login-footer">
    &copy; 2023 TIC<br>大原学園
</div>

</body>
</html>