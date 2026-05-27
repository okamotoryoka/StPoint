package Action.Admin;

import Bean.Admin;
import DAO.Admin.AdminDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action; // ← インポートが必要


public class AdminLoginAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String admin_name = request.getParameter("admin_name");
        String pass = request.getParameter("password");

        // 未入力チェック
        if (admin_name == null || admin_name.isBlank() || pass == null || pass.isBlank()) {
            return "login/login-error.jsp"; // 3. return でパスを返す
        }

        AdminDAO dao = new AdminDAO();
        Admin admin = dao.search(admin_name, pass);

        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setAttribute("admin_name", admin_name);

            return "menu.jsp"; // 成功時の遷移先
        }

        return "login/login-error.jsp"; // 失敗時の遷移先
    }
}
