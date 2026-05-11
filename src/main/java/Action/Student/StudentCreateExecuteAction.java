package Action.Student;

import DAO.Student.StudentDAO;
import bean.Student;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentCreateExecuteAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String name = request.getParameter("name");
        String no = request.getParameter("no");
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");

        // 1. 必須チェック
        if (no == null || no.trim().isEmpty() || name == null || name.trim().isEmpty()) {
            request.setAttribute("err", "required");
            return "result/student_create.jsp"; // 入力画面へ
        }

        // 2. 数値チェック
        int entYear = 0;
        try {
            entYear = Integer.parseInt(entYearStr);
        } catch (NumberFormatException e) {
            request.setAttribute("err", "year");
            return "result/student_create.jsp"; // 入力画面へ
        }

        // 3. 保存処理
        Student s = new Student();
        s.setNo(no);
        s.setName(name);
        s.setEntYear(entYear);
        s.setClassNum(classNum);
        s.setIsAttend(true);

        try {
            StudentDAO dao = new StudentDAO();
            dao.insert(s);
            // ★成功しても入力画面に戻り、「ok」という合図を送る
            request.setAttribute("ok", "1"); 
            return "result/student_create.jsp"; 
        } catch (Exception e) {
            request.setAttribute("err", "insert");
            return "result/student_create.jsp"; // 入力画面へ
        }
    }
}
