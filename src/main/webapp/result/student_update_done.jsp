<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生情報変更完了</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style2.css">

</head>

<body>

<!-- 全体 -->
<div class="container">

    <!-- 左右レイアウト -->
    <div class="layout-wrapper">

        <!-- 左メニュー -->
        <div class="side-menu">
            <ul>
                <li><a href="#">メニュー</a></li>
                <li><a href="#">学生管理</a></li>
                <li><a href="#">成績管理</a></li>
                <li class="sub-menu"><a href="#">成績登録</a></li>
                <li class="sub-menu"><a href="#">成績参照</a></li>
                <li><a href="#">科目管理</a></li>
            </ul>
        </div>

        <!-- 右コンテンツ -->
        <div class="main-content">

            <!-- タイトル -->
            <div class="title-box">
                学生情報変更
            </div>

            <!-- 完了メッセージ -->
            <div class="success-box">
                変更が完了しました
            </div>

            <!-- 戻るリンク -->
            <div class="link-box">
                      <a href="${pageContext.request.contextPath}/StudentList.action">戻る</a>
                    学生一覧
                </a>
            </div>

        </div>

    </div>

</div>

</body>
</html>