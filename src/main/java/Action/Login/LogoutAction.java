package Action.Login;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LogoutAction extends Action {

    @Override
    public void execute(
        HttpServletRequest request, HttpServletResponse response
    ) throws Exception {

        HttpSession session = request.getSession();

        // ★ 教員（teacher）としてログインしているかチェックします
        if (session.getAttribute("teacher") != null) {

            // ★ セッションに保存した教員に関連するデータをすべて破棄します
            // もしくは session.invalidate(); でセッションごと丸ごと消去しても大丈夫です
            session.removeAttribute("user");
            session.removeAttribute("teacher");
            session.removeAttribute("school");
            session.removeAttribute("teacher_name");

            // ログアウト成功ページへフォワード
            request.getRequestDispatcher("login/logout-out.jsp").forward(request, response);
            return;
        }

        // すでにログアウトしている（セッションがない）場合
        request.getRequestDispatcher("logout-error.jsp").forward(request, response);
    }
}
