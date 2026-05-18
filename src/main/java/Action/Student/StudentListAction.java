package Action.Student;

import java.util.List;

import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentListAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. DAOを呼び出して、データベースから生徒一覧を取得する
        StudentDAO dao = new StudentDAO();
        List<Student> list = dao.findAll(); 
        
        // 2. 取得したリストを「students」という名前でリクエストに保存する
        request.setAttribute("students", list);
        
        // 3. 表示するJSPのパスを返す
        return "result/student_list.jsp";
    }
}
