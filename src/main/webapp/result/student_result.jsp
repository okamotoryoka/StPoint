<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生情報登録</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style2.css">

</head>

<body>

<<body>

<!-- 全体を包む大きな枠（外枠は既存の container を使用） -->
<div class="container">

    <!-- 💡 追加：左メニューと右コンテンツを横並びにするためのレイアウト枠 -->
    <div class="layout-wrapper">
    
        <!-- 💡 追加：左側のメニューエリア -->
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

        <!-- 💡 変更：右側のメインコンテンツエリア（元の中身をここに移動） -->
        <div class="main-content">
            <!-- ① タイトルボックス -->
            <div class="title-box">
                学生情報変更
            </div>

            <!-- ② 完了メッセージ -->
            <div class="success-box">
                変更が完了しました
            </div>

            <!-- ③ 戻るリンク（見本に合わせて文字を変更） -->
            <div class="link-box">
                <a href="${pageContext.request.contextPath}/result/student_create.jsp">
                    学生一覧
                </a>
            </div>
        </div>
        
    </div><!-- layout-wrapper 終わり -->

</div>

</body>

</body>
</html>