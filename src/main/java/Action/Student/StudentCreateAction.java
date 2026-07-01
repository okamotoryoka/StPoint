package Action.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentCreateAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        StudentDAO dao = new StudentDAO();
        // DBから年度とクラス、および学年のリストを取得して渡す
        request.setAttribute("entYears", dao.getEntYears());
        request.setAttribute("classNums", dao.getClassNums());
        request.setAttribute("grades", dao.getGrades()); // 追加: 学年リストをリクエストに設定
        
        request.getRequestDispatcher("/result/student_create.jsp").forward(request, response);
    }
}
