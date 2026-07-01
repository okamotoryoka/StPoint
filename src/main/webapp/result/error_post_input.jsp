<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>エラー解決の投稿 - 得点管理システム</title>
<style>
    /* 全体と基本のレイアウト */
    body { font-family: "Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN", "Hiragino Sans", Meiryo, sans-serif; margin: 0; padding: 0; background-color: #f4f6f9; color: #333; }
    .system-layout { display: flex; width: 100%; min-height: 100vh; }
    .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; padding-top: 20px; box-sizing: border-box; }
    .main-content { flex: 1; padding: 30px; box-sizing: border-box; }
    
    /* タイトル */
    .search-title { font-size: 24px; font-weight: bold; margin-bottom: 25px; color: #222; border-bottom: 2px solid #0066cc; padding-bottom: 10px; }
    
    /* 投稿フォーム専用のスタイル */
    .form-container { max-width: 750px; background-color: #ffffff; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
    .form-group-block { margin-bottom: 25px; }
    .form-label-block { display: block; font-weight: bold; margin-bottom: 8px; color: #444; font-size: 15px; }
    
    /* 入力パーツ */
    .form-input-text { width: 100%; height: 42px; padding: 0 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 14px; background-color: #fff; }
    .form-textarea { width: 100%; height: 120px; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 14px; font-family: monospace; resize: vertical; background-color: #fff; }
    
    /* 💡【重要】カスタムドロップダウン用のスタイル（必ず下に開くように制御） */
    .custom-select-wrapper { position: relative; width: 100%; }
    .custom-select-trigger { 
        width: 100%; height: 42px; padding: 0 12px; border: 1px solid #ccc; border-radius: 4px; 
        box-sizing: border-box; font-size: 14px; background-color: #fff; cursor: pointer;
        display: flex; align-items: center; justify-content: space-between;
    }
    .custom-select-trigger::after {
        content: ''; width: 0; height: 0; border-left: 5px solid transparent; border-right: 5px solid transparent; border-top: 5px solid #666;
    }
    .custom-options-box {
        position: absolute; display: none; top: 43px; left: 0; right: 0;
        background: #ffffff; border: 1px solid #ccc; border-radius: 4px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15); max-height: 240px; overflow-y: auto; z-index: 9999;
    }
    .custom-option { padding: 10px 12px; cursor: pointer; font-size: 14px; color: #333; }
    .custom-option:hover { background-color: #f0f4f8; color: #0066cc; }

    /* ボタンとメッセージ */
    .submit-btn { background-color: #0066cc; color: white; border: none; padding: 12px 28px; border-radius: 4px; cursor: pointer; font-size: 15px; font-weight: bold; transition: background-color 0.2s; }
    .submit-btn:hover { background-color: #0052a3; }
    .alert-message { padding: 15px; background-color: #e3f2fd; color: #0d47a1; border-left: 5px solid #2196f3; margin-bottom: 25px; border-radius: 4px; font-weight: bold; font-size: 14px; }
</style>
</head>
<body>

<jsp:include page="../header.jsp" />

<div class="system-layout">
    <div class="side-menu">
        <jsp:include page="/tag.jsp" />
    </div>

    <main class="main-content">
        <div class="search-title">エラーナレッジ共有・投稿</div>

        <%-- 投稿完了時などのメッセージ表示エリア --%>
        <% String message = (String) request.getAttribute("message");
           if (message != null && !message.isEmpty()) { %>
            <div class="alert-message"><%= message %></div>
        <% } %>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/ErrorPostExecute.action" method="post">
                
                <%-- 1. 対象授業（★JavaScriptで真下にだけ開くカスタムドロップダウンに修正） --%>
                <div class="form-group-block">
                    <label class="form-label-block">① 対象の授業（科目） <span style="color:red;">*</span></label>
                    <div class="custom-select-wrapper">
                        <!-- 画面に見える選択用のボックス -->
                        <div class="custom-select-trigger" id="selectTrigger">-- 科目を選択してください --</div>
                        
                        <!-- 💡 必ず下に開く白い選択肢リスト（最大240pxでスクロール可能） -->
                        <div class="custom-options-box" id="optionsBox">
                            <% List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjects");
                               if (subjectList != null) { for (Map<String, String> sub : subjectList) { %>
                                <div class="custom-option" data-value="<%= sub.get("cd") %>"><%= sub.get("name") %></div>
                            <% } } %>
                        </div>
                        
                        <!-- 実際にサーバーに送信される隠し入力欄 -->
                        <input type="hidden" name="subjectCd" id="hiddenSubjectCd" required />
                    </div>
                </div>

                <%-- 2. 単元名 --%>
                <div class="form-group-block">
                    <label class="form-label-block">② 授業の単元・章 <span style="color:red;">*</span></label>
                    <input type="text" name="unitName" class="form-input-text" placeholder="例：第4章 ループ処理、配列の演習、など" required />
                </div>

                <%-- 3. エラーの概要 --%>
                <div class="form-group-block">
                    <label class="form-label-block">③ エラー名・現象の概要 <span style="color:red;">*</span></label>
                    <input type="text" name="errorTitle" class="form-input-text" placeholder="例：NullPointerException が発生する、画面が真っ白になる" required />
                </div>

                <%-- 4. エラーの詳しい状況 --%>
                <div class="form-group-block">
                    <label class="form-label-block">④ エラーコード・詳しい状況</label>
                    <textarea name="errorDetail" class="form-textarea" placeholder="コンソールのエラーログや、どんな操作をした時に発生したかをメモ（空欄でもOK）"></textarea>
                </div>

                <%-- 5. 解決方法 --%>
                <div class="form-group-block">
                    <label class="form-label-block">⑤ 解決方法・対処手順 <span style="color:red;">*</span></label>
                    <textarea name="solution" class="form-textarea" style="height: 180px;" placeholder="例：変数の初期化を忘れていたため、インスタンス化を行ったら直った。修正前と修正後のコードなど" required></textarea>
                </div>

                <%-- 送信ボタン --%>
                <div style="text-align: right; margin-top: 25px;">
                    <button type="submit" class="submit-btn">この解決方法を投稿する</button>
                </div>
            </form>
        </div>
    </main>
</div>

<%-- 💡【重要】ドロップダウンの開閉・値のセットを制御する軽量JavaScript --%>
<script>
    const trigger = document.getElementById('selectTrigger');
    const box = document.getElementById('optionsBox');
    const hiddenInput = document.getElementById('hiddenSubjectCd');

    // クリックしたら真下のリストを開閉する
    trigger.addEventListener('click', function(e) {
        e.stopPropagation();
        box.style.display = (box.style.display === 'block') ? 'none' : 'block';
    });

    // 選択肢をクリックしたときの処理
    document.querySelectorAll('.custom-option').forEach(option => {
        option.addEventListener('click', function() {
            const value = this.getAttribute('data-value'); // 科目コード(A01など)
            const text = this.textContent;                // 科目名(AWSなど)
            
            trigger.textContent = text;        // 見た目の文字を科目名に変える
            hiddenInput.value = value;         // 隠し入力欄にコードをセット
            box.style.display = 'none';        // リストを閉じる
        });
    });

    // 画面の他の場所をクリックしたら閉じる
    document.addEventListener('click', function() {
        box.style.display = 'none';
    });
</script>

</body>
</html>
