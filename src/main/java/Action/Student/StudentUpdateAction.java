package Action.Student;

import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentUpdateAction extends Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. 画面から学生番号を取得
        String no = req.getParameter("no");

        // 2. すべて大文字の StudentDAO を使ってデータ取得
        StudentDAO studentDAO = new StudentDAO(); 
        Student student = studentDAO.get(no);

        // 3. リクエストにセット
        req.setAttribute("student", student);

        // 4. 遷移先のJSP名を文字列（String）で返す
        return "result/student_update.jsp"; 
    }
}
