package Action.Subject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectCreateAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 新規登録画面（JSP）へフォワードします
    	request.getRequestDispatcher("/subject/subject_create.jsp").forward(request, response);
    }
}