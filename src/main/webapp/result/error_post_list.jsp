<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>エラー解決の検索 - 得点管理システム</title>
<style>
    /* 全体と基本のレイアウト */
    body { font-family: "Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN", "Hiragino Sans", Meiryo, sans-serif; margin: 0; padding: 0; background-color: #f4f6f9; color: #333; }
    .system-layout { display: flex; width: 100%; min-height: 100vh; }
    .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; padding-top: 20px; box-sizing: border-box; }
    .main-content { flex: 1; padding: 30px; box-sizing: border-box; }
    
    /* タイトル */
    .search-title { font-size: 24px; font-weight: bold; margin-bottom: 25px; color: #222; border-bottom: 2px solid #0066cc; padding-bottom: 10px; }
    
    /* 💡 検索フォーム専用のスタイル（横並び） */
    .search-bar-container { background-color: #ffffff; padding: 20px; border-radius: 8px; border: 1px solid #e0e0e0; box-shadow: 0 2px 8px rgba(0,0,0,0.05); margin-bottom: 30px; display: flex; gap: 20px; align-items: flex-end; }
    .search-group { flex: 1; display: flex; flex-direction: column; gap: 8px; }
    .search-label { font-weight: bold; font-size: 14px; color: #444; }
    .search-input-text { width: 100%; height: 42px; padding: 0 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 14px; background-color: #fff; }
    .search-btn { background-color: #0066cc; color: white; border: none; padding: 0 25px; height: 42px; border-radius: 4px; cursor: pointer; font-size: 15px; font-weight: bold; transition: background-color 0.2s; }
    .search-btn:hover { background-color: #0052a3; }

    /* 💡 カスタムドロップダウン用のスタイル（安全な下向き展開） */
    .custom-select-wrapper { position: relative; width: 100%; }
    .custom-select-trigger { 
        width: 100%; height: 42px; padding: 0 12px; border: 1px solid #ccc; border-radius: 4px; 
        box-sizing: border-box; font-size: 14px; background-color: #fff; cursor: pointer;
        display: flex; align-items: center; justify-content: space-between;
    }
    .custom-select-trigger::after { content: ''; width: 0; height: 0; border-left: 5px solid transparent; border-right: 5px solid transparent; border-top: 5px solid #666; }
    .custom-options-box {
        position: absolute; display: none; top: 43px; left: 0; right: 0;
        background: #ffffff; border: 1px solid #ccc; border-radius: 4px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15); max-height: 200px; overflow-y: auto; z-index: 9999;
    }
    .custom-option { padding: 10px 12px; cursor: pointer; font-size: 14px; color: #333; }
    .custom-option:hover { background-color: #f0f4f8; color: #0066cc; }

    /* 💡 エラー一覧（アコーディオン）用のスタイル */
    .post-card { background: #ffffff; border: 1px solid #e0e0e0; border-radius: 6px; margin-bottom: 15px; overflow: hidden; box-shadow: 0 2px 4px rgba(0,0,0,0.02); }
    .post-header { padding: 15px 20px; background: #ffffff; cursor: pointer; display: flex; justify-content: space-between; align-items: center; transition: background-color 0.2s; }
    .post-header:hover { background-color: #f8fafd; }
    .post-meta-info { display: flex; gap: 15px; align-items: center; margin-bottom: 5px; }
    .badge-subject { background: #e3f2fd; color: #0d47a1; padding: 3px 8px; border-radius: 4px; font-size: 11px; font-weight: bold; }
    .text-unit { font-size: 12px; color: #666; font-weight: bold; }
    .post-title-text { font-size: 16px; font-weight: bold; color: #222; }
    .arrow-icon { font-size: 14px; color: #888; transition: transform 0.2s; }
    
    /* アコーディオンの中身（初期状態は非表示） */
    .post-body { display: none; padding: 20px; background: #fafafa; border-top: 1px solid #eee; }
    .content-block { margin-bottom: 15px; }
    .content-block:last-child { margin-bottom: 0; }
    .content-label { font-weight: bold; font-size: 13px; color: #0066cc; margin-bottom: 5px; }
    .content-text { font-size: 14px; line-height: 1.6; white-space: pre-wrap; background: #fff; padding: 12px; border: 1px solid #eaeaea; border-radius: 4px; }
    .no-data-message { text-align: center; color: #999; padding: 40px; font-size: 15px; background: #fff; border-radius: 8px; border: 1px dashed #ccc; }
</style>
</head>
<body>

<jsp:include page="../header.jsp" />

<div class="system-layout">
    <div class="side-menu">
        <jsp:include page="/tag.jsp" />
    </div>

    <main class="main-content">
        <div class="search-title">エラーナレッジ共有・検索</div>

        <%-- 🔍 検索フォームエリア --%>
        <form action="${pageContext.request.contextPath}/ErrorPostList.action" method="get" class="search-bar-container">
            
            <%-- 検索条件1：科目プルダウン（カスタムボックス版） --%>
            <div class="search-group" style="max-width: 250px;">
                <label class="search-label">授業（科目）</label>
                <div class="custom-select-wrapper">
                    <%-- 初期テキストのロジック（JSP側で選択キープ） --%>
                    <% 
                        String selectedSubject = (String) request.getAttribute("selectedSubject");
                        String selectedKeyword = (String) request.getAttribute("selectedKeyword");
                        if (selectedSubject == null) selectedSubject = "";
                        if (selectedKeyword == null) selectedKeyword = "";
                        
                        List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjects");
                        String triggerText = "-- すべての科目 --";
                        if (subjectList != null) {
                            for (Map<String, String> sub : subjectList) {
                                if (sub.get("cd").equals(selectedSubject)) {
                                    triggerText = sub.get("name");
                                    break;
                                }
                            }
                        }
                    %>
                    <div class="custom-select-trigger" id="selectTrigger"><%= triggerText %></div>
                    <div class="custom-options-box" id="optionsBox">
                        <div class="custom-option" data-value="">-- すべての科目 --</div>
                        <% if (subjectList != null) { for (Map<String, String> sub : subjectList) { %>
                            <div class="custom-option" data-value="<%= sub.get("cd") %>"><%= sub.get("name") %></div>
                        <% } } %>
                    </div>
                    <input type="hidden" name="subjectCd" id="hiddenSubjectCd" value="<%= selectedSubject %>" />
                </div>
            </div>

            <%-- 検索条件2：キーワード入力 --%>
            <div class="search-group">
                <label class="search-label">キーワード検索</label>
                <input type="text" name="keyword" class="search-input-text" placeholder="エラー名、単元名、解決策などのキーワードを入力..." value="<%= selectedKeyword %>" />
            </div>

            <%-- 検索ボタン --%>
            <button type="submit" class="search-btn">検索する</button>
        </form>

        <%-- 📋 検索結果一覧エリア --%>
        <div class="results-container">
            <% 
                List<Map<String, Object>> errorPosts = (List<Map<String, Object>>) request.getAttribute("errorPosts");
                if (errorPosts != null && !errorPosts.isEmpty()) { 
                    for (Map<String, Object> post : errorPosts) {
            %>
                        <div class="post-card">
                            <!-- クリックで開閉するヘッダー部分 -->
                            <div class="post-header" onclick="toggleAccordion(this)">
                                <div>
                                    <div class="post-meta-info">
                                        <span class="badge-subject"><%= post.get("subject_name") != null ? post.get("subject_name") : "共通" %></span>
                                        <span class="text-unit"><%= post.get("unit_name") %></span>
                                    </div>
                                    <div class="post-title-text"><%= post.get("error_title") %></div>
                                </div>
                                <div class="arrow-icon">▼</div>
                            </div>
                            
                            <!-- パッと開く解決策の中身部分 -->
                            <div class="post-body">
                                <% if (post.get("error_detail") != null && !post.get("error_detail").toString().trim().isEmpty()) { %>
                                    <div class="content-block">
                                        <div class="content-label">【エラーの詳しい状況・ログ】</div>
                                        <div class="content-text"><%= post.get("error_detail") %></div>
                                    </div>
                                <% } %>
                                <div class="content-block">
                                    <div class="content-label">【💡 解決方法・対処手順】</div>
                                    <div class="content-text" style="border-left: 4px solid #0066cc; background: #fbfcfe;"><%= post.get("solution") %></div>
                                </div>
                            </div>
                        </div>
            <% 
                    } 
                } else { 
            %>
                <div class="no-data-message">該当するエラー解決ナレッジが見つかりませんでした。</div>
            <% } %>
        </div>
    </main>
</div>

<%-- 💡【対策版】ドロップダウンおよびアコーディオンを確実に制御するスクリプト --%>
<script>
    // 💡 画面のHTML（DOM）が完全に読み込まれてから安全に実行する設定にします
    document.addEventListener("DOMContentLoaded", function() {
        
        // 1. プルダウンの開閉制御
        const trigger = document.getElementById('selectTrigger');
        const box = document.getElementById('optionsBox');
        const hiddenInput = document.getElementById('hiddenSubjectCd');

        // 要素が正しく取得できている場合のみイベントを設定する（エラー防止）
        if (trigger && box) {
            trigger.addEventListener('click', function(e) {
                e.stopPropagation();
                // 表示・非表示を確実に切り替える
                if (box.style.display === 'block') {
                    box.style.display = 'none';
                } else {
                    box.style.display = 'block';
                }
            });
        }

        // 選択肢をクリックしたときの処理
        document.querySelectorAll('.custom-option').forEach(option => {
            option.addEventListener('click', function() {
                const value = this.getAttribute('data-value');
                const text = this.textContent;
                if (trigger) trigger.textContent = text;
                if (hiddenInput) hiddenInput.value = value;
                if (box) box.style.display = 'none';
            });
        });

        // 選択肢の外側（画面のどこか）をクリックしたら閉じる
        document.addEventListener('click', function() {
            if (box) box.style.display = 'none';
        });
    });

    // 2. アコーディオン（解決策の開閉）制御（※これはトリガーから直接呼ばれるのでイベント外に配置）
    function toggleAccordion(headerElement) {
        const card = headerElement.parentElement;
        const body = card.querySelector('.post-body');
        const arrow = card.querySelector('.arrow-icon');
        
        if (body.style.display === 'block') {
            body.style.display = 'none';
            if (arrow) arrow.style.transform = 'rotate(0deg)';
        } else {
            body.style.display = 'block';
            if (arrow) arrow.style.transform = 'rotate(180deg)';
        }
    }
</script>
