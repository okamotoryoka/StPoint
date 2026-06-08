package Action.Subject;

import Bean.School;
import Bean.Subject;
import DAO.Subject.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectDeleteExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. 画面やURLパラメータから削除対象の科目コードを受け取る
        String cd = request.getParameter("cd");
        
        // ログインセッションから学校情報を取得
        School school = (School) request.getSession().getAttribute("school");

        // 2. 削除に必要な情報をSubjectオブジェクトにセット
        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setSchool(school);

        // 3. DAOを呼び出してデータベースから削除
        SubjectDAO sDao = new SubjectDAO();
        boolean isSuccess = sDao.delete(subject);

        if (isSuccess) {
            // 💡 削除成功時は、作成した削除完了JSPへフォワードする
        	request.getRequestDispatcher("/subject/subject_delete_done.jsp").forward(request, response);
        } else {
            // 削除失敗時（対象のデータが見つからなかった場合など）
            request.setAttribute("error", "削除に失敗しました。");
            request.getRequestDispatcher("/subject/subject_delete.jsp").forward(request, response);
        }
    }
}
