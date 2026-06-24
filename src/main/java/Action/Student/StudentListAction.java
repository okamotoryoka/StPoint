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
import tool.Action;

public class StudentListAction extends Action {

    // 戻り値の型を String から void に変更します
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. JSPの絞り込みフォームから送られてきた値を取得する
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String gradeStr = request.getParameter("grade"); // 追加: 学年のパラメータ取得
        String isAttendStr = request.getParameter("isAttend"); 

        // リクエストの判定（初回や戻ってきたときはGET、絞り込みボタンはPOST）
        boolean isPost = "POST".equalsIgnoreCase(request.getMethod());
        boolean currentAttendChecked = false;
        
        if (isPost) {
            // 絞り込み時は、チェックボックスにチェックが入っている場合だけONにする
            currentAttendChecked = (isAttendStr != null);
        } else {
            currentAttendChecked = false;
        }

        // 2. 画面の選択状態をキープするためにリクエスト属性に送り返す
        request.setAttribute("selectedYear", entYearStr);
        request.setAttribute("selectedClass", classNum);
        request.setAttribute("selectedGrade", gradeStr); // 追加: 選択された学年の保持
        request.setAttribute("selectedAttend", currentAttendChecked);

        StudentDAO dao = new StudentDAO();
        
        // 3. セレクトボックス自動生成のための全件データを取得
        List<Student> allStudents = dao.findAll();
        Set<Integer> yearSet = new HashSet<>();
        Set<String> classSet = new HashSet<>();
        Set<Integer> gradeSet = new HashSet<>(); // 追加: 学年重複排除用のセット
        
        if (allStudents != null) {
            for (Student s : allStudents) {
                if (s.getEntYear() > 0) yearSet.add(s.getEntYear());
                if (s.getClassNum() != null && !s.getClassNum().isEmpty()) classSet.add(s.getClassNum());
                if (s.getGrade() > 0) gradeSet.add(s.getGrade()); // 追加: 学年をセットに蓄積
            }
        }
        
        List<Integer> yearList = new ArrayList<>(yearSet);
        List<String> classList = new ArrayList<>(classSet);
        List<Integer> gradeList = new ArrayList<>(gradeSet); // 追加: 学年リストの生成
        
        Collections.sort(yearList);
        Collections.sort(classList);
        Collections.sort(gradeList); // 追加: 学年を昇順にソート
        
        request.setAttribute("yearList", yearList);
        request.setAttribute("classList", classList);
        request.setAttribute("gradeList", gradeList); // 追加: 学年リストをJSPに渡す

        // 4.表示データの取得
        List<Student> students = null;

        if (isPost) {
            String classQuery = (classNum != null) ? classNum : "";
            
            // 追加・修正: 画面から送られてきた学年を数値に変換（未指定や空文字なら0にする）
            int gradeQuery = 0;
            if (gradeStr != null && !gradeStr.isEmpty()) {
                gradeQuery = Integer.parseInt(gradeStr);
            }
            
            // 修正: 引数に学年（gradeQuery）を追加してDAOの検索を呼び出す
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
