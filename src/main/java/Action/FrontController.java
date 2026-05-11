package Action;

import java.io.IOException;

import Action.Admin.AdminLoginAction;
import Action.Student.StudentCreateAction; // 追加：学生登録用
import Action.Student.StudentCreateExecuteAction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

@WebServlet("*.action")
public class FrontController extends HttpServlet {

    // GETリクエスト（画面を開くとき）でも動作するように追加
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        Action action = null;

        // --- URL（パス）による処理の振り分け ---
        try {
            if (path.equals("/AdminLogin.action")) {
                action = new AdminLoginAction();
            } 
         
            // 設計図にある「学生登録」を追加
            else if (path.equals("/StudentCreate.action")) {
                action = new StudentCreateAction();
            }
            
            else if (path.equals("/StudentCreateExecute.action")) {
                action = new StudentCreateExecuteAction();
            }

            // 該当するアクションがない場合
            if (action == null) {
                response.sendError(404, "Action not found: " + path);
                return;
            }

            // --- アクションの実行と画面遷移 ---
            //Actionに「仕事」を命じる一文
            String url = action.execute(request, response);
            
            // 指定されたJSPファイルへ移動
            request.getRequestDispatcher(url).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // エラーが発生した場合はサーバーエラーを表示
            throw new ServletException(e);
        }
    }
}
