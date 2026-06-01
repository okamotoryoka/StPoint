package Action;

import java.io.IOException;

import Action.Score.ScoreInsertServletAction;
import Action.Score.ScoreListServletAction;
import Action.Score.ScoreUpdateServletAction;
import Action.Student.StudentCreateAction;
import Action.Student.StudentCreateExecuteAction;
import Action.Student.StudentListAction;
import Action.Student.StudentSearchAction;
import Action.Student.StudentUpdatExecuteAction;
import Action.Student.StudentUpdateAction;
import Login.LoginAction;
import Login.LogoutAction;
// ⚠️ もしStudentSearchActionでエラーが出る場合は、ここに適切なインポート文（例: import Action.Student.StudentSearchAction;）を追加してください
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

@WebServlet("*.action")
public class FrontController extends HttpServlet {

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

        try {
            if (path.equals("/Login.action")) {
                action = new LoginAction();
            } 
            
            else if(path.equals("/Logout.action")) {
            	action = new LogoutAction();
            }
            else if (path.equals("/StudentCreate.action")) {
                action = new StudentCreateAction();
            }
            else if (path.equals("/StudentCreateExecute.action")) {
                action = new StudentCreateExecuteAction();
            }
            else if (path.equals("/StudentList.action")) {
                action = new StudentListAction();
            }
            else if (path.equals("/StudentUpdate.action")) {
                action = new StudentUpdateAction();
            }
            else if (path.equals("/StudentUpdatExecute.action")) {
                action = new StudentUpdatExecuteAction();
            } // ⭕ カッコを正しく閉じました
            else if (path.equals("/StudentSearch.action")) {
                action = new StudentSearchAction();
            } // ⭕ カッコを正しく閉じました

            else if (path.equals("/ScoreListServlet.action")) {
            	action = new ScoreListServletAction();
            }
            
            else if (path.equals("/ScoreUpdateServlet.action")) {
            	action = new ScoreUpdateServletAction();
            }
            
            else if (path.equals("/ScoreInsertServlet.action")) {
            	action = new ScoreInsertServletAction();
            }
            
            // 該当するアクションがない場合
            if (action == null) {
                response.sendError(404, "Action not found: " + path);
                return;
            }

            // --- アクションの実行と画面遷移 ---
            String url = action.execute(request, response);
            
            // 指定されたJSPファイルへ移動
            request.getRequestDispatcher(url).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
