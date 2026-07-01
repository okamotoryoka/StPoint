<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点更新</title>
<style>
body{ font-family: "Yu Gothic", sans-serif; background: linear-gradient(135deg, #fdfbfb, #ebedee); margin: 0; padding: 40px; }
.container{ width: 500px; margin: auto; background: white; padding: 35px; border-radius: 20px; box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
h2{ text-align: center; color: #555; margin-bottom: 30px; font-size: 28px; }
table{ width: 100%; border-collapse: collapse; }
th{ text-align: left; padding: 12px; color: #666; width: 35%; }
td{ padding: 12px; }
/* 💡読み取り専用テキストのスタイルを少し調整しました */
.readonly-text { font-size: 15px; color: #333; padding-left: 2px; }
input{ width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 10px; font-size: 15px; transition: 0.3s; box-sizing: border-box; }
input:focus{ border-color: #ffb6c1; outline: none; box-shadow: 0 0 8px rgba(255,182,193,0.5); }
button{ width: 100%; padding: 14px; background: linear-gradient(135deg, #ffb6c1, #ff8fab); border: none; border-radius: 12px; color: white; font-size: 16px; font-weight: bold; cursor: pointer; transition: 0.3s; }
button:hover{ transform: translateY(-2px); box-shadow: 0 6px 15px rgba(255,143,171,0.4); }
</style>
</head>
<body>
<div class="container">
<h2>得点更新</h2>
<%
Map<String, Object> data = (Map<String, Object>) request.getAttribute("data");
// 💡学年（int）を取得（万が一nullだった場合は0にする）
int grade = data.get("grade") != null ? (Integer) data.get("grade") : 0;
%>
<form action="${pageContext.request.contextPath}/ScoreUpdateServlet.action" method="post">
<input type="hidden" name="student_id" value="<%= data.get("student_id") %>">
<input type="hidden" name="subject_cd" value="<%= data.get("subject_cd") %>">
<input type="hidden" name="school_cd" value="<%= data.get("school_cd") %>">
<input type="hidden" name="no" value="<%= data.get("no") %>">
<!-- 💡不要な「border="1"」を削除し、用意されているCSSデザインが綺麗に適用されるようにしました -->
<table>
<tr>
<th>学生番号</th>
<td class="readonly-text"><%= data.get("student_id") %></td>
</tr>
<!-- ★追加: 学年の表示項目 -->
<tr>
<th>学年</th>
<td class="readonly-text"><%= grade > 0 ? grade + "年" : "-" %></td>
</tr>
<tr>
<th>科目コード</th>
<td class="readonly-text"><%= data.get("subject_cd") %></td>
</tr>
<tr>
<th>得点</th>
<td><input type="number" name="point" value="<%= data.get("point") %>" min="0" max="100" required></td>
</tr>
<tr>
<th>学校コード</th>
<td class="readonly-text"><%= data.get("school_cd") %></td>
</tr>
<tr>
<th>クラス番号</th>
<td><input type="text" name="class_num" value="<%= data.get("class_num") %>" required></td>
</tr>
</table>
<br>
<button type="submit">更新</button>
</form>
</div>
</body>
</html>
