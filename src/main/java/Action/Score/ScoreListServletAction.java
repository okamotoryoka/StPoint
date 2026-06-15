package Action.Score;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
            
            // セレクトボックス用の科目リストだけは最初に取得して渡す
            List<Map<String, String>> subjectList = dao.getSubjectList();
            request.setAttribute("subjectList", subjectList);

            // 🌟重要：初期表示はデータを一切取得せず、空のリストを渡す
            List<Score> list = new ArrayList<>();
            request.setAttribute("list", list);
            
            // 🌟重要：初回アクセスフラグを true にしてテーブルを隠す
            request.setAttribute("isFirstAccess", true);
            
            request.getRequestDispatcher("/management/score_list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
