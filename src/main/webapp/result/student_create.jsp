<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>学生情報登録</title>
    <style>
        /* すべての基本余白をリセットします */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: sans-serif; background-color: #ffffff; }

        /* 全体の2カラムレイアウト（ヘッダー高さ80pxに適合） */
        .system-layout { 
            display: flex; 
            width: 100%; 
            min-height: calc(100vh - 80px); 
        }

        /* 左側メニュー枠：★お手本通り、右側に1pxの縦線（border-right）を追加しました */
        .side-menu { 
            width: 220px; 
            min-width: 220px; 
            flex-shrink: 0; 
            border-right: 1px solid #e0e0e0; /* ★これがサイドバーとメインを分ける縦線です */
            background-color: #ffffff;
        }

        /* 右側メインエリア：内側の余白を30pxに設定 */
        .main-content { 
            flex: 1; 
            padding: 30px; 
            box-sizing: border-box;
        }

        /* ① グレーの見出し帯 */
        .page-title { 
            background-color: #f0f0f0; 
            padding: 12px 25px; /* 上下の余白を12pxにしてスマートな太さに統一 */
            margin-top: 0;
            margin-bottom: 30px; 
            width: 100%;
            max-width: 950px; /* 見出しの帯は広めの950pxで固定 */
            box-sizing: border-box;
        }

        /* 縦並びフォームの枠組み */
        .stacked-form { 
            display: flex; 
            flex-direction: column; 
            gap: 20px; 
            width: 100%;
            margin-left: 20px; /* 左側に20pxの美しい空間をキープ */
        }

        /* フォームの項目名ラベル */
        .form-label {
            font-size: 14px;
            color: #333;
            font-weight: bold;
            display: flex;
            flex-direction: column;
            gap: 8px;
            width: 100%;
        }

        /* 入力欄（氏名・学生番号：絶妙な720px幅） */
        .input-text { 
            width: 100%; 
            max-width: 720px; 
            height: 40px; 
            padding: 0 12px; 
            border: 1px solid #ccc; 
            border-radius: 4px; 
            font-size: 14px;
        }

        /* セレクトボックス（入学年度・クラス：720px幅） */
        .input-select { 
            width: 100%; 
            max-width: 720px; 
            height: 40px; 
            padding: 0 12px; 
            border: 1px solid #ccc; 
            border-radius: 4px; 
            font-size: 14px;
            background-color: #ffffff;
        }

        /* エラーメッセージ（オレンジ色） */
        .error-msg { 
            color: #f59f00; 
            font-weight: bold; 
            font-size: 14px; 
            margin-top: 5px; 
            display: block; 
        }

        /* 登録して終了ボタン（シックなグレー） */
        .submit-btn {
            width: 120px;
            height: 40px;
            background-color: #6c757d; 
            color: white; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer;
            font-size: 14px;
        }
        .submit-btn:hover {
            background-color: #5a6268;
        }

        /* 戻るリンク */
        .back-link {
            color: #0066cc;
            text-decoration: underline;
            font-size: 14px;
            display: inline-block;
            margin-top: 20px;
            margin-left: 20px; 
        }
    </style>
</head>
<body>

    <%
        Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
        String name = request.getAttribute("name") != null ? (String) request.getAttribute("name") : "";
        String no = request.getAttribute("no") != null ? (String) request.getAttribute("no") : "";
        String entYear = request.getAttribute("entYear") != null ? (String) request.getAttribute("entYear") : "";
        String classNum = request.getAttribute("classNum") != null ? (String) request.getAttribute("classNum") : "";
        
        // リクエストスコープから選択肢リストを取得
        List<?> entYears = (List<?>) request.getAttribute("entYears");
        List<?> classNums = (List<?>) request.getAttribute("classNums");
    %>

    <!-- 共通ヘッダーの読み込み -->
    <jsp:include page="../header.jsp" />

    <!-- 全体の2カラムレイアウト -->
    <div class="system-layout">

        <!-- 左側：共通メニュー（ここに縦線を追加しました） -->
        <div class="side-menu">
            <jsp:include page="/tag.jsp" />
        </div>

        <!-- 右側：メインコンテンツ -->
        <main class="main-content">
            
            <!-- ① グレーの見出し帯（大きな文字サイズ 26px） -->
            <div class="page-title">
                <h2 style="margin: 0; font-size: 26px; font-weight: bold; color: #333;">学生情報登録</h2>
            </div>

            <form class="stacked-form" action="${pageContext.request.contextPath}/StudentCreateExecute.action" method="post">
                
                <!-- 入学年度 -->
                <div class="form-label">
                    <span>入学年度</span>
                    <select name="entYear" class="input-select">
                        <option value="">--------</option>
                        <%
                            if (entYears != null) {
                                for (Object year : entYears) {
                                    String val = String.valueOf(year);
                                    String selected = val.equals(entYear) ? "selected" : "";
                        %>
                                    <option value="<%= val %>" <%= selected %>><%= val %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <% if(errors != null && errors.get("entYear") != null) { %><span class="error-msg"><%= errors.get("entYear") %></span><% } %>
                </div>

                <!-- 学生番号 -->
                <div class="form-label">
                    <span>学生番号</span>
                    <input type="text" name="no" value="<%= no %>" placeholder="学生番号を入力してください" class="input-text">
                    <% if(errors != null && errors.get("no") != null) { %><span class="error-msg"><%= errors.get("no") %></span><% } %>
                </div>

                <!-- 氏名 -->
                <div class="form-label">
                    <span>氏名</span>
                    <input type="text" name="name" value="<%= name %>" placeholder="氏名を入力してください" class="input-text">
                    <% if(errors != null && errors.get("name") != null) { %><span class="error-msg"><%= errors.get("name") %></span><% } %>
                </div>

                <!-- クラス -->
                <div class="form-label">
                    <span>クラス</span>
                    <select name="classNum" class="input-select">
                        <option value="">--------</option>
                        <%
                            if (classNums != null) {
                                for (Object cNum : classNums) {
                                    String val = String.valueOf(cNum);
                                    String selected = val.equals(classNum) ? "selected" : "";
                        %>
                                    <option value="<%= val %>" <%= selected %>><%= val %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <% if(errors != null && errors.get("classNum") != null) { %><span class="error-msg"><%= errors.get("classNum") %></span><% } %>
                </div>

                <!-- 登録して終了ボタン -->
                <div>
                    <input type="submit" value="登録して終了" class="submit-btn">
                </div>
            </form>
            
            <!-- 戻るリンク -->
            <a href="${pageContext.request.contextPath}/StudentList.action" class="back-link">戻る</a>

        </main>
    </div>

</body>
</html>
