package Subject;

import java.util.List;

import Bean.School;
import Bean.Subject;
import Bean.Teacher;
import DAO.Subject.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws jakarta.servlet.ServletException, java.io.IOException {
        
        try {
            Teacher teacher = Util.getUser(request);
            School school = teacher.getSchool();
            
            SubjectDAO subjectDao = new SubjectDAO();
            List<Subject> subjectList = subjectDao.filter(school);
            
            request.setAttribute("subjectList", subjectList);
            
            request.getRequestDispatcher("/WEB-INF/subject/subject_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            throw new jakarta.servlet.ServletException(e);
        }
    }
}
