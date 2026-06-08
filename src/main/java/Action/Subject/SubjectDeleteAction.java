package Action.Subject;

import Bean.School;
import Bean.Subject;
import DAO.Subject.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectDeleteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. 一覧画面から送られてきた科目コード（cd）を受け取る
        String cd = request.getParameter("cd");
        
        // ログインセッションから学校情報を取得
        School school = (School) request.getSession().getAttribute("school");

        // 2. DAOを使って、削除する科目の詳細情報（科目名など）を取得する
        SubjectDAO sDao = new SubjectDAO();
        Subject subject = sDao.get(cd, school);

        // 3. 取得した科目情報をリクエストに保存する
        request.setAttribute("subject", subject);

        // 4. 削除確認画面（subject_delete.jsp）へ画面を切り替える
        request.getRequestDispatcher("/subject/subject_delete.jsp").forward(request, response);
    }
}