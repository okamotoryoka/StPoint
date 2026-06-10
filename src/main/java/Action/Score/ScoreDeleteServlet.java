package Action.Score;

import java.io.IOException;

import Bean.Score;
// 必要なDAOとBeanをインポート
import DAO.Score.ScoreDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns={"/score/delete"})
public class ScoreDeleteServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1. 画面から送られてきた削除対象のキー情報を取得
        String studentId = request.getParameter("student_id");
        String subjectCd = request.getParameter("subject_cd");
        String schoolCd = request.getParameter("school_cd");
        String noStr = request.getParameter("no");

        // パラメータのチェック
        if (studentId == null || subjectCd == null || schoolCd == null || noStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "必須パラメータが足りません。");
            return;
        }

        try {
            // 2. 削除するデータを Bean.Score オブジェクトに詰め替える
            Score score = new Score();
            score.setStudentId(studentId);
            score.setSubjectCd(subjectCd);
            score.setSchoolCd(schoolCd);
            score.setNo(Integer.parseInt(noStr));

            // 3. ScoreDAO を呼び出して削除処理を実行
            ScoreDAO dao = new ScoreDAO();
            dao.delete(score);

            // 4. 削除完了後、一覧表示のActionへリダイレクト
            // ※お使いの環境のURL体系（.actionなど）に合わせて調整してください
            response.sendRedirect(request.getContextPath() + "/ScoreListServlet.action");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
