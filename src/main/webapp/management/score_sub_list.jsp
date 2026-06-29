<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        .grade-criteria-box { display: flex; align-items: center; background-color: #f8f9fa; border: 1px solid #e0e0e0; border-radius: 4px; padding: 10px 15px; margin-top: 20px; font-size: 13px; color: #555; }
        .criteria-title { font-weight: bold; margin-right: 15px; border-right: 2px solid #ccc; padding-right: 15px; color: #333; }
        .criteria-item { margin-right: 20px; display: flex; align-items: center; }
        .badge-red { color: red; font-weight: bold; }
        .badge-blue { color: #0066cc; font-weight: bold; }
        .score-cell-danger { background-color: #ffeaea !important; }
        .average-row { background-color: #f1f3f5; font-weight: bold; border-top: 2px solid #adb5bd; }
        .max-row td, .min-row td { border-top: 1px solid #eee; }
        .filter-btn-group button { padding: 5px 15px; cursor: pointer; background: #ffffff; border: 1px solid #cccccc; border-radius: 4px; font-size: 13px; transition: background 0.2s; }
        .filter-btn-group button:hover { background: #f0f0f0; }
        .graph-container { margin-top: 25px; padding: 20px; background-color: #f8f9fa; border: 1px solid #e0e0e0; border-radius: 4px; max-width: 950px; }
        .graph-title { font-weight: bold; font-size: 14px; color: #333; margin-bottom: 15px; border-left: 4px solid #0066cc; padding-left: 10px; }
        .graph-row { display: flex; align-items: center; margin-bottom: 10px; font-size: 13px; }
        .graph-label { width: 60px; font-weight: bold; }
        .graph-bar-wrap { flex: 1; background-color: #e9ecef; border-radius: 3px; height: 16px; margin-right: 15px; max-width: 400px; }
        .graph-bar { height: 100%; border-radius: 3px; transition: width 0.3s; }
        .graph-count { width: 40px; color: #666; }
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
                        <% 
                            List<String> entYearList = (List<String>) request.getAttribute("entYearList");
                            if (entYearList != null) { 
                                for (String year : entYearList) { 
                        %>
                            <option value="<%= year %>" <%= entYear.equals(year) ? "selected" : "" %>><%= year %></option>
                        <% 
                                } 
                            } 
                        %>
                    </select>
                </div>
                <div class="form-group form-margin">
                    <label class="form-label">クラス</label>
                    <select name="classNum" class="form-select">
                        <option value="" <%= classNum.equals("") ? "selected" : "" %>>--------</option>
                        <% 
                            List<String> classNumList = (List<String>) request.getAttribute("classNumList");
                            if (classNumList != null) { 
                                for (String clazz : classNumList) { 
                        %>
                            <option value="<%= clazz %>" <%= classNum.equals(clazz) ? "selected" : "" %>><%= clazz %></option>
                        <% 
                                } 
                            } 
                        %>
                    </select>
                </div>
                
                <div class="form-group form-margin">
                    <label class="form-label">学年</label>
                    <select name="grade" class="form-select">
                        <option value="" <%= gradeStr.equals("") ? "selected" : "" %>>--------</option>
                        <% 
                            if (gradeList != null) { 
                                for (String g : gradeList) { 
                        %>
                            <option value="<%= g %>" <%= gradeStr.equals(g) ? "selected" : "" %>><%= g %>年</option>
                        <% 
                                } 
                            } 
                        %>
                    </select>
                </div>

                <div class="form-group form-group-wide form-margin">
                    <label class="form-label">科目</label>
                    <select name="subjectCd" class="form-select" style="width: 250px;">
                        <option value="" <%= subjectCd.equals("") ? "selected" : "" %>>--------</option>
                        <% 
                            List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjects");
                            if (subjectList != null) { 
                                for (Map<String, String> sub : subjectList) { 
                        %>
                            <option value="<%= sub.get("cd") %>" <%= subjectCd.equals(sub.get("cd")) ? "selected" : "" %>><%= sub.get("name") %></option>
                        <% 
                                } 
                            } 
                        %>
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

            <!-- 3行目：評価情報（絞り込み） -->
            <div class="search-section">
                <div class="section-title">評価情報</div>
                <div class="form-group filter-btn-group" style="display: flex !important; flex-direction: row !important; align-items: center !important; gap: 8px !important; width: auto !important;">
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
                    int total1 = 0; int count1 = 0;
                    int total2 = 0; int count2 = 0;
                    
                    int yu1 = 0; int ryo1 = 0; int ka1 = 0; int aka1 = 0; int totalCount1 = 0;
                    int yu2 = 0; int ryo2 = 0; int ka2 = 0; int aka2 = 0; int totalCount2 = 0;

                    if (scoreDisplayList != null) {
                        for (Map<String, Object> row : scoreDisplayList) { 
                            Object score1Obj = row.get("score1");
                            String judgeStr1 = "-";
                            String judgeStyle1 = "color: #333;";
                            int s1Val = -1;
                            
                            if (score1Obj != null) {
                                try {
                                    s1Val = Integer.parseInt(score1Obj.toString());
                                    total1 += s1Val;
                                    count1++;
                                    if (s1Val < 40) { judgeStr1 = "赤点"; judgeStyle1 = "color: red; font-weight: bold;"; aka1++; }
                                    else if (s1Val < 60) { judgeStr1 = "可"; ka1++; }
                                    else if (s1Val < 80) { judgeStr1 = "良"; ryo1++; }
                                    else { judgeStr1 = "優"; judgeStyle1 = "color: #0066cc; font-weight: bold;"; yu1++; }
                                    totalCount1++; 
                                } catch (NumberFormatException e) {}
                            }

                            Object score2Obj = row.get("score2");
                            String judgeStr2 = "-";
                            String judgeStyle2 = "color: #333;";
                            int s2Val = -1;
                            
                            if (score2Obj != null) {
                                try {
                                    s2Val = Integer.parseInt(score2Obj.toString());
                                    total2 += s2Val;
                                    count2++;
                                    if (s2Val < 40) { judgeStr2 = "赤点"; judgeStyle2 = "color: red; font-weight: bold;"; aka2++; }
                                    else if (s2Val < 60) { judgeStr2 = "可"; ka2++; }
                                    else if (s2Val < 80) { judgeStr2 = "良"; ryo2++; }
                                    else { judgeStr2 = "優"; judgeStyle2 = "color: #0066cc; font-weight: bold;"; yu2++; }
                                    totalCount2++; 
                                } catch (NumberFormatException e) {}
                            }
                %>
                
                <tr class="student-data-row">
                    <td><%= row.get("entYear") != null ? row.get("entYear").toString() : "-" %></td>
                    <td><%= row.get("classNum") != null ? row.get("classNum").toString() : "-" %></td>
                    <td><%= row.get("studentId") != null ? row.get("studentId").toString() : "-" %></td>
                    <td style="text-align: left; padding-left: 20px;"><%= row.get("studentName") != null ? row.get("studentName").toString() : "未登録" %></td>
                    <td><%= row.get("grade") != null ? row.get("grade").toString() + "年" : "-" %></td>
                    
                    <td class="<%= (s1Val != -1 && s1Val < 40) ? "score-cell-danger" : "" %>">
                        <%= score1Obj != null ? score1Obj.toString() : "-" %>
                    </td>
                    <td class="judge1" style="<%= judgeStyle1 %>"><%= judgeStr1 %></td>
                    
                    <td class="<%= (s2Val != -1 && s2Val < 40) ? "score-cell-danger" : "" %>">
                        <%= score2Obj != null ? score2Obj.toString() : "-" %>
                    </td>
                    <td class="judge2" style="<%= judgeStyle2 %>"><%= judgeStr2 %></td>
                </tr>
                
                <% 
                        } // 学生ループの終了
                    } // if文の終了
                    
                    double avg1 = count1 > 0 ? (double) total1 / count1 : 0.0;
                    double avg2 = count2 > 0 ? (double) total2 / count2 : 0.0;
                    
                    String avgStr1 = count1 > 0 ? String.format("%.1f", avg1) + "点" : "-";
                    String avgStr2 = count2 > 0 ? String.format("%.1f", avg2) + "点" : "-";
                    
                    String countStr1 = count1 > 0 ? count1 + "人" : "0人";
                    String countStr2 = count2 > 0 ? count2 + "人" : "0人";

                    int max1 = -1, min1 = 101;
                    int max2 = -1, min2 = 101;

                    if (scoreDisplayList != null) {
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
                    }

                    String maxStr1 = max1 != -1 ? max1 + "点" : "-";
                    String minStr1 = min1 != 101 ? min1 + "点" : "-";
                    String maxStr2 = max2 != -1 ? max2 + "点" : "-";
                    String minStr2 = min2 != 101 ? min2 + "点" : "-";
                %>
                
                <!-- 平均点表示 -->
                <tr class="average-row">
                    <td colspan="5" style="text-align: left; padding-left: 20px; font-weight: bold; background-color: #f1f3f5; color: #555;">
                        平均点 <span style="font-size: 14px; margin-left: 20px; color: #666; font-weight: normal;">( 受験人数 1回目：<%= countStr1 %> &nbsp;&nbsp; 2回目：<%= countStr2 %> )</span>
                    </td>
                    <td style="font-weight: bold; background-color: #f1f3f5;"><%= avgStr1 %></td>
                    <td style="background-color: #f1f3f5;"></td>
                    <td style="font-weight: bold; background-color: #f1f3f5;"><%= avgStr2 %></td>
                    <td style="background-color: #f1f3f5;"></td>
                </tr>

                <!-- 最高得点 -->
                <tr class="max-row">
                    <td colspan="5" style="text-align: right; padding-right: 20px; font-weight: bold; background-color: #ffffff; color: #555;">最高得点</td>
                    <td style="font-weight: bold; background-color: #ffffff; color: #0066cc;"><%= maxStr1 %></td>
                    <td style="background-color: #ffffff;"></td>
                    <td style="font-weight: bold; background-color: #ffffff; color: #0066cc;"><%= maxStr2 %></td>
                    <td style="background-color: #ffffff;"></td>
                </tr>

                <!-- 最低得点 -->
                <tr class="min-row">
                    <td colspan="5" style="text-align: right; padding-right: 20px; font-weight: bold; background-color: #ffffff; color: #555;">最低得点</td>
                    <td style="font-weight: bold; background-color: #ffffff; color: #cc0000;"><%= minStr1 %></td>
                    <td style="background-color: #ffffff;"></td>
                    <td style="font-weight: bold; background-color: #ffffff; color: #cc0000;"><%= minStr2 %></td>
                    <td style="background-color: #ffffff;"></td>
                </tr>
                </tbody>
            </table>
            
            <!-- 評価別の人数分布グラフ -->
            <div class="graph-container">
                <div class="graph-title">評価別の人数分布グラフ</div>
                <div style="display: flex; gap: 40px; flex-wrap: wrap;">
                    <div style="flex: 1; min-width: 300px;">
                        <div style="font-weight: bold; margin-bottom: 10px; color: #555; font-size: 13px;">【 1回目テスト 】</div>
                        <div class="graph-row"><div class="graph-label" style="color: #0066cc;">優</div><div class="graph-bar-wrap"><div class="graph-bar" style="width: <%= totalCount1 > 0 ? (yu1 * 100 / totalCount1) : 0 %>%; background-color: #0066cc;"></div></div><div class="graph-count"><%= yu1 %>人</div></div>
                   <!-- 💡追加：1回目と2回目の簡易ミニグラフ表示エリア -->
            <div class="graph-container">
                <div class="graph-title">評価別の人数分布グラフ</div>
                <div style="display: flex; gap: 40px; flex-wrap: wrap;">
                    <!-- 左側：1回目のグラフ -->
                    <div style="flex: 1; min-width: 300px;">
                        <div style="font-weight: bold; margin-bottom: 10px; color: #555; font-size: 13px;">【 1回目テスト 】</div>
                        <div class="graph-row"><div class="graph-label" style="color: #0066cc;">優</div><div class="graph-bar-wrap"><div class="graph-bar" style="width: <%= totalCount1 > 0 ? (yu1 * 100 / totalCount1) : 0 %>%; background-color: #0066cc;"></div></div><div class="graph-count"><%= yu1 %>人</div></div>
                        <div class="graph-row"><div class="graph-label">良</div><div class="graph-bar-wrap"><div class="graph-bar" style="width: <%= totalCount1 > 0 ? (ryo1 * 100 / totalCount1) : 0 %>%; background-color: #28a745;"></div></div><div class="graph-count"><%= ryo1 %>人</div></div>
                        <div class="graph-row"><div class="graph-label">可</div><div class="graph-bar-wrap"><div class="graph-bar" style="width: <%= totalCount1 > 0 ? (ka1 * 100 / totalCount1) : 0 %>%; background-color: #ffc107;"></div></div><div class="graph-count"><%= ka1 %>人</div></div>
                        <div class="graph-row"><div class="graph-label" style="color: red;">赤点</div><div class="graph-bar-wrap"><div class="graph-bar" style="width: <%= totalCount1 > 0 ? (aka1 * 100 / totalCount1) : 0 %>%; background-color: red;"></div></div><div class="graph-count"><%= aka1 %>人</div></div>
                    </div>
                    <!-- 右側：2回目のグラフ -->
                    <div style="flex: 1; min-width: 300px;">
                        <div style="font-weight: bold; margin-bottom: 10px; color: #555; font-size: 13px;">【 2回目テスト 】</div>
                        <div class="graph-row"><div class="graph-label" style="color: #0066cc;">優</div><div class="graph-bar-wrap"><div class="graph-bar" style="width: <%= totalCount2 > 0 ? (yu2 * 100 / totalCount2) : 0 %>%; background-color: #0066cc;"></div></div><div class="graph-count"><%= yu2 %>人</div></div>
                        <div class="graph-row"><div class="graph-label">良</div><div class="graph-bar-wrap"><div class="graph-bar" style="width: <%= totalCount2 > 0 ? (ryo2 * 100 / totalCount2) : 0 %>%; background-color: #28a745;"></div></div><div class="graph-count"><%= ryo2 %>人</div></div>
                        <div class="graph-row"><div class="graph-label">可</div><div class="graph-bar-wrap"><div class="graph-bar" style="width: <%= totalCount2 > 0 ? (ka2 * 100 / totalCount2) : 0 %>%; background-color: #ffc107;"></div></div><div class="graph-count"><%= ka2 %>人</div></div>
                        <div class="graph-row"><div class="graph-label" style="color: red;">赤点</div><div class="graph-bar-wrap"><div class="graph-bar" style="width: <%= totalCount2 > 0 ? (aka2 * 100 / totalCount2) : 0 %>%; background-color: red;"></div></div><div class="graph-count"><%= aka2 %>人</div></div>
                    </div>
                </div>
            </div>
            
        <% } else if (scoreDisplayList != null && scoreDisplayList.isEmpty()) { %>
            <div class="initial-message">該当する成績データが見つかりませんでした。</div>
        <% } else { %>
            <div class="initial-message">科目情報を選択または学生情報を入力して検索ボタンをクリックしてください</div>
        <% } %>
    </main>
</div>

<script>
function filterGradeSub(targetGrade) {
    var timing = document.getElementById('filterTiming').value;
    var thList = document.querySelectorAll('.score-edit-table th');
    if (thList.length >= 9) {
        thList[5].style.display = (timing === 'second') ? 'none' : '';
        thList[6].style.display = (timing === 'second') ? 'none' : '';
        thList[7].style.display = (timing === 'first') ? 'none' : '';
        thList[8].style.display = (timing === 'first') ? 'none' : '';
    }

    var statRows = document.querySelectorAll('.score-edit-table tbody tr:not(.student-data-row)');
    statRows.forEach(function(row) {
        var tds = row.querySelectorAll('td');
        if (tds.length >= 5) {
            tds[1].style.display = (timing === 'second') ? 'none' : '';
            tds[2].style.display = (timing === 'second') ? 'none' : '';
            tds[3].style.display = (timing === 'first') ? 'none' : '';
            tds[4].style.display = (timing === 'first') ? 'none' : '';
            tds[0].colSpan = 5; 
        }
    });

    var rows = document.querySelectorAll('.score-edit-table tbody tr.student-data-row');
    rows.forEach(function(row) {
        var judge1Td = row.querySelector('.judge1');
        var judge2Td = row.querySelector('.judge2');
        var score1Td = judge1Td ? judge1Td.previousElementSibling : null;
        var score2Td = judge2Td ? judge2Td.previousElementSibling : null;
        
        if (score1Td) score1Td.style.display = (timing === 'second') ? 'none' : '';
        if (judge1Td) judge1Td.style.display = (timing === 'second') ? 'none' : '';
        if (score2Td) score2Td.style.display = (timing === 'first') ? 'none' : '';
        if (judge2Td) judge2Td.style.display = (timing === 'first') ? 'none' : '';

        var grade1 = judge1Td ? judge1Td.textContent.trim() : "";
        var grade2 = judge2Td ? judge2Td.textContent.trim() : "";
        
        if (targetGrade === 'all') {
            row.style.display = '';
            return;
        }
        
        var match = false;
        if (timing === 'either') {
            match = (grade1 === targetGrade || grade2 === targetGrade);
        } else if (timing === 'both') {
            match = (grade1 === targetGrade && grade2 === targetGrade);
        } else if (timing === 'first') {
            match = (grade1 === targetGrade);
        } else if (timing === 'second') {
            match = (grade2 === targetGrade);
        }
        
        if (match) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}
</script>
</body>
</html>
       
