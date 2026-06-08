package Action.Subject;

import Bean.School;
import Bean.Subject;
import DAO.Subject.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. フォームからの入力値を受け取る
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");
        
        // ログインセッションから学校情報を取得
        School school = (School) request.getSession().getAttribute("school");

        // 2. クラス図の構造通りにSubjectオブジェクトを組み立てる
        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);
        subject.setSchool(school);

        // 3. DAOを呼び出してデータベースへ保存
        SubjectDAO sDao = new SubjectDAO();
        
        // 事前に重複チェックを行う（エラー対策）
        if (sDao.get(cd, school) != null) {
            request.setAttribute("error", "入力された科目コードは既に登録されています。");
            request.getRequestDispatcher("subject_create.jsp").forward(request, response);
            return;
        }

        boolean isSuccess = sDao.save(subject);

        if (isSuccess) {
            // 登録成功時は科目一覧画面へリダイレクト
            response.sendRedirect("SubjectList.action"); 
        } else {
            // 登録失敗時
            request.setAttribute("error", "登録に失敗しました。");
            request.getRequestDispatcher("/subject/subject_create.jsp").forward(request, response);
        }
    }
}