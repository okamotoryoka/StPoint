package Action.Student;

import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentCreateExecuteAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // パラメータの取得
        String name = request.getParameter("name");
        String no = request.getParameter("no");
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");

        // 入力値をリクエストに保持（エラーで戻った際、入力を復元できるようにする）
        request.setAttribute("name", name);
        request.setAttribute("no", no);
        request.setAttribute("classNum", classNum);
        if (entYearStr != null && !entYearStr.isEmpty()) {
            request.setAttribute("entYear", entYearStr);
        }

        // 1. 【学生番号、氏名が未入力の場合】のチェック
        if (no == null || no.isEmpty() || name == null || name.isEmpty()) {
            request.setAttribute("err", "required");
            return "result/student_create.jsp"; // 404エラー対策で「result/」を追加
        }

        // 2. 【入学年度が未入力の場合】のチェック
        if (entYearStr == null || entYearStr.isEmpty()) {
            request.setAttribute("err", "year_empty");
            return "result/student_create.jsp"; // 404エラー対策で「result/」を追加
        }

        // 数値変換チェック
        int entYear;
        try {
            entYear = Integer.parseInt(entYearStr);
        } catch (NumberFormatException e) {
            request.setAttribute("err", "year_invalid");
            return "result/student_create.jsp"; // 404エラー対策で「result/」を追加
        }

        StudentDAO dao = new StudentDAO();

        // 3. 【学生番号が重複していた場合】のチェック
        if (dao.get(no) != null) {
            request.setAttribute("err", "duplicate"); 
            return "result/student_create.jsp"; // 404エラー対策で「result/」を追加
        }

        // 4. Beanの作成と保存処理
        Student s = new Student();
        s.setNo(no);
        s.setName(name);
        s.setEntYear(entYear);
        s.setClassNum(classNum);
        s.setIsAttend(true);

        try {
            boolean isSuccess = dao.postFilter(s);
            if (!isSuccess) {
                request.setAttribute("err", "insert_failed");
                return "result/student_create.jsp"; // 404エラー対策で「result/」を追加
            }
        } catch (Exception e) {
            request.setAttribute("err", "insert_failed");
            return "result/student_create.jsp"; // 404エラー対策で「result/」を追加
        }

        // 成功時は「学生登録完了画面」へ遷移する
        return "result/student_create_done.jsp"; // 404エラー対策で「result/」を追加
    }
}
