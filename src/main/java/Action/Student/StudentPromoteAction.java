package Action.Student;

import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentPromoteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean isPost = "POST".equalsIgnoreCase(request.getMethod());

        if (isPost) {
            StudentDAO dao = new StudentDAO();
            try {
                boolean isSuccess = dao.promoteAllStudents();
                if (isSuccess) {
                    // 💡 成功時は、新しく作った完了画面ではなく、最新の状態になった「学生一覧」へ直接リダイレクトします
                    // これにより、学年が上がったことや4年生が消えた（卒業した）ことが一目で分かります
                    response.sendRedirect(request.getContextPath() + "/StudentList.action");
                    return;
                } else {
                    request.setAttribute("errorMessage", "一括処理に失敗しました。");
                }
            } catch (Exception e) {
                request.setAttribute("errorMessage", "エラーが発生しました: " + e.getMessage());
            }
        }

        request.getRequestDispatcher("/result/student_promote.jsp").forward(request, response);
    }
}
