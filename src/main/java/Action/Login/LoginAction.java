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

        // 1. 未入力チェック
        if (username == null || username.isBlank() || pass == null || pass.isBlank()) {
            request.setAttribute("error", "教員IDとパスワードを入力してください。");
            request.getRequestDispatcher("/login/login.jsp").forward(request, response);
            return;
        }

        username = username.trim();
        pass = pass.trim();

        //   DBエラー（例外）をキャッチするための try-catch ブロック
        try {
            // 教員テーブルから検索（ここでDB接続エラーが起きる可能性がある）
            TeacherDAO dao = new TeacherDAO();
            Teacher teacher = dao.search(username, pass);

            // 2. ログイン成功時の処理
            if (teacher != null) {
                session.setAttribute("user", teacher); 
                session.setAttribute("teacher", teacher); 
                session.setAttribute("school", teacher.getSchool()); 
                session.setAttribute("teacher_name", teacher.getTeacherName());
                
                response.sendRedirect("menu.jsp");
                return;
            }

            // 3. ログイン失敗時（入力間違い）
            request.setAttribute("error", "教員IDまたはパスワードが間違っています。");
            request.getRequestDispatcher("/login/login.jsp").forward(request, response);
            return;

        } catch (Exception e) {
            // DBエラーなど予期せぬ不具合が起きた場合はここを通る
            e.printStackTrace(); // コンソールにエラー内容を出力
            
            // 新しく作った専用のエラー画面（db-error.jsp）へ遷移させる
            request.getRequestDispatcher("/login/db-error.jsp").forward(request, response);
            return;
        }
    } 
}
