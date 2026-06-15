<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生情報変更完了</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style2.css">
<style>
    /* リンクの表示崩れを修正 */
    .link-box { margin-top: 20px; }
    .link-box a { color: #0000ee; text-decoration: underline; }
</style>
</head>
<body>

<div class="container">
    <div class="layout-wrapper">

        <div class="side-menu">
            <jsp:include page="/tag.jsp" />
        </div>

        <div class="main-content">
            <div class="title-box">学生情報変更</div>

            <div class="success-box" style="margin: 20px 0; font-weight: bold;">
                変更が完了しました
            </div>

            <div class="link-box">
                <a href="${pageContext.request.contextPath}/StudentList.action">学生一覧へ戻る</a>
            </div>
        </div>

    </div>
</div>

</body>
</html>