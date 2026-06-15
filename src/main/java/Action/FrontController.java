package Action;

import java.io.IOException;

import Action.Login.LoginAction;
import Action.Login.LogoutAction;
import Action.Score.ScoreInsertServletAction;
import Action.Score.ScoreListServletAction;
import Action.Score.ScoreRegistAction;
import Action.Score.ScoreSearchAction;
import Action.Score.ScoreSubjectAction; // ★インポートを追加しました
import Action.Score.ScoreUpdateServletAction;
import Action.Student.StudentCreateAction;
import Action.Student.StudentCreateExecuteAction;
import Action.Student.StudentListAction;
import Action.Student.StudentSearchAction;
import Action.Student.StudentUpdatExecuteAction;
import Action.Student.StudentUpdateAction;
import Action.Subject.SubjectCreateAction;
import Action.Subject.SubjectCreateExecuteAction;
import Action.Subject.SubjectDeleteAction;
import Action.Subject.SubjectDeleteExecuteAction;
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
            
            else if (path.equals("/SubjectList.action")) {
            	action = new SubjectListAction();
            }
            
            else if (path.equals("/SubjectUpdateExecute.action")) {
            	action = new SubjectUpdateExecuteAction();
            }
            
            else if (path.equals("/SubjectUpdate.action")) {
            	action = new SubjectUpdateAction();
            }
           
            
            else if (path.equals("/SubjectCreate.action")) {
                action = new SubjectCreateAction();
            }
            else if (path.equals("/SubjectCreateExecute.action")) {
                action = new SubjectCreateExecuteAction();
            }
            
            
            else if (path.equals("/SubjectDelete.action")) {
                action = new SubjectDeleteAction();
            } 
            else if (path.equals("/SubjectDeleteExecute.action")) {
                action = new SubjectDeleteExecuteAction();
            }
            
            else if (path.equals("/ScoreSearchAction.action")) {
                action = new ScoreSearchAction();
            }

            // ★ここに ScoreSubjectAction.action 用の分岐を追加しました
            else if (path.equals("/ScoreSubjectAction.action")) {
                action = new ScoreSubjectAction();
            }

            else if (path.equals("/TestRegist.action")) {
            	action = new TestRegistAction();
            }
            
            else if (path.equals("/ScoreRegistAction.action")) {
                action = new ScoreRegistAction();
            }
            
            
            
            if (action == null) {
                response.sendError(404, "Action not found: " + path);
                return;
            }

            action.execute(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/login/db-error.jsp").forward(request, response);
        }
    }
}
