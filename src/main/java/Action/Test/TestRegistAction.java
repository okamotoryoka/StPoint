package Action.Test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import Action.Subject.Util;
import Bean.School;
import Bean.Subject;
import Bean.Teacher;
import Bean.Test;
import DAO.Subject.SubjectDAO;
import DAO.Test.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class TestRegistAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        try {
            Teacher teacher = Util.getUser(request);
            School school = teacher.getSchool();
            
            String entYearStr = request.getParameter("entYear");
            String classNum = request.getParameter("classNum");
            String subjectCd = request.getParameter("subjectCd");
            String noStr = request.getParameter("no");
            
            // 1. 未入力バリデーション
            if (entYearStr == null || entYearStr.isBlank() || 
                classNum == null || classNum.isBlank() || 
                subjectCd == null || subjectCd.isBlank() || 
                noStr == null || noStr.isBlank()) {
                
                request.setAttribute("errorMsg", "入学年度、クラス、科目、回数をすべて選択してください。");
            } else {
                int entYear = Integer.parseInt(entYearStr.trim());
                
                Subject subject = new Subject();
                subject.setCd(subjectCd);
                subject.setSchool(school);
                
                TestDAO testDao = new TestDAO();
                List<Test> testList = testDao.filter(school, entYear, classNum, subject);
                
                List<Map<String, Object>> students = new ArrayList<>();
                for (Test t : testList) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("student_id", t.getStudent().getNo());
                    map.put("student_name", t.getStudent().getName());
                    map.put("class_num", t.getStudent().getClassNum());
                    map.put("point", t.getPoint() == -1 ? "" : t.getPoint());
                    students.add(map);
                }
                request.setAttribute("students", students);
            }
            
            // 2. JSP画面（subject_list.jsp）が状態を維持するために使っている変数名（属性名）に完全に一致させます
            request.setAttribute("f1", entYearStr);       // 入学年度の選択状態をキープ
            request.setAttribute("f2", classNum);      // クラスの選択状態をキープ
            request.setAttribute("f3", subjectCd);     // 科目の選択状態をキープ
            request.setAttribute("f4", noStr);         // 回数の選択状態をキープ
            
            // 3. プルダウンの選択肢リストを再取得してセット
            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
            
            List<Integer> yearList = new ArrayList<>();
            String yearSql = "SELECT DISTINCT ENT_YEAR FROM STUDENT WHERE UPPER(TRIM(SCHOOL_CD)) = UPPER(TRIM(?)) ORDER BY ENT_YEAR DESC";
            
            List<String> classList = new ArrayList<>();
            String classSql = "SELECT DISTINCT CLASS_NUM FROM STUDENT WHERE UPPER(TRIM(SCHOOL_CD)) = UPPER(TRIM(?)) ORDER BY CLASS_NUM ASC";
            
            try (Connection con = ds.getConnection()) {
                try (PreparedStatement st = con.prepareStatement(yearSql)) {
                    st.setString(1, school.getCd());
                    try (ResultSet rs = st.executeQuery()) {
                        while (rs.next()) {
                            yearList.add(rs.getInt("ENT_YEAR"));
                        }
                    }
                }
                try (PreparedStatement st = con.prepareStatement(classSql)) {
                    st.setString(1, school.getCd());
                    try (ResultSet rs = st.executeQuery()) {
                        while (rs.next()) {
                            classList.add(rs.getString("CLASS_NUM").trim());
                        }
                    }
                }
            }
            
            request.setAttribute("yearList", yearList);
            request.setAttribute("classList", classList);
            
            List<Integer> countList = new ArrayList<>();
            countList.add(1);
            countList.add(2);
            request.setAttribute("countList", countList);
            
            SubjectDAO subjectDao = new SubjectDAO();
            List<Subject> subjectList = subjectDao.filter(school);
            request.setAttribute("subjectList", subjectList);
            
            request.getRequestDispatcher("/subject/subject_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            throw new jakarta.servlet.ServletException(e);
        }
    }
}
