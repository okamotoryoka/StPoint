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
        String gradeStr = request.getParameter("grade"); // 追加: 学年のパラメータ取得
        boolean isAttend = request.getParameter("isAttend") != null;

        StudentDAO sDAO = new StudentDAO(); // 位置を上に移動（エラー時のリスト取得用）

        // 入力値をリクエストに保持（エラーで戻った際、入力を復元できるようにする）
        request.setAttribute("no", no);
        request.setAttribute("name", name);
        request.setAttribute("entYear", entYearStr);
        request.setAttribute("classNum", classNum);
        request.setAttribute("grade", gradeStr); // 追加: 入力された学年の保持

        // 必須チェック（氏名が未入力の場合）
        if (name == null || name.isEmpty()) {
            request.setAttribute("err", "required");
            // 元の画面に戻るために必要なリストを再セット
            request.setAttribute("grades", sDAO.getGrades());
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
            request.setAttribute("grades", sDAO.getGrades()); // 追加: リストの再セット
            request.getRequestDispatcher("/result/student_update.jsp").forward(request, response);
            return;
        }

        // 追加: 学年の数値変換チェック
        int grade = 0;
        try {
            if (gradeStr != null && !gradeStr.isEmpty()) {
                grade = Integer.parseInt(gradeStr);
            } else {
                request.setAttribute("err", "grade_required"); // 学年が空の場合のエラーハンドリング
                request.setAttribute("grades", sDAO.getGrades());
                request.getRequestDispatcher("/result/student_update.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("err", "grade_invalid");
            request.setAttribute("grades", sDAO.getGrades());
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
        student.setGrade(grade); // 追加: 学年をセット
        
        School school = new School();
        school.setCd("tes");
        student.setSchool(school);

        // 3. データベースへの更新処理を実行
        try {
            boolean isSuccess = sDAO.update(student); 
            if (!isSuccess) {
                request.setAttribute("err", "update_failed");
                request.setAttribute("grades", sDAO.getGrades()); // 追加: リストの再セット
                request.getRequestDispatcher("/result/student_update.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            request.setAttribute("err", "update_failed");
            request.setAttribute("grades", sDAO.getGrades()); // 追加: リストの再セット
            request.getRequestDispatcher("/result/student_update.jsp").forward(request, response);
            return;
        }

        // 4. 成功時はブラウザへ完了画面へのリダイレクトを指示します
        response.sendRedirect("result/student_update_done.jsp");
    }
}
