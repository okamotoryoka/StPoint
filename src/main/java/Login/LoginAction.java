package Login;

import Bean.Admin;
import DAO.Admin.AdminDAO;
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

        if (username == null || username.isBlank() || pass == null || pass.isBlank()) {
            request.getRequestDispatcher("/login/login-error.jsp").forward(request, response);
            return;
        }

        // 入力値の前後にスペースが含まれていた場合、自動で削除する（根本対策1）
        username = username.trim();
        pass = pass.trim();

        AdminDAO dao = new AdminDAO();
        Admin admin = dao.search(username, pass);

        if (admin != null) {
            session.setAttribute("admin", admin);
            session.setAttribute("admin_name", username);
            session.setAttribute("user_type", "admin");
            response.sendRedirect("menu.jsp");
            return;
        }

        request.getRequestDispatcher("/login/login-error.jsp").forward(request, response);
        return;
    } 
}
