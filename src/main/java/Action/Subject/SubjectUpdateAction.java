package Action.Subject;

import Bean.School;   // Schoolクラスのパッケージ（同上）
import Bean.Subject;  // Subjectクラスのパッケージ（環境に合わせて bean. や bean.Subject 等に変更してください）
import DAO.Subject.SubjectDAO; // SubjectDaoクラスのパッケージ（環境に合わせて dao. や dao.SubjectDao 等に変更してください）
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;   // 親クラスである Action のインポート

public class SubjectUpdateAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 画面や遷移元から送られてきた科目コードと学校情報を取得
        String cd = request.getParameter("cd");
        // 本来はログインユーザーのセッション等からSchoolオブジェクトを取得
        School school = (School) request.getSession().getAttribute("school"); 

        SubjectDAO sDao = new SubjectDAO();
        Subject subject = sDao.get(cd, school); // 既存データの取得

        // リクエスト属性にセットしてJSPへ渡す
        request.setAttribute("subject", subject);
        request.getRequestDispatcher("subject_update.jsp").forward(request, response);
    }
}