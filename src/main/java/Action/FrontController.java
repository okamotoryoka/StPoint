package Action;

import java.io.IOException;

import Action.Login.LoginAction;
import Action.Login.LogoutAction;
import Action.Score.ScoreInsertServletAction;
import Action.Score.ScoreListServletAction;
import Action.Score.ScoreUpdateServletAction;
import Action.Student.StudentCreateAction;
import Action.Student.StudentCreateExecuteAction;
import Action.Student.StudentListAction;
import Action.Student.StudentSearchAction;
import Action.Student.StudentUpdatExecuteAction;
import Action.Student.StudentUpdateAction;
import Action.Subject.SubjectCreateAction;
import Action.Subject.SubjectCreateExecuteAction;
import Action.Subject.SubjectListAction;
import Action.Subject.SubjectUpdateAction;
import Action.Subject.SubjectUpdateExecuteAction;
import Action.Test.TestRegistAction;
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
            } 
            else if (path.equals("/StudentSearch.action")) {
                action = new StudentSearchAction();
            } 

            else if (path.equals("/ScoreListServlet.action")) {
            	action = new ScoreListServletAction();
            }
            
            else if (path.equals("/ScoreUpdateServlet.action")) {
            	action = new ScoreUpdateServletAction();
            }
            
            else if (path.equals("/ScoreInsertServlet.action")) {
            	action = new ScoreInsertServletAction();
            }
            // 【修正】/ を追加してURL判定の不具合を防ぎます
            else if (path.equals("/SubjectList.action")) {
            	action = new SubjectListAction();
            }
            
            else if (path.equals("/TestRegist.action")) {
            	action = new TestRegistAction();
            }
            
            else if (path.equals("/SubjectCreate.action")) {
                action = new SubjectCreateAction();
            }
            else if (path.equals("/SubjectCreateExecute.action")) {
                action = new SubjectCreateExecuteAction();
            }
            
         // --- 科目更新画面の表示用 ---
            else if (path.equals("/SubjectUpdate.action")) {
                action = new SubjectUpdateAction();
            }
            // --- 科目更新の実行用 ---
            else if (path.equals("/SubjectUpdateExecute.action")) {
                action = new SubjectUpdateExecuteAction();
            }

            
            if (action == null) {
                response.sendError(404, "Action not found: " + path);
                return;
            }

            // --- 【修正】アクションの実行のみをおこないます ---
            // 各Actionクラスがメソッドの内部で自ら forward または sendRedirect を実行します。
            action.execute(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
