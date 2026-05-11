package Action.Student;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentCreateAction extends Action{
	
	   public String execute(HttpServletRequest request, HttpServletResponse response)
	            throws Exception {
		   
		   return "result/student_create.jsp";
	   }

}
