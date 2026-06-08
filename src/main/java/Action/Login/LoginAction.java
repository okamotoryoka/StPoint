package Action.Login;

import Bean.Teacher;
import DAO.Teacher.TeacherDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        HttpSession session = request.getSession();

        // 未入力チェック
        if (username == null || username.isBlank() || pass == null || pass.isBlank()) {
            request.getRequestDispatcher("/login/login-error.jsp").forward(request, response);
            return;
        }

        username = username.trim();
        pass = pass.trim();

        // 教員テーブルから検索
        TeacherDAO dao = new TeacherDAO();
        Teacher teacher = dao.search(username, pass);

        // ログイン成功時の処理
        if (teacher != null) {
            
            // 既存画面（menu.jsp等）が参照する「"user"」と、科目機能が参照する「"teacher"」に同じ教員オブジェクトを格納
            session.setAttribute("user", teacher); 
            session.setAttribute("teacher", teacher); 
            
            // 科目一覧・更新画面が要求する「"school"」オブジェクトを格納
            session.setAttribute("school", teacher.getSchool()); 
            
            // 不要なadmin情報を削除し、教員名のみをセッションに格納
            session.setAttribute("teacher_name", teacher.getTeacherName());
            
            // 前と全く同じリダイレクト処理
            response.sendRedirect("menu.jsp");
            return;
        }

        // ログイン失敗時
        request.getRequestDispatcher("/login/login-error.jsp").forward(request, response);
        return;
    } 
}
