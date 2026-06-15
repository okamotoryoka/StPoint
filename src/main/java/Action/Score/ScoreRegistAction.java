package Action.Score;

import DAO.Score.ScoreDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreRegistAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            // 1. JSPから送られてきた隠しパラメータ（配列・一括データ）を取得
            String[] studentIds = request.getParameterValues("studentIds");
            String[] subjectCds = request.getParameterValues("subjectCd");
            String[] nos = request.getParameterValues("no");

            ScoreDAO dao = new ScoreDAO();

            // 2. 学生の人数分ループを回して、それぞれの点数を取得しDBを更新する
            if (studentIds != null) {
                for (int i = 0; i < studentIds.length; i++) {
                    String studentId = studentIds[i];
                    String subjectCd = subjectCds[i];
                    int no = Integer.parseInt(nos[i]);

                    // 各学生ごとの点数入力欄（point_学生番号）から値を取得
                    String pointStr = request.getParameter("point_" + studentId);
                    
                    if (pointStr != null && !pointStr.trim().isEmpty()) {
                        int point = Integer.parseInt(pointStr);
                        
                        // 💡 DAOを呼び出してデータベースの点数を更新
                        dao.save(studentId, subjectCd, no, point);
                    }
                }
            }

            // 3. 登録が完了したら、成績管理の初期画面（または検索画面）にリダイレクト、もしくはフォワードする
            // ※ここでは一度元の検索画面に戻すために、検索Actionを再度呼び出すか、完了画面へ遷移させます。
            // 今回は元の画面に戻すため、検索用Actionにフォワードします。
         // 💡 パスから「/Action/Score」を削り、シンプルな形に修正します
            request.getRequestDispatcher("/ScoreSearchAction.action").forward(request, response);


        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
