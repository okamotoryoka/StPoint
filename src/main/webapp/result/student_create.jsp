<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "生徒登録"); %>
<%@ include file="../header.html" %>

<style>
    /* 1. 基本リセット：隙間を強制的にゼロにする */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { margin: 0; padding: 0; font-family: sans-serif; }

    /* 2. 全体レイアウト：メニューとメインを並べる */
    .layout-wrapper { display: flex; width: 100%; min-height: 100vh; }
    
    /* 3. サイドメニュー */
    .side-menu { 
        width: 200px; 
        flex-shrink: 0; 
        background-color: #f8f9fa; 
        border-right: 1px solid #e2e8f0; 
        padding: 20px; 
    }
    
    /* 4. メインエリア */
    .main-content { flex: 1; padding: 40px; }
    
    /* 5. フォームパネル：左寄せにする */
    .page-panel { max-width: 800px; margin: 0; }
    
    /* 6. タイトル帯 */
    .page-title { 
        background-color: #e9ecef; 
        padding: 15px; 
        font-weight: bold; 
        font-size: 18px; 
        margin-bottom: 25px; 
    }

    /* 7. フォーム部品 */
    .stacked-form { display: flex; flex-direction: column; gap: 20px; }
    .stacked-form label { display: flex; flex-direction: column; font-weight: bold; color: #333; gap: 8px; }
    .stacked-form input, .stacked-form select { 
        width: 100%; height: 40px; padding: 0 10px; border: 1px solid #ced4da; border-radius: 4px; background-color: #fff; 
    }

    /* 8. ボタン */
  .form-actions {
    margin-top: 20px;
    text-align: left; /* 左寄せにする場合 */
}

.form-actions input[type="submit"] {
    width: auto;             /* 幅を自動（文字サイズ合わせ）にする */
    min-width: 120px;        /* ただし小さすぎないよう最低限の幅を確保 */
    padding: 10px 20px;      /* 左右に余白をとってボタンらしくする */
    background-color: #6c757d;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: bold;
}

    /* 9. 戻るリンク */
    .actions { margin-top: 20px; }
    .link-next { color: #3182ce; text-decoration: none; }
</style>

<div class="layout-wrapper">
    <div class="side-menu">
        <jsp:include page="/tag.jsp" />
    </div>

    <main class="main-content">
        <div class="page-panel">
            <div class="page-title">学生情報登録</div>
            
            <form class="stacked-form" action="${pageContext.request.contextPath}/StudentCreateExecute.action" method="post">
                <label>入学年度
                    <select name="entYear">
                        <option value="">--------</option>
                    </select>
                </label>

                <label>学生番号
                    <input type="text" name="no" placeholder="学生番号を入力してください">
                </label>

                <label>氏名
                    <input type="text" name="name" placeholder="氏名を入力してください">
                </label>

                <label>クラス
                    <select name="classNum">
                        <option value="101">101</option>
                    </select>
                </label>

                <div class="form-actions">
                    <input type="submit" value="登録して終了">
                </div>
            </form>

            <p class="actions">
                <a class="link-next" href="${pageContext.request.contextPath}/StudentList.action">戻る</a>
            </p>
        </div>
    </main>
</div>

<%@ include file="../footer.jsp" %>