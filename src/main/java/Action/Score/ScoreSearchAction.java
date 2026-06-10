package Action.Score;

import java.util.ArrayList;

import Bean.Score;
import DAO.Score.ScoreDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreSearchAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ScoreDAO dao = new ScoreDAO();

        // 1. 【エラー防止】セレクトボックス用データを取得してセット
        request.setAttribute("entYearList", dao.getEntYearList());
        request.setAttribute("classList", dao.getClassList());
        request.setAttribute("subjectList", dao.getSubjectList());

        // 2. 検索パラメータを取得
        String entYear = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String subjectCd = request.getParameter("subjectCd");
        String no = request.getParameter("no");

        // 3. 検索実行（条件がすべて揃っている場合のみ）
        if (entYear != null && !entYear.isEmpty() && classNum != null && !classNum.isEmpty() && 
            subjectCd != null && !subjectCd.isEmpty() && no != null && !no.isEmpty()) {
            
            request.setAttribute("list", dao.search(entYear, classNum, subjectCd, no));
            // 検索後の状態を保持
            request.setAttribute("entYear", entYear);
            request.setAttribute("classNum", classNum);
            request.setAttribute("subjectCd", subjectCd);
            request.setAttribute("no", no);
        } else {
            // 初回表示や検索条件不足時は空のリストを渡す
            request.setAttribute("list", new ArrayList<Score>());
        }

        // 4. フォワード
        request.getRequestDispatcher("/management/score_list.jsp").forward(request, response);
    }
}