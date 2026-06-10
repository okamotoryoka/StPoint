<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../header.html" %>

<head>
    <style>
        /* 1. 基本リセット */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: sans-serif; }

        /* 2. 画面レイアウト（メニューとメインを左右に並べる） */
        .system-layout { display: flex; width: 100%; min-height: 100vh; }
        .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; }
        .main-content { flex: 1; padding: 30px; }

        /* 3. 検索エリア */
        .filter-box { display: flex; gap: 20px; align-items: center; padding: 20px; background-color: #f8f9fa; border: 1px solid #ddd; margin-bottom: 20px; }
        .filter-group { display: flex; align-items: center; gap: 10px; }
        .btn-submit { padding: 8px 20px; background-color: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer; }

        /* 4. テーブル */
        .student-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .student-table th, .student-table td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; }

        /* 5. フッター */
        .footer { background-color: #eee; padding: 15px; text-align: center; font-size: 12px; color: #666; margin-top: 30px; }
    </style>
</head>

<div class="system-layout">
    <%-- 左サイドメニュー --%>
    <div class="side-menu">
        <jsp:include page="/tag.jsp"/>
    </div>

    <%-- 右メインコンテンツ --%>
    <main class="main-content">
        <h1>学生管理</h1>

        <form action="${pageContext.request.contextPath}/StudentList.action" method="post" class="filter-box">
            <div class="filter-group">
                <label>入学年度</label>
                <select name="entYear">
                    <option value="">--------</option>
            
                </select>
            </div>
            <div class="filter-group">
                <label>クラス</label>
                <select name="classNum">
                    <option value="">--------</option>
                </select>
            </div>
            <div class="filter-group">
                <input type="checkbox" name="isAttend" value="true"> 在学中
            </div>
            <input type="submit" value="絞込み" class="btn-submit">
        </form>

        <table class="student-table">
            <thead>
                <tr><th>入学年度</th><th>学生番号</th><th>氏名</th><th>クラス</th><th>在学中</th><th></th></tr>
            </thead>
            <tbody>
                <%-- ここに学生リストのループ処理を入れてください --%>
            </tbody>
        </table>
    </main>
</div>

<div class="footer">
    &copy; 2023 TIC 大原学園
</div>