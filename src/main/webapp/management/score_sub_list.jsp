<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="google" content="notranslate">
<title>得点管理システム</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
<style>
    .system-layout { display: flex; width: 100%; min-height: 100vh; }
    .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; padding-top: 20px; }
    .main-content { flex: 1; padding: 30px; }

    .search-section { display: flex; align-items: center; padding: 15px 0; }
    .search-section-border { border-bottom: 1px dashed #ddd; }
    .section-title { width: 100px; font-weight: bold; color: #666; }
    .form-margin { margin-right: 15px; }
    .input-student-id { width: 230px; background: #fff; border: 1px solid #ccc; border-radius: 4px; padding: 4px 8px; box-sizing: border-box; }
    .initial-message { text-align: center; color: #999; margin-top: 20px; }

    .grade-criteria-box {
        display: flex;
        align-items: center;
        background-color: #f8f9fa;
        border: 1px solid #e0e0e0;
        border-radius: 4px;
        padding: 10px 15px;
        margin-top: 20px;
        font-size: 13px;
        color: #555;
    }
    .criteria-title {
        font-weight: bold;
        margin-right: 15px;
        border-right: 2px solid #ccc;
        padding-right: 15px;
        color: #333;
    }
    .criteria-item {
        margin-right: 20px;
        display: flex;
        align-items: center;
    }
    .badge-red { color: red; font-weight: bold; }
    .badge-blue { color: #0066cc; font-weight: bold; }

    /* 赤点のマス目だけを薄い赤（ピンク）にするスタイル */
    .score-cell-danger {
        background-color: #ffeaea !important;
    }
    .average-row { background-color: #f1f3f5; font-weight: bold; border-top: 2px solid #adb5bd; }
    .max-row td, .min-row td { border-top: 1px solid #eee; }

    /* 💡追加：評価絞り込みボタン用の統一スタイル */
    .filter-btn-group button {
        padding: 5px 15px;
        cursor: pointer;
        background: #ffffff;
        border: 1px solid #cccccc;
        border-radius: 4px;
        font-size: 13px;
        transition: background 0.2s;
    }
    .filter-btn-group button:hover {
        background: #f0f0f0;
    }
</style>
</head>
<body>

<%
String entYear = (String) request.getAttribute("selectedYear");
String classNum = (String) request.getAttribute("selectedClass");
String subjectCd = (String) request.getAttribute("selectedSubjectCd");
String studentId = (String) request.getAttribute("selectedStudentId");
String gradeStr = (String) request.getAttribute("selectedGrade");

if (entYear == null) entYear = "";
if (classNum == null) classNum = "";
if (subjectCd == null) subjectCd = "";
if (studentId == null) studentId = "";
if (gradeStr == null) gradeStr = "";

String selectedSubjectName = (String) request.getAttribute("selectedSubjectName");
List<Map<String, Object>> scoreDisplayList = (List<Map<String, Object>>) request.getAttribute("scoreDisplayList");
List<String> gradeList = (List<String>) request.getAttribute("gradeList");
%>

<jsp:include page="../header.jsp" />

<div class="system-layout">
    <div class="side-menu">
        <jsp:include page="/tag.jsp" />
    </div>

    <main class="main-content">
        <div class="search-title">成績一覧（科目）</div>

        <form action="${pageContext.request.contextPath}/ScoreSubject.action" method="get" class="search-form">
            <!-- 1行目：科目情報 -->
            <div class="search-section search-section-border">
                <div class="section-title">科目情報</div>
                <div class="form-group form-margin">
                    <label class="form-label">入学年度</label>
                    <select name="entYear" class="form-select">
                        <option value="" <%= entYear.equals("") ? "selected" : "" %>>--------</option>
                        <% List<String> entYearList = (List<String>) request.getAttribute("entYearList");
                           if (entYearList != null) { for (String year : entYearList) { %>
                            <option value="<%= year %>" <%= entYear.equals(year) ? "selected" : "" %>><%= year %></option>
                        <% } } %>
                    </select>
                </div>
                <div class="form-group form-margin">
                    <label class="form-label">クラス</label>
                    <select name="classNum" class="form-select">
                        <option value="" <%= classNum.equals("") ? "selected" : "" %>>--------</option>
                        <% List<String> classNumList = (List<String>) request.getAttribute("classNumList");
                           if (classNumList != null) { for (String clazz : classNumList) { %>
                            <option value="<%= clazz %>" <%= classNum.equals(clazz) ? "selected" : "" %>><%= clazz %></option>
                        <% } } %>
                    </select>
                </div>
                
                <div class="form-group form-margin">
                    <label class="form-label">学年</label>
                    <select name="grade" class="form-select">
                        <option value="" <%= gradeStr.equals("") ? "selected" : "" %>>--------</option>
                        <% if (gradeList != null) { for (String g : gradeList) { %>
                            <option value="<%= g %>" <%= gradeStr.equals(g) ? "selected" : "" %>><%= g %>年</option>
                        <% } } %>
                    </select>
                </div>

                <div class="form-group form-group-wide form-margin">
                    <label class="form-label">科目</label>
                    <select name="subjectCd" class="form-select" style="width: 250px;">
                        <option value="" <%= subjectCd.equals("") ? "selected" : "" %>>--------</option>
                        <% List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjects");
                           if (subjectList != null) { for (Map<String, String> sub : subjectList) { %>
                            <option value="<%= sub.get("cd") %>" <%= subjectCd.equals(sub.get("cd")) ? "selected" : "" %>><%= sub.get("name") %></option>
                        <% } } %>
                    </select>
                </div>
                <button type="submit" class="search-btn">検索</button>
            </div>

            <!-- 2行目：学生情報 -->
            <div class="search-section search-section-border">
                <div class="section-title">学生情報</div>
                <div class="form-group">
                    <label class="form-label">学生番号</label>
                    <input type="text" name="studentId" value="<%= studentId %>" class="input-student-id">
                </div>
                <button type="submit" class="search-btn" style="margin-left: 20px;">検索</button>
            </div>

                         <!-- 💡3行目：評価情報（絞り込み）回数指定付き -->
            <div class="search-section">
                <div class="section-title">評価情報</div>
                <div class="form-group filter-btn-group" style="display: flex !important; flex-direction: row !important; align-items: center !important; gap: 8px !important; width: auto !important;">
                    <!-- 対象回数を選択するプルダウンを追加 -->
                    <select id="filterTiming" style="padding: 5px 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 13px; margin-right: 5px;">
                        <option value="either">1回目か2回目のどちらか</option>
                        <option value="both">1回目と2回目の両方とも</option>
                        <option value="first">1回目だけ</option>
                        <option value="second">2回目だけ</option>
                    </select>
                    
                    <button type="button" onclick="filterGradeSub('all')">すべて</button>
                    <button type="button" onclick="filterGradeSub('優')" style="color: #0066cc; font-weight: bold;">優</button>
                    <button type="button" onclick="filterGradeSub('良')">良</button>
                    <button type="button" onclick="filterGradeSub('可')">可</button>
                    <button type="button" onclick="filterGradeSub('赤点')" style="color: red; font-weight: bold;">赤点</button>
                </div>
            </div>
             
           </form>

        <% if (selectedSubjectName != null && !selectedSubjectName.isEmpty()) { %>
            <div class="subject-info-header" style="margin-top: 25px;">科目：<%= selectedSubjectName %></div>
        <% } %>
        <% if (scoreDisplayList != null && !scoreDisplayList.isEmpty()) { %>
            
            <!-- 評価基準の案内ボックス -->
            <div class="grade-criteria-box">
                <div class="criteria-title">評価基準</div>
                <div class="criteria-item"><span class="badge-red">赤点</span>：40点未満</div>
                <div class="criteria-item"><span>可</span>：40点〜59点</div>
                <div class="criteria-item"><span>良</span>：60点〜79点</div>
                <div class="criteria-item"><span class="badge-blue">優</span>：80点以上</div>
            </div>

            <table class="score-edit-table" style="margin-top: 15px;">
                <thead>
                    <tr>
                        <th>入学年度</th>
                        <th>クラス</th>
                        <th>学生番号</th>
                        <th style="text-align: left; padding-left: 20px;">氏名</th>
                        <th>学年</th>
                        <th>1回</th>
                        <th>1回判定</th>
                        <th>2回</th>
                        <th>2回判定</th>
                    </tr>
                </thead>
                <tbody>
                <% 
                // 平均点計算用の変数
                int total1 = 0;
                int count1 = 0;
                int total2 = 0;
                int count2 = 0;

                for (Map<String, Object> row : scoreDisplayList) { 
                    // --- 1回目の点数と判定の処理 ---
                    Object score1Obj = row.get("score1");
                    String judgeStr1 = "-";
                    String judgeStyle1 = "color: #333;";
                    
                    if (score1Obj != null) {
                        try {
                            int s1 = Integer.parseInt(score1Obj.toString());
                            total1 += s1;
                            count1++;

                            if (s1 < 40) { judgeStr1 = "赤点"; judgeStyle1 = "color: red; font-weight: bold;"; }
                            else if (s1 < 60) { judgeStr1 = "可"; }
                            else if (s1 < 80) { judgeStr1 = "良"; }
                            else { judgeStr1 = "優"; judgeStyle1 = "color: #0066cc; font-weight: bold;"; }
                        } catch (NumberFormatException e) {}
                    }

                    // --- 2回目の点数と判定の処理 ---
                    Object score2Obj = row.get("score2");
                    String judgeStr2 = "-";
                    String judgeStyle2 = "color: #333;";
                    
                    if (score2Obj != null) {
                        try {
                            int s2 = Integer.parseInt(score2Obj.toString());
                            total2 += s2;
                            count2++;

                            if (s2 < 40) { judgeStr2 = "赤点"; judgeStyle2 = "color: red; font-weight: bold;"; }
                            else if (s2 < 60) { judgeStr2 = "可"; }
                            else if (s2 < 80) { judgeStr2 = "良"; }
                            else { judgeStr2 = "優"; judgeStyle2 = "color: #0066cc; font-weight: bold;"; }
                        } catch (NumberFormatException e) {}
                    }
                %>
                <!-- データ行に 'student-data-row' クラスを追加 -->
                <tr class="student-data-row">
                    <td><%= row.get("entYear") != null ? row.get("entYear") : "-" %></td>
                    <td><%= row.get("classNum") %></td>
                    <td><%= row.get("studentId") %></td>
                    <td style="text-align: left; padding-left: 20px;"><%= row.get("studentName") %></td>
                    <td><%= row.get("grade") != null && (Integer)row.get("grade") > 0 ? row.get("grade") + "年" : "-" %></td>
                    
                    <!-- 1回目：赤点ならマス目だけをピンクにする -->
                    <td class="<%= "赤点".equals(judgeStr1) ? "score-cell-danger" : "" %>"><%= score1Obj != null ? score1Obj : "-" %></td>
                    <td class="judge1 <%= "赤点".equals(judgeStr1) ? "score-cell-danger" : "" %>" style="<%= judgeStyle1 %>"><%= judgeStr1 %></td>
                    
                    <!-- 2回目：赤点ならマス目だけをピンクにする -->
                    <td class="<%= "赤点".equals(judgeStr2) ? "score-cell-danger" : "" %>"><%= score2Obj != null ? score2Obj : "-" %></td>
                    <td class="judge2 <%= "赤点".equals(judgeStr2) ? "score-cell-danger" : "" %>" style="<%= judgeStyle2 %>"><%= judgeStr2 %></td>
                </tr>
                <% } 
                
                // 平均点の算出ロジック
                double avg1 = count1 > 0 ? (double) total1 / count1 : 0.0;
                double avg2 = count2 > 0 ? (double) total2 / count2 : 0.0;
                
                String avgStr1 = count1 > 0 ? String.format("%.1f", avg1) + "点" : "-";
                String avgStr2 = count2 > 0 ? String.format("%.1f", avg2) + "点" : "-";
                
                // 受験人数の表示用文字列
                String countStr1 = count1 > 0 ? count1 + "人" : "0人";
                String countStr2 = count2 > 0 ? count2 + "人" : "0人";

                // 最高点・最低点の取り出し処理
                int max1 = -1, min1 = 101;
                int max2 = -1, min2 = 101;

                for (Map<String, Object> row : scoreDisplayList) {
                    Object score1Obj = row.get("score1");
                    if (score1Obj != null) {
                        try {
                            int s1 = Integer.parseInt(score1Obj.toString());
                            if (s1 > max1) max1 = s1;
                            if (s1 < min1) min1 = s1;
                        } catch (NumberFormatException e) {}
                    }
                    Object score2Obj = row.get("score2");
                    if (score2Obj != null) {
                        try {
                            int s2 = Integer.parseInt(score2Obj.toString());
                            if (s2 > max2) max2 = s2;
                            if (s2 < min2) min2 = s2;
                        } catch (NumberFormatException e) {}
                    }
                }

                String maxStr1 = max1 != -1 ? max1 + "点" : "-";
                String minStr1 = min1 != 101 ? min1 + "点" : "-";
                String maxStr2 = max2 != -1 ? max2 + "点" : "-";
                String minStr2 = min2 != 101 ? min2 + "点" : "-";
                %>
                
                <!-- 1行目：平均点（受験人数含む） -->
                <tr class="average-row" style="border-top: 2px solid #adb5bd;">
                    <td colspan="5" style="text-align: left; padding-left: 20px; font-weight: bold; background-color: #f1f3f5; color: #555;">
                        平均点 <span style="font-size: 14px; margin-left: 20px; color: #666; font-weight: normal;">( 受験人数 1回目：<%= countStr1 %> &nbsp;&nbsp; 2回目：<%= countStr2 %> )</span>
                    </td>
                    <td style="font-weight: bold; background-color: #f1f3f5;"><%= avgStr1 %></td>
                    <td style="background-color: #f1f3f5;"></td>
                    <td style="font-weight: bold; background-color: #f1f3f5;"><%= avgStr2 %></td>
                    <td style="background-color: #f1f3f5;"></td>
                </tr>

                <!-- 2行目：最高得点行 -->
                <tr class="max-row">
                    <td colspan="5" style="text-align: right; padding-right: 20px; font-weight: bold; background-color: #ffffff; color: #555;">最高得点</td>
                    <td style="font-weight: bold; background-color: #ffffff; color: #0066cc;"><%= maxStr1 %></td>
                    <td style="background-color: #ffffff;"></td>
                    <td style="font-weight: bold; background-color: #ffffff; color: #0066cc;"><%= maxStr2 %></td>
                    <td style="background-color: #ffffff;"></td>
                </tr>

                <!-- 3行目：最低得点行 -->
                <tr class="min-row">
                    <td colspan="5" style="text-align: right; padding-right: 20px; font-weight: bold; background-color: #ffffff; color: #555;">最低得点</td>
                    <td style="font-weight: bold; background-color: #ffffff; color: #cc0000;"><%= minStr1 %></td>
                    <td style="background-color: #ffffff;"></td>
                    <td style="font-weight: bold; background-color: #ffffff; color: #cc0000;"><%= minStr2 %></td>
                    <td style="background-color: #ffffff;"></td>
                </tr>

                </tbody>
            </table>
        <% } else if (scoreDisplayList != null && scoreDisplayList.isEmpty()) { %>
            <div class="initial-message">該当する成績データが見つかりませんでした。</div>
        <% } else { %>
            <div class="initial-message">科目情報を選択または学生情報を入力して検索ボタンをクリックしてください</div>
        <% } %>
    </main>
</div>

<!-- 統計行に影響を与えず、学生データ行だけを絞り込む制御スクリプト -->
<script>
function filterGradeSub(targetGrade) {
    // 対象回数のプルダウンの選択値を取得 (either / both / first / second)
    var timing = document.getElementById('filterTiming').value;
    
    // 学生データ行だけを取得（平均点行などは除外）
    var rows = document.querySelectorAll('.score-edit-table tbody tr.student-data-row');
    
    rows.forEach(function(row) {
        var judge1Td = row.querySelector('.judge1');
        var judge2Td = row.querySelector('.judge2');
        
        var grade1 = judge1Td ? judge1Td.textContent.trim() : "";
        var grade2 = judge2Td ? judge2Td.textContent.trim() : "";
        
        // 「すべて」ボタンが押された場合は無条件で表示
        if (targetGrade === 'all') {
            row.style.display = '';
            return;
        }
        
        var match = false;
        
        // プルダウンの選択肢に応じた条件分岐
        if (timing === 'either') {
            // 1回目か2回目のどちらか片方でも一致すればOK
            match = (grade1 === targetGrade || grade2 === targetGrade);
        } else if (timing === 'both') {
            // 1回目と2回目の両方とも一致しなければダメ
            match = (grade1 === targetGrade && grade2 === targetGrade);
        } else if (timing === 'first') {
            // 1回目だけをチェック
            match = (grade1 === targetGrade);
        } else if (timing === 'second') {
            // 2回目だけをチェック
            match = (grade2 === targetGrade);
        }
        
        // 判定結果に合わせて表示・非表示を切り替え
        if (match) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

</script
</body>
</html>
        