<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="Bean.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生管理</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: sans-serif; background-color: #ffffff; }
        
        .system-layout { display: flex; width: 100%; min-height: calc(100vh - 80px); }
        .side-menu { width: 220px; min-width: 220px; flex-shrink: 0; background-color: #ffffff; border-right: 1px solid #e0e0e0; }
        .main-content { flex: 1; padding: 30px; }

        /* 見出しとボタン */
        .title-area { background-color: #f0f0f0; padding: 10px 15px; margin-bottom: 10px; width: 100%; }
        .title-area h2 { margin: 0; font-size: 20px; font-weight: bold; color: #333; }
        .create-link { color: #0066cc; text-decoration: underline; font-size: 14px; }

        /* 絞込みフォーム */
        /* 💡学年が追加されたため、要素が並びやすいようgapを50pxから25pxに少し狭めました */
        .filter-box { display: flex; align-items: center; gap: 25px; padding: 20px 30px; background-color: #ffffff; border: 1px solid #e0e0e0; border-radius: 4px; margin-bottom: 20px; width: 100%; }
        .filter-group { display: flex; flex-direction: column; gap: 6px; }
        .filter-group label { font-size: 14px; color: #333; }
        /* 💡横幅が窮屈にならないようプルダウン幅を260pxから180pxに調整しました */
        .filter-group select { height: 38px; width: 180px; padding: 0 12px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px; background-color: #ffffff; }
        .filter-group-checkbox { display: flex; flex-direction: row; align-items: center; margin-top: 25px; }
        
        .btn-submit { height: 38px; padding: 0 25px; background-color: #555555; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 14px; margin-left: auto; }
        .btn-submit:hover { background-color: #333333; }

        /* テーブルスタイル */
        .result-count { font-size: 14px; color: #666; margin-bottom: 10px; }
        .student-table { width: 100%; border-collapse: collapse; margin-top: 10px; font-size: 15px; }
        .student-table th { padding: 12px 10px; text-align: left; font-weight: bold; color: #333; border-top: 1px solid #dcdcdc; border-bottom: 2px solid #333; }
        .student-table td { padding: 14px 10px; border-bottom: 1px solid #efefef; color: #555; }
        .student-table td a { color: #0066cc; text-decoration: underline; }
    </style>
</head>
<body>

    <jsp:include page="../header.jsp" />

    <div class="system-layout">
        <div class="side-menu">
            <jsp:include page="../tag.jsp"/>
        </div>

        <main class="main-content">
            <div class="title-area">
                <h2>学生管理</h2>
            </div>
            <div style="text-align: right; margin-bottom: 15px;">
                <a href="${pageContext.request.contextPath}/StudentCreate.action" class="create-link">新規登録</a>
            </div>

            <form action="${pageContext.request.contextPath}/StudentList.action" method="post" class="filter-box">
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

                <!-- 💡追加: 学年の絞り込みプルダウン -->
                <div class="filter-group">
                    <label>学年</label>
                    <select name="grade">
                        <option value="">--------</option>
                        <%
                            List<?> gradeList = (List<?>) request.getAttribute("gradeList");
                            String sGrade = String.valueOf(request.getAttribute("selectedGrade") != null ? request.getAttribute("selectedGrade") : "");
                            if (gradeList != null) {
                                for (Object g : gradeList) {
                                    String val = String.valueOf(g);
                        %>
                                    <option value="<%= val %>" <%= val.equals(sGrade) ? "selected" : "" %>><%= val %>年</option>
                        <%      }
                            }
                        %>
                    </select>
                </div>

                <div class="filter-group-checkbox">
                    <% Boolean isAttend = (Boolean) request.getAttribute("selectedAttend"); %>
                    <input type="checkbox" name="isAttend" value="true" <%= (isAttend != null && isAttend) ? "checked" : "" %> id="attend-cb">
                    <label style="margin-left: 5px; cursor: pointer;" for="attend-cb">在学中</label>
                </div>

                <input type="submit" value="絞込み" class="btn-submit">
            </form>

            <div class="result-count">
                <% List<Student> list = (List<Student>) request.getAttribute("students"); %>
                検索結果：<%= (list != null) ? list.size() : 0 %>件
            </div>

            <table class="student-table">
                <thead>
                    <tr>
                        <th>入学年度</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>クラス</th>
                        <th>学年</th> <!-- 💡追加: 学年のヘッダー -->
                        <th>在学中</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <% if (list != null && !list.isEmpty()) {
                        for (Student s : list) { %>
                            <tr>
                                <td><%= s.getEntYear() %></td>
                                <td><%= s.getNo() %></td>
                                <td><%= s.getName() %></td>
                                <td><%= s.getClassNum() %></td>
                                <td><%= s.getGrade() > 0 ? s.getGrade() + "年" : "-" %></td> <!-- 💡追加: 学生の学年データ（0以下の場合はハイフン表示） -->
                                <td><%= s.isAttend() ? "〇" : "×" %></td>
                                <td style="text-align: right;">
                                    <a href="${pageContext.request.contextPath}/StudentUpdate.action?no=<%= s.getNo() %>">変更</a>
                                </td>
                            </tr>
                    <%  } } else { %>
                        <!-- 💡列数が1つ増えたため、colspanを6から7に修正しました -->
                        <tr><td colspan="7" style="text-align: center; padding: 30px;">学生情報が存在しませんでした</td></tr>
                    <% } %>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>
