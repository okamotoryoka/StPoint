<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>学生情報登録完了</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style2.css">
    <style>
        /* 左右レイアウト用CSS（style2.cssになければここに追加してください） */
        .layout-wrapper { display: flex; width: 100%; min-height: 100vh; }
        .side-menu { width: 200px; background-color: #f8f9fa; border-right: 1px solid #e2e8f0; }
        .main-content { flex: 1; padding: 40px; }
    </style>
</head>
<body>

<div class="container">
    <div class="layout-wrapper">
        
        <div class="side-menu">
            <jsp:include page="../tag.jsp" />
        </div>

        <div class="main-content">
            <div class="title-box">
                学生情報登録
            </div>

            <div class="success-box">
                登録が完了しました
            </div>




        <div class="link-box" style="display: flex; gap: 20px; margin-top: 20px;">
           <a href="${pageContext.request.contextPath}/StudentCreate.action">戻る</a>
           <a href="${pageContext.request.contextPath}/StudentList.action">学生一覧</a>
         
            </div>
        </div>

    </div>
</div>

</body>
</html>