package Action.Student;

import Bean.School;
import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentUpdatExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. パラメータを受け取る
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        boolean isAttend = request.getParameter("isAttend") != null;

        // 入力値をリクエストに保持（エラーで戻った際、入力を復元できるようにする）
        request.setAttribute("no", no);
        request.setAttribute("name", name);
        request.setAttribute("entYear", entYearStr);
        request.setAttribute("classNum", classNum);

        // 必須チェック（氏名が未入力の場合）
        if (name == null || name.isEmpty()) {
            request.setAttribute("err", "required");
            request.getRequestDispatcher("/result/student_update.jsp").forward(request, response);
            return;
        }

        // 数値変換チェックとtry-catchによるエラー対策
        int entYear = 0;
        try {
            if (entYearStr != null && !entYearStr.isEmpty()) {
                entYear = Integer.parseInt(entYearStr);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("err", "year_invalid");
            request.getRequestDispatcher("/result/student_update.jsp").forward(request, response);
            return;
        }

        // 2. Studentオブジェクトに変更内容をセット
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntYear(entYear);
        student.setClassNum(classNum);
        student.setAttend(isAttend); 
        
        School school = new School();
        school.setCd("tes");
        student.setSchool(school);

        // 3. データベースへの更新処理を実行
        StudentDAO sDAO = new StudentDAO();
        
        try {
            boolean isSuccess = sDAO.update(student); 
            if (!isSuccess) {
                request.setAttribute("err", "update_failed");
                request.getRequestDispatcher("/result/student_update.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            request.setAttribute("err", "update_failed");
            request.getRequestDispatcher("/result/student_update.jsp").forward(request, response);
            return;
        }

        // 4. 成功時はブラウザへ完了画面へのリダイレクトを指示します
        response.sendRedirect("result/student_update_done.jsp");
    }
}
