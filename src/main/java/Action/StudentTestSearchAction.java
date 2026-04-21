package Action;

import java.util.List;

import Bean.Test;
import DAO.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action; // ←

public class StudentTestSearchAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String studentNo = request.getParameter("student_no");
        
        TestDAO dao = new TestDAO();
        List<Test> testList = dao.findByStudentNoJoin(studentNo);
        
        request.setAttribute("testList", testList);
        request.setAttribute("studentNo", studentNo);
        
        return "/result/student-test-list.jsp";
    }
}