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
        request.setAttribute("entYearList", dao.getEntYearList());
        request.setAttribute("classNumList", dao.getClassNumList());
        request.setAttribute("subjects", dao.getSubjectList());
        request.setAttribute("gradeList", dao.getGradeList());
        
        String entYear = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String subjectCd = request.getParameter("subjectCd");
        String studentIdParam = request.getParameter("studentId");
        String gradeStr = request.getParameter("grade"); 

        boolean isSearchRequested = (entYear != null && !entYear.isEmpty()) ||
                                    (classNum != null && !classNum.isEmpty()) ||
                                    (subjectCd != null && !subjectCd.isEmpty()) ||
                                    (studentIdParam != null && !studentIdParam.isEmpty()) ||
                                    (gradeStr != null && !gradeStr.isEmpty()); 

        if (isSearchRequested) {
            List<Map<String, Object>> rawList = dao.searchMaps(entYear, classNum, subjectCd, studentIdParam, gradeStr);
            
            Map<String, Map<String, Object>> displayMap = new LinkedHashMap<>();
            String selectedSubjectName = "";
            
            for (Map<String, Object> s : rawList) {
                String studentId = (String) s.get("student_id");
                if (studentId == null || studentId.trim().isEmpty()) continue;
                
                if (subjectCd != null && !subjectCd.isEmpty() && s.get("subject_name") != null) {
                    selectedSubjectName = (String) s.get("subject_name"); 
                }
                
                if (!displayMap.containsKey(studentId)) {
                    Map<String, Object> studentRow = new LinkedHashMap<>();
                    studentRow.put("entYear", s.get("ent_year") == null ? "不明" : s.get("ent_year"));
                    studentRow.put("classNum", s.get("class_num"));
                    studentRow.put("studentId", studentId);
                    studentRow.put("studentName", s.get("student_name") != null ? s.get("student_name") : "未登録");
                    studentRow.put("grade", s.get("grade")); 
                    
                    // ★【重要修正】JSPのパースエラーを防ぐため、ハイフンにせずnullのままJSPへ引き渡します
                    studentRow.put("score1", s.get("score1"));
                    studentRow.put("score2", s.get("score2"));
                    
                    displayMap.put(studentId, studentRow);
                }
            }
            
            request.setAttribute("scoreDisplayList", new ArrayList<>(displayMap.values()));
            request.setAttribute("selectedSubjectName", subjectCd.isEmpty() ? "すべて" : (selectedSubjectName.isEmpty() ? "データなし" : selectedSubjectName));
        }
        
        request.setAttribute("selectedYear", entYear);
        request.setAttribute("selectedClass", classNum);
        request.setAttribute("selectedSubjectCd", subjectCd);
        request.setAttribute("selectedStudentId", studentIdParam);
        request.setAttribute("selectedGrade", gradeStr); 
        
        request.getRequestDispatcher("/management/score_sub_list.jsp").forward(request, response);
    }
}
