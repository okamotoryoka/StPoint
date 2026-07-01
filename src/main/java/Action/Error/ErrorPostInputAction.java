package Action.Error;

import DAO.Score.ScoreDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ErrorPostInputAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 既存のScoreDAOから科目リストを取得してリクエストにセットする
        ScoreDAO scoreDao = new ScoreDAO();
        request.setAttribute("subjects", scoreDao.getSubjectList());

        // 投稿入力画面のJSPへ移動
        request.getRequestDispatcher("/result/error_post_input.jsp").forward(request, response);
    }
}
