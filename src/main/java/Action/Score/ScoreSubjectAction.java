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
        List<String> entYearList = dao.getEntYearList();
        List<String> classNumList = dao.getClassNumList();
        List<Map<String, String>> subjectList = dao.getSubjectList();
        
        request.setAttribute("entYearList", entYearList);
        request.setAttribute("classNumList", classNumList);
        request.setAttribute("subjects", subjectList);
        
        String entYear = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String subjectCd = request.getParameter("subjectCd");
        String studentIdParam = request.getParameter("studentId");

        if (entYear == null) entYear = "";
        if (classNum == null) classNum = "";
        if (subjectCd == null) subjectCd = "";
        if (studentIdParam == null) studentIdParam = "";
        
        List<Map<String, Object>> rawList = dao.searchMaps(entYear, classNum, subjectCd, studentIdParam);
        
        Map<String, Map<String, Object>> displayMap = new LinkedHashMap<>();
        String selectedSubjectName = "";
        
        for (Map<String, Object> s : rawList) {
            String studentId = (String) s.get("student_id");
            // 学生番号が空の行は表示しない
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
            
            if (no == 1) {
                row.put("score1", s.get("point"));
            } else if (no == 2) {
                row.put("score2", s.get("point"));
            }
        }
        
        request.setAttribute("scoreDisplayList", new ArrayList<>(displayMap.values()));
        request.setAttribute("selectedSubjectName", subjectCd.isEmpty() ? "すべて" : (selectedSubjectName.isEmpty() ? "データなし" : selectedSubjectName));
        request.setAttribute("selectedYear", entYear);
        request.setAttribute("selectedClass", classNum);
        request.setAttribute("selectedSubjectCd", subjectCd);
        request.setAttribute("selectedStudentId", studentIdParam);
        
        request.getRequestDispatcher("/management/score_sub_list.jsp").forward(request, response);
    }
}