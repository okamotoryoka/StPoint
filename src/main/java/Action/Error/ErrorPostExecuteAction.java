package Action.Error;

import DAO.Score.ErrorPostDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ErrorPostExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. 画面の入力フォームからデータを受け取る
        String subjectCd = request.getParameter("subjectCd");
        String unitName = request.getParameter("unitName");
        String errorTitle = request.getParameter("errorTitle");
        String errorDetail = request.getParameter("errorDetail");
        String solution = request.getParameter("solution");

        // 入力チェック（必須項目が空でないか）
        if (subjectCd != null && !subjectCd.isEmpty() &&
            unitName != null && !unitName.isEmpty() &&
            errorTitle != null && !errorTitle.isEmpty() &&
            solution != null && !solution.isEmpty()) {

            // 2. DAOを呼び出して、テーブル自動生成 ＆ データ挿入を実行
            ErrorPostDAO dao = new ErrorPostDAO();
            boolean isSuccess = dao.insertPost(subjectCd, unitName, errorTitle, errorDetail, solution);

            if (isSuccess) {
                request.setAttribute("message", "エラー解決方法を投稿しました！");
            } else {
                request.setAttribute("message", "投稿に失敗しました。内容を確認してください。");
            }
        } else {
            request.setAttribute("message", "未入力の必須項目があります。");
        }

        // 💡 投稿完了後は、とりあえず元の入力画面か、もしくはエラー一覧画面へフォワードします
        // （ここでは一旦入力画面に戻るようにしています。のちに一覧画面に変更可能です）
        request.getRequestDispatcher("/result/error_post_input.jsp").forward(request, response);
    }
}
