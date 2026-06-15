package Action.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentCreateAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        StudentDAO dao = new StudentDAO();
        // DBから年度とクラスのリストを取得して渡す
        request.setAttribute("entYears", dao.getEntYears());
        request.setAttribute("classNums", dao.getClassNums());
        
        request.getRequestDispatcher("/result/student_create.jsp").forward(request, response);
    }
}