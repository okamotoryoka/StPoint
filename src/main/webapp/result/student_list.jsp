<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生管理</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: sans-serif; background-color: #ffffff; }
        
        /* 全体の2カラムレイアウト（ヘッダー高さ80pxに適合） */
        .system-layout { 
            display: flex; 
            width: 100%; 
            min-height: calc(100vh - 80px); 
        }
        
        /* 左側メニュー枠：幅220px固定 */
        .side-menu { 
            width: 220px; 
            min-width: 220px; 
            flex-shrink: 0; 
            background-color: #ffffff; 
            border-right: 1px solid #e0e0e0; 
        }
        
        /* 右側メインエリア */
        .main-content { 
            flex: 1; 
            padding: 30px; 
        }

        /* ① グレーの見出し帯（独立） */
        .title-area {
            background-color: #f0f0f0;
            padding: 10px 15px;
            margin-bottom: 10px; /* 下の新規登録リンクとの隙間 */
            width: 100%;
        }
        .title-area h2 {
            margin: 0;
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }

        /* ⑧ 新規登録リンクの見た目 */
        .create-link {
            color: #0066cc;
            text-decoration: underline;
            font-size: 14px;
        }

        /* ②〜⑨ 絞込み検索フォーム全体の囲み */
        .filter-box { 
            display: flex; 
            align-items: center; 
            gap: 50px;         /* ★要素同士の横の隙間を50pxまで大きく広げました */
            padding: 20px 30px; /* 内側の余白を上下左右さらにゆったり配置 */
            background-color: #ffffff; 
            border: 1px solid #e0e0e0; 
            border-radius: 4px; 
            margin-bottom: 20px; 
            width: 100%;
        }
        
        /* 各フォームの縦並び枠 */
        .filter-group { 
            display: flex; 
            flex-direction: column; 
            gap: 6px; 
        }
        .filter-group label {
            font-size: 14px;
            color: #333;
        }
        
        /* ④⑤ セレクトボックスのさらに幅広なデザイン */
        .filter-group select {
            height: 38px;      /* 高さを38pxにしてさらに押しやすく */
            width: 260px;      /* ★横幅を220pxからさらに【260px】へ拡大しました */
            padding: 0 12px;   
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #ffffff;
        }

        /* ⑥⑦ 在学中チェックボックス専用の並び調整 */
        .filter-group-checkbox {
            display: flex;
            flex-direction: row;
            align-items: center;
            margin-top: 25px;  /* セレクトボックスの高さに合わせるための調整 */
        }

        /* ⑨ 絞込みボタン */
        .btn-submit { 
            height: 38px;      /* セレクトボックスの高さ（38px）と完全に一致 */
            padding: 0 25px;   /* ボタンの横幅も少しゆったりと */
            background-color: #555555; 
            color: white; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer; 
            font-size: 14px;
            margin-left: auto; /* ボタンを一番右側に寄せる */
        }
        .btn-submit:hover {
            background-color: #333333;
        }

        /* ⑩ 検索結果の件数表示 */
        .result-count {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }

        /* ⑪〜㉒ 学生一覧テーブル */
        .student-table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 10px; 
            font-size: 15px;
        }
        .student-table th { 
            padding: 12px 10px; 
            text-align: left; 
            font-weight: bold;
            color: #333;
            border-top: 1px solid #dcdcdc;
            border-bottom: 2px solid #333;
        }
        .student-table td { 
            padding: 14px 10px; 
            border-bottom: 1px solid #efefef; 
            text-align: left; 
            color: #555;
        }
        .student-table td a {
            color: #0066cc;
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <%
        List<Student> list = (List<Student>) request.getAttribute("students");
        int count = (list != null) ? list.size() : 0;
    %>

    <!-- 共通ヘッダーの読み込み -->
    <jsp:include page="../header.jsp" />

    <!-- 全体の2カラムレイアウト -->
    <div class="system-layout">
        
        <!-- 左側：共通サイドバーの読み込み枠 -->
        <div class="side-menu">
            <jsp:include page="../tag.jsp"/>
        </div>

        <!-- 右側：メインコンテンツ領域 -->
        <main class="main-content">
            
            <!-- ① グレーの見出し帯（独立） -->
            <div class="title-area">
                <h2>学生管理</h2>
            </div>

            <!-- ⑧ 新規登録リンク（帯の外側、右寄せ配置） -->
            <div style="text-align: right; margin-bottom: 15px;">
                <a href="${pageContext.request.contextPath}/StudentCreate.action" class="create-link">新規登録</a>
            </div>

            <!-- ②〜⑨ 絞込み検索フォームエリア -->
            <form action="${pageContext.request.contextPath}/StudentList.action" method="post" class="filter-box">
                
                <!-- ②③④ 入学年度 -->
                <div class="filter-group">
                    <label>入学年度</label>
                    <select name="entYear">
                        <option value="">--------</option>
                        <%
                            List<?> yearList = (List<?>) request.getAttribute("yearList");
                            String sYear = String.valueOf(request.getAttribute("selectedYear") != null ? request.getAttribute("selectedYear") : "");
                            if (yearList != null) {
                                for (Object y : yearList) {
                                    String val = String.valueOf(y);
                        %>
                                    <option value="<%= val %>" <%= val.equals(sYear) ? "selected" : "" %>><%= val %></option>
                        <%      }
                            }
                        %>
                    </select>
                </div>

                <!-- ⑤ クラス -->
                <div class="filter-group">
                    <label>クラス</label>
                    <select name="classNum">
                        <option value="">--------</option>
                        <%
                            List<?> classList = (List<?>) request.getAttribute("classList");
                            String sClass = String.valueOf(request.getAttribute("selectedClass") != null ? request.getAttribute("selectedClass") : "");
                            if (classList != null) {
                                for (Object c : classList) {
                                    String val = String.valueOf(c);
                        %>
                                    <option value="<%= val %>" <%= val.equals(sClass) ? "selected" : "" %>><%= val %></option>
                        <%      }
                            }
                        %>
                    </select>
                </div>

                <!-- ⑥⑦ 在学中チェックボックス -->
                <div class="filter-group-checkbox">
                    <% Boolean isAttend = (Boolean) request.getAttribute("selectedAttend"); %>
                    <input type="checkbox" name="isAttend" value="true" <%= (isAttend != null && isAttend) ? "checked" : "" %> id="attend-cb">
                    <label style="margin-left: 5px; cursor: pointer;" for="attend-cb">在学中</label>
                </div>

                <!-- ⑨ 絞込みボタン -->
                <input type="submit" value="絞込み" class="btn-submit">

            </form>

            <!-- ⑩ 検索結果の件数表示 -->
            <div class="result-count">
                検索結果：<%= count %>件
            </div>

            <!-- ⑪〜㉒ 学生一覧テーブル -->
            <table class="student-table">
                <thead>
                    <tr>
                        <th>入学年度</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>クラス</th>
                        <th>在学中</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (list != null && !list.isEmpty()) {
                            for (Student s : list) {
                    %>
                                <tr>
                                    <td><%= s.getEntYear() %></td>
                                    <td><%= s.getNo() %></td>
                                    <td><%= s.getName() %></td>
                                    <td><%= s.getClassNum() %></td>
                                    <td><%= s.isAttend() ? "〇" : "×" %></td>
                                    <!-- ㉒ 変更リンク -->
                                    <td style="text-align: right;">
                                        <a href="${pageContext.request.contextPath}/StudentUpdate.action?no=<%= s.getNo() %>">変更</a>
                                    </td>
                                </tr>
                    <%      }
                        } else {
                    %>
                            <tr><td colspan="6" style="text-align: center; padding: 30px;">学生情報が存在しませんでした</td></tr>
                    <%  } %>
                </tbody>
            </table>
        </main>

    </div>

</body>
</html>
