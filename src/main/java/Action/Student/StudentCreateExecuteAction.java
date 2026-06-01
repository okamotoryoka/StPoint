package Action.Student;

import Bean.School;
import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentCreateExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
            request.getRequestDispatcher("/result/student_create.jsp").forward(request, response);
            return;
        }

        // 2. 【入学年度が未入力の場合】のチェック
        if (entYearStr == null || entYearStr.isEmpty()) {
            request.setAttribute("err", "year_empty");
            request.getRequestDispatcher("/result/student_create.jsp").forward(request, response);
            return;
        }

        // 数値変換チェック
        int entYear;
        try {
            entYear = Integer.parseInt(entYearStr);
        } catch (NumberFormatException e) {
            request.setAttribute("err", "year_invalid");
            request.getRequestDispatcher("/result/student_create.jsp").forward(request, response);
            return;
        }

        StudentDAO dao = new StudentDAO();

        // 3. 【学生番号が重複していた場合】のチェック
        if (dao.get(no) != null) {
            request.setAttribute("err", "duplicate"); 
            request.getRequestDispatcher("/result/student_create.jsp").forward(request, response);
            return;
        }

        // 4. Beanの作成と保存処理
        Student s = new Student();
        s.setNo(no);
        s.setName(name);
        s.setEntYear(entYear);
        s.setClassNum(classNum);
        s.setAttend(true);

        School school = new School();
        school.setCd("tes"); 
        s.setSchool(school);

        try {
            boolean isSuccess = dao.postFilter(s);
            if (!isSuccess) {
                request.setAttribute("err", "insert_failed");
                request.getRequestDispatcher("/result/student_create.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            request.setAttribute("err", "insert_failed");
            request.getRequestDispatcher("/result/student_create.jsp").forward(request, response);
            return;
        }

        // 成功時はブラウザへ完了画面へのリダイレクトを指示します
        response.sendRedirect("result/student_create_done.jsp");
    }
}
