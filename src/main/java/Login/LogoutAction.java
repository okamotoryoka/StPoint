package Login;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LogoutAction extends Action {

    // 戻り値の型を String から void に変更します
    @Override
    public void execute(
        HttpServletRequest request, HttpServletResponse response
    ) throws Exception {

        HttpSession session = request.getSession();

        if (session.getAttribute("admin_name") != null) {

            session.removeAttribute("admin_name");
            session.removeAttribute("password");

            // その場で直接ログアウト成功ページへフォワードします
            request.getRequestDispatcher("login/logout-out.jsp").forward(request, response);
            return;
        }

        // すでにログアウトしている場合も直接エラーページへフォワードします
        request.getRequestDispatcher("logout-error.jsp").forward(request, response);
    }
}
