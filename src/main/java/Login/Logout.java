package Login;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// ログアウト処理を行うクラス
public class Logout {

    // executeメソッド：FrontControllerから呼ばれる
    public String execute(
        HttpServletRequest request, HttpServletResponse response
    ) throws Exception {

        // セッションを取得
        HttpSession session = request.getSession();

        // ログインしているか確認（customerがあるか）
        if (session.getAttribute("admin_name") != null) {

            // セッションからログイン情報を削除（ログアウト）
            session.removeAttribute("admin_name");
            session.removeAttribute("password");

            // ログアウト成功ページへ
            return "logout-out.jsp";
        }

        // すでにログアウトしている場合
        return "logout-error.jsp";
    }
}