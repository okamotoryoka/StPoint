package Action.Error;

import java.util.List;
import java.util.Map;

import DAO.Score.ErrorPostDAO;
import DAO.Score.ScoreDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ErrorPostListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 検索プルダウン用に、既存のScoreDAOから科目リストを取得してセットする
        ScoreDAO scoreDao = new ScoreDAO();
        request.setAttribute("subjects", scoreDao.getSubjectList());

        // 2. 画面の検索フォームから送信されてきたパラメータを回収する
        String subjectCd = request.getParameter("subjectCd");
        String keyword = request.getParameter("keyword");

        // 3. 検索条件をもとに、エラー投稿テーブルから一覧データを取得する
        ErrorPostDAO errorDao = new ErrorPostDAO();
        
        // 初めて画面を開いたとき（初期状態）は全件表示、ボタンが押されたときは条件絞り込みになります
        List<Map<String, Object>> errorPosts = errorDao.searchPosts(subjectCd, keyword);
        
        // 4. 検索結果と、ユーザーが今選択している検索条件をJSPに引き渡す（選択状態をキープするため）
        request.setAttribute("errorPosts", errorPosts);
        request.setAttribute("selectedSubject", subjectCd);
        request.setAttribute("selectedKeyword", keyword);

        // 5. エラー検索・一覧表示画面のJSPへフォワード
        request.getRequestDispatcher("/result/error_post_list.jsp").forward(request, response);
    }
}
