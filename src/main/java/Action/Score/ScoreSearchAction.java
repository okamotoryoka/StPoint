package Action.Score;

import java.util.ArrayList;
import java.util.List;

import Bean.Score;
import DAO.Score.ScoreDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreSearchAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String entYear = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");
        String subjectCd = request.getParameter("subjectCd");
        String studentId = request.getParameter("studentId");
        String noStr = request.getParameter("no");

        ScoreDAO dao = new ScoreDAO();
        request.setAttribute("subjectList", dao.getSubjectList());
        request.setAttribute("entYearList", dao.getEntYearList());
        request.setAttribute("classList", dao.getClassNumList());

        boolean isAllEmpty = (entYear == null || entYear.isEmpty()) &&
                             (classNum == null || classNum.isEmpty()) &&
                             (subjectCd == null || subjectCd.isEmpty()) &&
                             (studentId == null || studentId.isEmpty()) &&
                             (noStr == null || noStr.isEmpty());

        List<Score> list;
        if (isAllEmpty) {
            list = new ArrayList<>();
        } else {
            // 5つの引数で正しく呼び出す
            list = dao.search(entYear, classNum, subjectCd, studentId, noStr);
        }
        
        request.setAttribute("list", list);
        request.setAttribute("isFirstAccess", false);
        request.setAttribute("entYear", entYear);
        request.setAttribute("classNum", classNum);
        request.setAttribute("subjectCd", subjectCd);
        request.setAttribute("studentId", studentId);
        request.setAttribute("no", noStr);

        request.getRequestDispatcher("/management/score_list.jsp").forward(request, response);
    }
}