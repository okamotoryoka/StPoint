package Action.Student;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // ★追加：セッション用
import tool.Action;

public class StudentListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // セッションオブジェクトの取得
        HttpSession session = request.getSession();
        
        // 1. JSPの絞り込みフォームから送られてきた値を取得する
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String gradeStr = request.getParameter("grade"); 
        String isAttendStr = request.getParameter("isAttend"); 

        // リクエストの判定（初回や戻ってきたときはGET、絞り込みボタンはPOST）
        boolean isPost = "POST".equalsIgnoreCase(request.getMethod());
        boolean currentAttendChecked = false;
        
        // ★最重要：変更画面から「戻る」で戻ってきたとき（GETかつ全パラメータが空）は、セッションから前回値を復元する
        if (!isPost && entYearStr == null && classNum == null && gradeStr == null && isAttendStr == null) {
            entYearStr = (String) session.getAttribute("sess_entYear");
            classNum = (String) session.getAttribute("sess_classNum");
            gradeStr = (String) session.getAttribute("sess_grade");
            Boolean sessAttend = (Boolean) session.getAttribute("sess_isAttend");
            currentAttendChecked = (sessAttend != null) ? sessAttend : false;
            
            // 戻り時も、過去に検索ボタンが押されていた状態（POST相当の挙動）としてデータを出すためにフラグを擬似的に立てる
            if (entYearStr != null || classNum != null || gradeStr != null || currentAttendChecked) {
                isPost = true; 
            }
        } else if (isPost) {
            // 絞り込みボタン（POST）が押されたときは、現在の条件をセッションに記憶する
            currentAttendChecked = (isAttendStr != null);
            session.setAttribute("sess_entYear", entYearStr);
            session.setAttribute("sess_classNum", classNum);
            session.setAttribute("sess_grade", gradeStr);
            session.setAttribute("sess_isAttend", currentAttendChecked);
        } else {
            // 初回アクセス（メニューから直で来たGET）のときは検索条件を初期化する
            session.removeAttribute("sess_entYear");
            session.removeAttribute("sess_classNum");
            session.removeAttribute("sess_grade");
            session.removeAttribute("sess_isAttend");
            currentAttendChecked = false;
        }

        // 2. 画面の選択状態をキープするためにリクエスト属性に送り返す
        request.setAttribute("selectedYear", entYearStr);
        request.setAttribute("selectedClass", classNum);
        request.setAttribute("selectedGrade", gradeStr); 
        request.setAttribute("selectedAttend", currentAttendChecked);

        StudentDAO dao = new StudentDAO();
        
        // 3. セレクトボックス自動生成のための全件データを取得
        List<Student> allStudents = dao.findAll();
        Set<Integer> yearSet = new HashSet<>();
        Set<String> classSet = new HashSet<>();
        Set<Integer> gradeSet = new HashSet<>(); 
        
        if (allStudents != null) {
            for (Student s : allStudents) {
                if (s.getEntYear() > 0) yearSet.add(s.getEntYear());
                if (s.getClassNum() != null && !s.getClassNum().isEmpty()) classSet.add(s.getClassNum());
                if (s.getGrade() > 0) gradeSet.add(s.getGrade()); 
            }
        }
        
        List<Integer> yearList = new ArrayList<>(yearSet);
        List<String> classList = new ArrayList<>(classSet);
        List<Integer> gradeList = new ArrayList<>(gradeSet); 
        
        Collections.sort(yearList);
        Collections.sort(classList);
        Collections.sort(gradeList); 
        
        request.setAttribute("yearList", yearList);
        request.setAttribute("classList", classList);
        request.setAttribute("gradeList", gradeList); 

        // 4.表示データの取得
        List<Student> students = null;

        if (isPost) {
            String classQuery = (classNum != null) ? classNum : "";
            
            int gradeQuery = 0;
            if (gradeStr != null && !gradeStr.isEmpty()) {
                gradeQuery = Integer.parseInt(gradeStr);
            }
            
            students = dao.search("", classQuery, gradeQuery, "no");
        } else {
            students = dao.findAll();
        }

        if (students == null) {
            students = new ArrayList<>();
        }

        // 5. 【厳密な絞り込み】入学年度によるJava側でのフィルタリング
        if (entYearStr != null && !entYearStr.isEmpty()) {
            int entYear = Integer.parseInt(entYearStr);
            students.removeIf(s -> s.getEntYear() != entYear);
        }
        
        if (currentAttendChecked) {
            students.removeIf(s -> !s.isAttend());
        }

        // 6. 最終的な結果リストをJSPに渡す
        request.setAttribute("students", students);

        // その場で直接JSPへフォワードし、画面を表示します
        request.getRequestDispatcher("/result/student_list.jsp").forward(request, response);
    }
}
