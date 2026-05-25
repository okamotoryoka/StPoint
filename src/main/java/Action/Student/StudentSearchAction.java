package Action.Student;

import java.util.List;

import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentSearchAction extends Action {

	@Override
	public String execute(
	        HttpServletRequest request,
	        HttpServletResponse response
	) throws Exception {

	    String name = request.getParameter("name");
	    String classNum = request.getParameter("classNum");
	    String sort = request.getParameter("sort");

	    if (name == null) {
	        name = "";
	    }

	    if (classNum == null) {
	        classNum = "";
	    }

	    StudentDAO dao = new StudentDAO();

	    List<Student> list =
	            dao.search(name, classNum, sort);

	    request.setAttribute("students", list);

	    return "/student/search.jsp";
	}
}