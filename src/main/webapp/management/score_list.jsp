<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="google" content="notranslate">
    <title>得点管理システム</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: sans-serif; background-color: #ffffff; }

        .system-layout { display: flex; width: 100%; min-height: calc(100vh - 80px); }
        .side-menu { width: 220px; min-width: 220px; flex-shrink: 0; border-right: 1px solid #e0e0e0; background-color: #ffffff; }
        .main-content { flex: 1; padding: 30px; box-sizing: border-box; }

        .page-title { background-color: #f0f0f0; padding: 12px 25px; margin-bottom: 25px; width: 100%; max-width: 950px; }
        .page-title h2 { margin: 0; font-size: 26px; font-weight: bold; color: #333; }

        /* 評価基準（凡例）を表示するエリアのスタイル */
        .grade-criteria-box {
            display: flex;
            align-items: center;
            background-color: #f8f9fa;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            padding: 10px 15px;
            margin-top: 20px;
            margin-bottom: 15px;
            font-size: 13px;
            color: #555;
            max-width: 950px;
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

        /* ★変更：行（tr）ではなく、赤点のセル（td）だけをピンクにするスタイル */
        .score-cell-danger {
            background-color: #ffeaea !important;
        }
    </style>
</head>
<body>

<%
    String entYear = (String) request.getAttribute("entYear");
    String classNum = (String) request.getAttribute("classNum");
    String subjectCd = (String) request.getAttribute("subjectCd");
    String noStr = (String) request.getAttribute("no");
    String gradeStr = (String) request.getAttribute("grade"); 
    List<String> entYearList = (List<String>) request.getAttribute("entYearList");
    List<String> classList = (List<String>) request.getAttribute("classList");
    List<String> gradeList = (List<String>) request.getAttribute("gradeList"); 
    Boolean isFirstAccess = (Boolean) request.getAttribute("isFirstAccess");

    if (entYear == null) entYear = "";
    if (classNum == null) classNum = "";
    if (subjectCd == null) subjectCd = "";
    if (noStr == null) noStr = "";
    if (gradeStr == null) gradeStr = "";
%>

<jsp:include page="../header.jsp" />

<div class="system-layout">
    <div class="side-menu">
        <jsp:include page="/tag.jsp" />
    </div>

    <main class="main-content content-body">
        <div class="page-title">
            <h2>成績管理</h2>
        </div>

        <form action="${pageContext.request.contextPath}/ScoreSearch.action" method="post" class="search-form">
            <div class="form-group">
                <label class="form-label">入学年度</label>
                <select name="entYear" class="form-select">
                    <option value="" <%= entYear.equals("") ? "selected" : "" %>>--------</option>
                    <% if (entYearList != null) { for (String year : entYearList) { %>
                        <option value="<%= year %>" <%= entYear.equals(year) ? "selected" : "" %>><%= year %></option>
                    <% } } %>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label">クラス</label>
                <select name="classNum" class="form-select">
                    <option value="" <%= classNum.equals("") ? "selected" : "" %>>--------</option>
                    <% if (classList != null) { for (String cNum : classList) { %>
                        <option value="<%= cNum %>" <%= classNum.equals(cNum) ? "selected" : "" %>><%= cNum %></option>
                    <% } } %>
                </select>
            </div>
            
            <div class="form-group">
                <label class="form-label">学年</label>
                <select name="grade" class="form-select">
                    <option value="" <%= gradeStr.equals("") ? "selected" : "" %>>--------</option>
                    <% if (gradeList != null) { for (String g : gradeList) { %>
                        <option value="<%= g %>" <%= gradeStr.equals(g) ? "selected" : "" %>><%= g %>年</option>
                    <% } } %>
                </select>
            </div>

            <div class="form-group form-group-wide">
                <label class="form-label">科目</label>
                <select name="subjectCd" class="form-select">
                    <option value="" <%= subjectCd.equals("") ? "selected" : "" %>>--------</option>
                    <% List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjectList");
                       if (subjectList != null) { for (Map<String, String> sub : subjectList) { %>
                        <option value="<%= sub.get("cd") %>" <%= subjectCd.equals(sub.get("cd")) ? "selected" : "" %>><%= sub.get("name") %></option>
                    <% } } %>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label">回数</label>
                <select name="no" class="form-select">
                    <option value="" <%= noStr.equals("") ? "selected" : "" %>>--------</option>
                    <option value="1" <%= noStr.equals("1") ? "selected" : "" %>>1</option>
                    <option value="2" <%= noStr.equals("2") ? "selected" : "" %>>2</option>
                </select>
            </div>
            <div class="form-group form-group-btn">
                <label class="form-label">&nbsp;</label>
                <button type="submit" class="search-btn">検索</button>
            </div>
        </form>

        <%
        ArrayList<Bean.Score> list = (ArrayList<Bean.Score>) request.getAttribute("list");
        if (isFirstAccess == null || !isFirstAccess) {
            if (list != null && !list.isEmpty()) {
                Bean.Score firstData = list.get(0);
        %>
            <div class="subject-info-header">科目：<%= firstData.getSubjectName() %> （<%= firstData.getNo() %>回）</div>
            <!-- 評価基準の案内ボックス -->
            <div class="grade-criteria-box">
                <div class="criteria-title">評価基準</div>
                <div class="criteria-item"><span class="badge-red">赤点</span>：40点未満</div>
                <div class="criteria-item"><span>可</span>：40点〜59点</div>
                <div class="criteria-item"><span>良</span>：60点〜79点</div>
                <div class="criteria-item"><span class="badge-blue">優</span>：80点以上</div>
            </div>

            <form action="${pageContext.request.contextPath}/ScoreRegist.action" method="post">
                <table class="score-edit-table">
                    <thead>
                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>学年</th> 
                            <th>点数</th>
                            <th>判定</th> 
                        </tr>
                    </thead>
                    <tbody>
                        <% Set<String> displayedStudents = new HashSet<>();
                           for(Bean.Score data : list) { 
                               if (displayedStudents.contains(data.getStudentId())) continue;
                               displayedStudents.add(data.getStudentId());

                               int score = data.getPoint();
                               String judgeStr = "";
                               String judgeStyle = ""; 
                               String dangerCellClass = ""; // ★赤点判定セル用クラス名

                               if (score < 40) {
                                   judgeStr = "赤点";
                                   judgeStyle = "color: red; font-weight: bold;"; 
                                   dangerCellClass = "score-cell-danger"; // ★赤点ならクラス名をセット
                               } else if (score < 60) {
                                   judgeStr = "可";
                                   judgeStyle = "color: #333333;";
                               } else if (score < 80) {
                                   judgeStr = "良";
                                   judgeStyle = "color: #333333;";
                               } else {
                                   judgeStr = "優";
                                   judgeStyle = "color: #0066cc; font-weight: bold;"; 
                               }
                        %>
                        <tr>
                            <td><%= data.getEntYear() != null ? data.getEntYear() : "-" %></td>
                            <td><%= data.getClassNum() %></td>
                            <td><%= data.getStudentId() %></td>
                            <td class="student-name-td"><%= data.getStudentName() %></td>
                            <td><%= data.getGrade() > 0 ? data.getGrade() + "年" : "-" %></td> 
                            
                            <!-- ★点数と判定のマス目(td)だけ個別に背景色を切り替えます -->
                            <td class="<%= dangerCellClass %>">
                                <input type="number" name="point_<%= data.getStudentId() %>" value="<%= data.getPoint() %>" min="0" max="100" class="score-input">
                                <input type="hidden" name="studentIds" value="<%= data.getStudentId() %>-<%= data.getSubjectCd() %>-<%= data.getNo() %>">
                            </td>
                            <td class="judge-td <%= dangerCellClass %>" style="<%= judgeStyle %>"><%= judgeStr %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="btn-area" style="margin-top: 20px; clear: both;"><button type="submit" class="regist-end-btn">登録して終了</button></div>
            </form>
        <% } } %>
    </main>
</div>

<!-- ★リアルタイムでマス目だけをピンクにするためのJavaScript -->
<script>
    document.querySelectorAll('.score-input').forEach(function(input) {
        input.addEventListener('input', function() {
            var score = parseInt(this.value) || 0;
            
            var tdScore = this.closest('td'); // 点数入力欄があるマス
            var tr = this.closest('tr');
            var judgeTd = tr.querySelector('.judge-td'); // 判定の文字があるマス
            
            if (score < 40) {
                judgeTd.textContent = "赤点";
                judgeTd.style.color = "red";
                judgeTd.style.fontWeight = "bold";
                
                // ★2つのマス目だけにピンク背景を追加
                tdScore.classList.add('score-cell-danger');
                judgeTd.classList.add('score-cell-danger');
            } else if (score < 60) {
                judgeTd.textContent = "可";
                judgeTd.style.color = "#333333";
                judgeTd.style.fontWeight = "normal";
                
                // ピンク背景を消す
                tdScore.classList.remove('score-cell-danger');
                judgeTd.classList.remove('score-cell-danger');
            } else if (score < 80) {
                judgeTd.textContent = "良";
                judgeTd.style.color = "#333333";
                judgeTd.style.fontWeight = "normal";
                
                tdScore.classList.remove('score-cell-danger');
                judgeTd.classList.remove('score-cell-danger');
            } else {
                judgeTd.textContent = "優";
                judgeTd.style.color = "#0066cc";
                judgeTd.style.fontWeight = "bold";
                
                tdScore.classList.remove('score-cell-danger');
                judgeTd.classList.remove('score-cell-danger');
            }
        });
    });

    document.addEventListener("wheel", function(e) {
        if (document.activeElement.type === "number") {
            document.activeElement.blur();
        }
    });
</script>
</body>
</html>
            