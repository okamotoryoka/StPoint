package Action.Subject;

import Bean.School;   // Schoolクラスのパッケージ（同上）
import Bean.Subject;  // Subjectクラスのパッケージ（環境に合わせて bean. や bean.Subject 等に変更してください）
import DAO.Subject.SubjectDAO; // SubjectDaoクラスのパッケージ（環境に合わせて dao. や dao.SubjectDao 等に変更してください）
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;   // 親クラスである Action のインポート

public class SubjectUpdateExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // フォームからの入力値を受け取る
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");
        School school = (School) request.getSession().getAttribute("school");

        // クラス図の構造通りにインスタンスを組み立てる
        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);
        subject.setSchool(school);

        // DAOを呼び出してデータベースを更新
        SubjectDAO sDao = new SubjectDAO();
        boolean isSuccess = sDao.save(subject);

        if (isSuccess) {
            // 更新成功時の遷移（完了画面や一覧画面へリダイレクトなど）
            response.sendRedirect("SubjectList.action"); 
        } else {
            // 失敗時のエラー処理
            request.setAttribute("error", "更新に失敗しました。");
            request.getRequestDispatcher("subject_update.jsp").forward(request, response);
        }
    }
}