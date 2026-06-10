package Action.Score;

import java.util.ArrayList;

import Bean.Score;
import DAO.Score.ScoreDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreListServletAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            ScoreDAO dao = new ScoreDAO();
            
            // ★修正：年度、クラス、科目のすべてのリストを取得してセットする
            request.setAttribute("entYearList", dao.getEntYearList());
            request.setAttribute("classList", dao.getClassList());
            request.setAttribute("subjectList", dao.getSubjectList());

            // 検索結果は空にしておく
            request.setAttribute("list", new ArrayList<Score>());
            
            // 初回アクセスフラグを true にする
            request.setAttribute("isFirstAccess", true);
            
            request.getRequestDispatcher("/management/score_list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}