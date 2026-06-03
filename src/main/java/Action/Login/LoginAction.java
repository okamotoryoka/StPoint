package Action.Login;

import Bean.Admin;
import Bean.Teacher;
import DAO.Admin.AdminDAO; // インポート文を戻しました
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

        username = username.trim();
        pass = pass.trim();

        // 呼び出し部分からパッケージ名を排除し、単純なクラス名での生成に変更しました
        AdminDAO dao = new AdminDAO();
        Admin admin = dao.search(username, pass);

        // ログイン成功時の処理
        if (admin != null) {
            Teacher user = new Teacher();
            user.setId(admin.getId());         
            user.setName(admin.getName());     
            user.setSchool(admin.getSchool()); 

            session.setAttribute("user", user); 
            
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
