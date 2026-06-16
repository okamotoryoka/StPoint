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
        // 常に必要なリスト（入学年度、クラス、科目）は取得
        request.setAttribute("entYearList", dao.getEntYearList());
        request.setAttribute("classNumList", dao.getClassNumList());
        request.setAttribute("subjects", dao.getSubjectList());
        
        // パラメータ取得
        String entYear = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String subjectCd = request.getParameter("subjectCd");
        String studentIdParam = request.getParameter("studentId");

        // ★修正ポイント：検索条件が1つも指定されていない場合は検索処理をスキップする
        boolean isSearchRequested = (entYear != null && !entYear.isEmpty()) ||
                                    (classNum != null && !classNum.isEmpty()) ||
                                    (subjectCd != null && !subjectCd.isEmpty()) ||
                                    (studentIdParam != null && !studentIdParam.isEmpty());

        if (isSearchRequested) {
            // 検索実行
            List<Map<String, Object>> rawList = dao.searchMaps(entYear, classNum, subjectCd, studentIdParam);
            
            // データ整形処理（displayMapへの詰め替えなど）
            Map<String, Map<String, Object>> displayMap = new LinkedHashMap<>();
            String selectedSubjectName = "";
            
            for (Map<String, Object> s : rawList) {
                // ... (既存のループ処理と同じ内容) ...
                String studentId = (String) s.get("student_id");
                if (studentId == null || studentId.trim().isEmpty()) continue;
                
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
                Object noObj = s.get("no");
                int no = (noObj != null) ? (Integer) noObj : 0;
                
                if (no == 1) { row.put("score1", s.get("point")); } 
                else if (no == 2) { row.put("score2", s.get("point")); }
            }
            
            // 検索された場合のみリストをセット
            request.setAttribute("scoreDisplayList", new ArrayList<>(displayMap.values()));
            request.setAttribute("selectedSubjectName", subjectCd.isEmpty() ? "すべて" : (selectedSubjectName.isEmpty() ? "データなし" : selectedSubjectName));
        }
        
        // 入力した条件を保持（検索ボタンを押した後の画面で入力値が消えないようにする）
        request.setAttribute("selectedYear", entYear);
        request.setAttribute("selectedClass", classNum);
        request.setAttribute("selectedSubjectCd", subjectCd);
        request.setAttribute("selectedStudentId", studentIdParam);
        
        request.getRequestDispatcher("/management/score_sub_list.jsp").forward(request, response);
    }
}