<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>席替えシミュレーション - 得点管理システム</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
<style>
    .system-layout { display: flex; width: 100%; min-height: 100vh; }
    .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; padding-top: 20px; }
    .main-content { flex: 1; padding: 30px; }
    
    .teacher-desk { width: 200px; background-color: #e0e0e0; text-align: center; padding: 10px; margin: 0 auto 40px auto; border-radius: 4px; font-weight: bold; border: 1px solid #ccc; }
    
    /* 💡横に並ぶ列が増えても崩れないよう、gapを少し詰め、はみ出た場合は横スクロールできるようにしています */
    .classroom-layout { display: flex; justify-content: center; gap: 25px; margin-top: 20px; overflow-x: auto; padding-bottom: 20px; }
    
    /* 縦に班（太枠）を積み重ねていく列の設定 */
    .classroom-column { display: flex; flex-direction: column; gap: 25px; }
    
    /* 縦の固定を解除し、5人目が来たら自動的に3行目に拡張されるようにします */
    .team-island-box { 
        border: 3px solid #000000; /* 太い外枠 */
        display: grid; 
        grid-template-columns: repeat(2, 120px); /* 横2席 */
        grid-template-rows: auto;                /* 縦は人数に応じて自動拡張 */
        background-color: #ffffff;
        box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    }
    
    /* 内側の細い分割線（1席ずつのマス目） */
    .seat { 
        border: 1px solid #cccccc; /* 内側の薄い境界線 */
        display: flex; 
        flex-direction: column; 
        justify-content: center; 
        align-items: center; 
        padding: 5px; 
        text-align: center; 
        box-sizing: border-box;
        height: 80px;
    }
    
    .team-empty-box { border: 3px dashed #ccc; background-color: #fafafa; }
    .seat-empty { background-color: #f8f9fa; color: #adb5bd; font-size: 12px; border: 1px dashed #ddd; }
    .student-name { font-weight: bold; font-size: 14px; color: #333; margin-bottom: 2px; }
    .student-id { font-size: 11px; color: #6c757d; }
    .student-point { font-size: 11px; color: #0066cc; font-weight: bold; }
    .initial-message { text-align: center; color: #999; margin-top: 20px; }
    
        /* 💡【追加】画面全体を包む基本構造に、横スクロールに対応する最小幅を設定します */
    body { 
        font-family: "Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN", "Hiragino Sans", Meiryo, sans-serif; 
        margin: 0; 
        padding: 0; 
        background-color: #f4f6f9; 
        color: #333; 
        /* 横スクロールした時、ヘッダーや背景が途中で千切れるのを防ぐ魔法のプロパティ */
        display: inline-block;
        min-width: 100%;
    }

    .system-layout { 
        display: flex; 
        width: 100%; 
        min-height: 100vh; 
    }
    
    .side-menu { width: 200px; flex-shrink: 0; background-color: #f8f9fa; border-right: 1px solid #ddd; padding-top: 20px; }
    .main-content { flex: 1; padding: 30px; }
    
</style>
</head>
<body>

<%
    String classNum = (String) request.getAttribute("selectedClass");
    String subjectCd = (String) request.getAttribute("selectedSubject");
    if (classNum == null) classNum = "";
    if (subjectCd == null) subjectCd = "";

    // Javaから送られてきた「列の多次元リスト」を取得します
    List<List<List<Map<String, Object>>>> classroomColumns = 
        (List<List<List<Map<String, Object>>>>) request.getAttribute("classroomColumns");

    boolean hasData = (classroomColumns != null && !classroomColumns.isEmpty());
%>

<jsp:include page="../header.jsp" />

<div class="system-layout">
    <div class="side-menu">
        <jsp:include page="/tag.jsp" />
    </div>

    <main class="main-content">
        <div class="search-title">成績考慮・自動席替え</div>

        <form action="${pageContext.request.contextPath}/SeatChange.action" method="get" class="search-form" style="border-bottom: 1px dashed #ddd; padding-bottom: 20px;">
            <div class="form-group style-group" style="display: flex; gap: 20px; align-items: center;">
                <div>
                    <label class="form-label">対象クラス</label>
                    <select name="classNum" class="form-select" required>
                        <option value="">--------</option>
                        <% List<String> classNumList = (List<String>) request.getAttribute("classNumList");
                           if (classNumList != null) { for (String clazz : classNumList) { %>
                            <option value="<%= clazz %>" <%= classNum.equals(clazz) ? "selected" : "" %>><%= clazz %></option>
                        <% } } %>
                    </select>
                </div>
                <div>
                    <label class="form-label">考慮する科目（平均点）</label>
                    <select name="subjectCd" class="form-select" style="width: 200px;" required>
                        <option value="">--------</option>
                        <% List<Map<String, String>> subjectList = (List<Map<String, String>>) request.getAttribute("subjects");
                           if (subjectList != null) { for (Map<String, String> sub : subjectList) { %>
                            <option value="<%= sub.get("cd") %>" <%= subjectCd.equals(sub.get("cd")) ? "selected" : "" %>><%= sub.get("name") %></option>
                        <% } } %>
                    </select>
                </div>
                <button type="submit" class="search-btn" style="margin-top: 18px;">席替えを実行</button>
            </div>
        </form>

        <% if (hasData) { %>
            <div class="teacher-desk">ーー 黒板 / 教壇 ーー</div>

            <div class="classroom-layout">
                <% 
                    // Java側で計算された「列データ」の数（4列や5列など）のぶんだけ横にループします
                    for (List<List<Map<String, Object>>> columnTeams : classroomColumns) {
                %>
                        <!-- 【動的生成された縦列】 -->
                        <div class="classroom-column">
                            <% 
                                // 💡【重要修正】各縦列は、指定通り固定で「縦3段（3個の班）」を綺麗に上から描画します
                                for (int row = 0; row < 3; row++) {
                                    List<Map<String, Object>> team = null;
                                    if (columnTeams != null && row < columnTeams.size()) {
                                        team = columnTeams.get(row);
                                    }

                                    // 班のデータが存在する場合（通常の班）
                                    if (team != null && !team.isEmpty()) {
                            %>
                                        <div class="team-island-box">
                                            <% 
                                                int displaySeats = Math.max(4, team.size());
                                                for (int s = 0; s < displaySeats; s++) { 
                                                    if (s < team.size()) {
                                                        Map<String, Object> student = team.get(s);
                                                        if (student != null) {
                                            %>
                                                            <div class="seat">
                                                                <div class="student-name"><%= student.get("student_name") %></div>
                                                                <div class="student-id"><%= student.get("student_id") %></div>
                                                                <div class="student-point"><%= String.format("%.1f", student.get("avg_point")) %>点</div>
                                                            </div>
                                            <% 
                                                        } else { 
                                            %>
                                                            <div class="seat seat-empty">空席</div>
                                            <% 
                                                        }
                                                    } else {
                                            %>
                                                        <div class="seat seat-empty">空席</div>
                                            <%
                                                    }
                                                } 
                                                // 5人班の場合は右側の崩れを防ぐために空席を1つ追加
                                                if (team.size() == 5) {
                                            %>
                                                    <div class="seat seat-empty">空席</div>
                                            <% 
                                                } 
                                            %>
                                        </div>
                            <% 
                                    } else { 
                                        // 💡 列の中にまだ空いている枠があれば、綺麗な点線の「空席の4連マス」を自動描画します
                            %>
                                        <div class="team-island-box team-empty-box">
                                            <div class="seat seat-empty">空席</div>
                                            <div class="seat seat-empty">空席</div>
                                            <div class="seat seat-empty">空席</div>
                                            <div class="seat seat-empty">空席</div>
                                        </div>
                            <% 
                                    }
                                } 
                            %>
                        </div>
                <% 
                    } 
                %>
            </div> <!-- classroom-layout 終了 -->
            
            <br />
        <% 
            } else if (classNum != null && !classNum.isEmpty()) { 
        %>
            <div class="initial-message">選択されたクラスに在学中の生徒、または成績データが存在しません。</div>
        <% 
            } else { 
        %>
            <div class="initial-message">クラスと科目を選択して「席替えを実行」ボタンを押してください。</div>
        <% 
            } 
        %>
    </main>
</div>

</body>
</html>
