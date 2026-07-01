package Action.Score;

import java.util.List;
import java.util.Map;

import Bean.Score;
import DAO.Score.ScoreDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreSearchAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            // 1. 画面で選ばれた検索条件を取得
            String entYear = request.getParameter("entYear");
            String classNum = request.getParameter("classNum");
            String subjectCd = request.getParameter("subjectCd");
            String noStr = request.getParameter("no");
            String gradeStr = request.getParameter("grade"); // ★追加: 学年のパラメータ取得

            ScoreDAO dao = new ScoreDAO();
            
            // 2. セレクトボックスを維持するために各種リストを再取得
            List<Map<String, String>> subjectList = dao.getSubjectList();
            request.setAttribute("subjectList", subjectList);

            List<String> entYearList = dao.getEntYearList();
            request.setAttribute("entYearList", entYearList);

            // 💡【ここを追加】データベースからクラス番号の一覧を取得してJSPに送る
            List<String> classNumList = dao.getClassNumList();
            request.setAttribute("classList", classNumList); // JSP側では "classList" として受け取ります

            // ★追加: データベースから学年の一覧を取得してJSPに送る（プルダウン維持用）
            List<String> gradeList = dao.getGradeList();
            request.setAttribute("gradeList", gradeList);

            // 3. 条件を渡してデータベースから絞り込んだ結果を取得
            // 💡修正: 5番目の引数に学年（gradeStr）を渡すように更新
            List<Score> list = dao.search(entYear, classNum, subjectCd, noStr, gradeStr);
            request.setAttribute("list", list);
            
            // 🌟重要：検索が行われたので、初回アクセスフラグを false にしてテーブルを表示させる
            request.setAttribute("isFirstAccess", false);

            // 4. 選んだ条件をそのまま画面に保持させる
            request.setAttribute("entYear", entYear);
            request.setAttribute("classNum", classNum);
            request.setAttribute("subjectCd", subjectCd);
            request.setAttribute("no", noStr);
            request.setAttribute("grade", gradeStr); // ★追加: 選んだ学年を画面に保持させる

            request.getRequestDispatcher("/management/score_list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
