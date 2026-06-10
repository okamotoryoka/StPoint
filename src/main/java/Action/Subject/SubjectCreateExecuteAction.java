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
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");
        School school = (School) request.getSession().getAttribute("school");

        // 1. JSPのHTMLでrequiredがあるが、念のためサーバー側でも必須チェック
        if (cd == null || cd.isEmpty() || name == null || name.isEmpty()) {
            request.setAttribute("error", "科目コードと科目名は必須です。");
            request.getRequestDispatcher("/subject/subject_create.jsp").forward(request, response);
            return;
        }

        // 2. 文字数チェック（ここが重要：DBの制約と同じ3文字に制限）
        if (cd.length() != 3) {
            request.setAttribute("error", "科目コードは3文字で入力してください。");
            request.getRequestDispatcher("/subject/subject_create.jsp").forward(request, response);
            return;
        }

        try {
            SubjectDAO sDao = new SubjectDAO();
            
            // 3. 重複チェック
            if (sDao.get(cd, school) != null) {
                request.setAttribute("error", "その科目コードは既に登録されています。");
                request.getRequestDispatcher("/subject/subject_create.jsp").forward(request, response);
                return;
            }

            // 4. 保存処理
            Subject subject = new Subject();
            subject.setCd(cd);
            subject.setName(name);
            subject.setSchool(school);

            if (sDao.save(subject)) {
                request.getRequestDispatcher("/subject/subject_create_done.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "登録に失敗しました。");
                request.getRequestDispatcher("/subject/subject_create.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // DB接続エラーなど、予期せぬ例外はここで止めてエラーメッセージを出す
            e.printStackTrace();
            request.setAttribute("error", "システムエラーが発生しました。");
            request.getRequestDispatcher("/subject/subject_create.jsp").forward(request, response);
        }
    }
}