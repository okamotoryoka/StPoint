package Action.Subject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws jakarta.servlet.ServletException, java.io.IOException {
        
        try {
            // 同一パッケージ内にあるUtilクラスのメソッドを呼び出し、科目の全件リストを自動セット
            Util.setSubjects(request);

            // 科目管理一覧画面へフォワード
            request.getRequestDispatcher("/subject/subject_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            throw new jakarta.servlet.ServletException(e);
        }
    }
}
