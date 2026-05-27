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

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. JSPの絞り込みフォームから送られてきた値を取得する
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String isAttendStr = request.getParameter("isAttend"); 

        // リクエストの判定（初回や戻ってきたときはGET、絞り込みボタンはPOST）
        boolean isPost = "POST".equalsIgnoreCase(request.getMethod());
        boolean currentAttendChecked = false;
        
        if (isPost) {
            // 絞り込み時は、チェックボックスにチェックが入っている場合だけONにする
            currentAttendChecked = (isAttendStr != null);
        } else {
            // ⭕ 完了画面などから戻ってきたとき（GET）は、初期状態としてON（在学中のみ表示）にする
            currentAttendChecked = true;
        }

        // 2. 画面の選択状態をキープするためにリクエスト属性に送り返す
        request.setAttribute("selectedYear", entYearStr);
        request.setAttribute("selectedClass", classNum);
        request.setAttribute("selectedAttend", currentAttendChecked);

        StudentDAO dao = new StudentDAO();
        
        // 3. セレクトボックス自動生成のための全件データを取得
        List<Student> allStudents = dao.findAll();
        Set<Integer> yearSet = new HashSet<>();
        Set<String> classSet = new HashSet<>();
        
        if (allStudents != null) {
            for (Student s : allStudents) {
                if (s.getEntYear() > 0) yearSet.add(s.getEntYear());
                if (s.getClassNum() != null && !s.getClassNum().isEmpty()) classSet.add(s.getClassNum());
            }
        }
        
        List<Integer> yearList = new ArrayList<>(yearSet);
        List<String> classList = new ArrayList<>(classSet);
        Collections.sort(yearList);
        Collections.sort(classList);
        
        request.setAttribute("yearList", yearList);
        request.setAttribute("classList", classList);

        // 4.表示データの取得（「何も表示されない」バグの修正箇所）
        List<Student> students = null;

        if (isPost) {
            // 絞り込みボタンが押された（POST）の時は、選択されたクラスで検索する
            String classQuery = (classNum != null) ? classNum : "";
            students = dao.search("", classQuery, "no");
        } else {
            // ⭕ 完了画面から戻ってきたとき（GET）は、初期表示として「全員」をデータベースから連れてくる
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
        
        // 「在学中」チェックボックスがONのときは、退学者（false）を一覧から除外する
        if (currentAttendChecked) {
            students.removeIf(s -> !s.isAttend());
        }

        // 6. 最終的な結果リストをJSPに渡す
        request.setAttribute("students", students);

        return "result/student_list.jsp";
    }
}
