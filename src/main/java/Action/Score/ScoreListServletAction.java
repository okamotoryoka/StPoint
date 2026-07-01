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
            
            // 💡 検索画面と同じリスト取得処理をすべて追加
            List<Map<String, String>> subjectList = dao.getSubjectList();
            request.setAttribute("subjectList", subjectList);

            List<String> entYearList = dao.getEntYearList();
            request.setAttribute("entYearList", entYearList);

            List<String> classNumList = dao.getClassNumList();
            request.setAttribute("classList", classNumList);

            // ★追加: 画面のプルダウン用に重複のない学年リストを取得してセット
            List<String> gradeList = dao.getGradeList();
            request.setAttribute("gradeList", gradeList);

            // 初期表示はデータを一切取得せず、空のリストを渡す
            List<Score> list = new ArrayList<>();
            request.setAttribute("list", list);
            
            // 初回アクセスフラグを true にしてテーブルを隠す
            request.setAttribute("isFirstAccess", true);
            
            request.getRequestDispatcher("/management/score_list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
