package Login;

import Bean.Admin;
import DAO.Admin.AdminDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LoginAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // 画面からの入力値をすべて取得
        String admin_name = request.getParameter("admin_name");
        String teacher_name = request.getParameter("teacher_name");
        String pass = request.getParameter("password");

        HttpSession session = request.getSession();

        // 1.【最初の条件分岐】もし管理者ログインだったら
        if (admin_name != null && !admin_name.isBlank()) {
            
            // 管理者の中の未入力・エラー処理
            if (pass == null || pass.isBlank()) {
                return "login/login-error.jsp";
            }

            // 管理者の中のDAO処理
            AdminDAO dao = new AdminDAO();
            Admin admin = dao.search(admin_name, pass);

            if (admin != null) {
                session.setAttribute("admin", admin);
                session.setAttribute("admin_name", admin_name);
                session.setAttribute("user_type", "admin");
                return "menu.jsp"; // 成功
            }
            return "login/login-error.jsp"; // 失敗
            
        } // 元のエラー原因：ここでメソッド自体を閉じず、管理者のif文だけを閉じます

        // 2.【地続きの条件分岐】そうではなく、もし先生ログインだったら
        else if (teacher_name != null && !teacher_name.isBlank()) {
            
            // 先生の中の未入力・エラー処理
            if (pass == null || pass.isBlank()) {
                return "login/login-error.jsp";
            }

            // 先生の中のDAO処理
            AdminDAO dao = new AdminDAO();
            Admin admin = dao.search(teacher_name, pass);

            if (admin != null) {
                session.setAttribute("admin", admin);
                session.setAttribute("admin_name", teacher_name);
                session.setAttribute("user_type", "teacher");
                return "menu.jsp"; // 成功
            }
            return "login/login-error.jsp"; // 失敗
        }

        // 3.【最後の条件分岐】どちらの名前も入力されていない（またはその他のエラー）場合
        else {
            return "login/login-error.jsp";
        }
        
    } // すべての条件分岐（if - else if - else）が終わったここで初めてメソッドを閉じます
}
