package Action.Score;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import DAO.Score.ScoreDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreSubjectAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        ScoreDAO dao = new ScoreDAO();
        
        // 1. ドロップダウン用の各種リストをDBから自動取得してセット
        List<String> entYearList = dao.getEntYearList();
        List<String> classNumList = dao.getClassNumList();
        List<Map<String, String>> subjectList = dao.getSubjectList();
        
        request.setAttribute("entYearList", entYearList);
        request.setAttribute("classNumList", classNumList);
        request.setAttribute("subjects", subjectList);
        
        // 2. 画面からの検索条件を取得
        String entYear = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String subjectCd = request.getParameter("subjectCd");
        String studentIdParam = request.getParameter("studentId"); // ★追加：学生番号の取得

        if (entYear == null) entYear = "";
        if (classNum == null) classNum = "";
        if (subjectCd == null) subjectCd = "";
        if (studentIdParam == null) studentIdParam = ""; // ★追加
        
        // 3. DAO経由でデータベースから検索（第4引数に学生番号を渡せるようにDAO側も下で合わせます）
        List<Map<String, Object>> rawList = dao.searchMaps(entYear, classNum, subjectCd, studentIdParam);
        
        // 4. 縦持ちのデータを、学生ごとに「横並び（1回目・2回目）」に綺麗に整形
        Map<String, Map<String, Object>> displayMap = new LinkedHashMap<>();
        String selectedSubjectName = "";
        
        for (Map<String, Object> s : rawList) {
            String studentId = (String) s.get("student_id");
            
            if (!subjectCd.isEmpty() && s.get("subject_name") != null) {
                selectedSubjectName = (String) s.get("subject_name"); 
            }
            
            if (!displayMap.containsKey(studentId)) {
                Map<String, Object> studentRow = new LinkedHashMap<>();
                studentRow.put("entYear", s.get("ent_year") == null ? "不明" : s.get("ent_year"));
                studentRow.put("classNum", s.get("class_num"));
                studentRow.put("studentId", studentId);
                studentRow.put("studentName", s.get("student_name"));
                studentRow.put("score1", "-");
                studentRow.put("score2", "-");
                displayMap.put(studentId, studentRow);
            }
            
            Map<String, Object> row = displayMap.get(studentId);
            int no = (Integer) s.get("no");
            if (no == 1) {
                row.put("score1", s.get("point"));
            } else if (no == 2) {
                row.put("score2", s.get("point"));
            }
        }
        
        // JSPへデータを引き渡す設定
        request.setAttribute("scoreDisplayList", new ArrayList<>(displayMap.values()));
        
        // 表示する科目名の最終判定
        if (subjectCd.isEmpty()) {
            request.setAttribute("selectedSubjectName", "すべて");
        } else if (selectedSubjectName.isEmpty()) {
            request.setAttribute("selectedSubjectName", "データなし");
        } else {
            request.setAttribute("selectedSubjectName", selectedSubjectName);
        }
        
        // 選択状態の保持用（★学生番号も保持させます）
        request.setAttribute("selectedYear", entYear);
        request.setAttribute("selectedClass", classNum);
        request.setAttribute("selectedSubjectCd", subjectCd);
        request.setAttribute("selectedStudentId", studentIdParam); // ★追加
        
        // 5. 画面のJSPへ遷移
        request.getRequestDispatcher("/management/score_sub_list.jsp").forward(request, response);
    }
}
