package Action.Student;

import java.util.List;

import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentSearchAction extends Action {

	// 戻り値の型を String から void に変更します
	@Override
	public void execute(
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

	    // 【修正】その場で直接JSPへフォワードし、画面を表示します
	    request.getRequestDispatcher("/student/search.jsp").forward(request, response);
	}
}
