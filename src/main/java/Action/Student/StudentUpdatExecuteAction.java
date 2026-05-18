package Action.Student;

import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentUpdatExecuteAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. パラメータを受け取る
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        
        int entYear = 0;
        String entYearStr = request.getParameter("entYear");
        if (entYearStr != null && !entYearStr.isEmpty()) {
            entYear = Integer.parseInt(entYearStr);
        }
        
        String classNum = request.getParameter("classNum");
        
        // ★JSPでチェックボックスにチェックがついている時だけ「true」にする判定
        boolean isAttend = request.getParameter("isAttend") != null;

        // 2. Studentオブジェクトに変更内容をセット
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntYear(entYear);
        student.setClassNum(classNum);
        student.setAttend(isAttend); // 設計図通りのメソッド名
        
        // 3. データベースへの更新処理を実行
        StudentDAO sDAO = new StudentDAO();
        sDAO.postFilter(student); 

        // 4. 学生更新完了画面を表示する
        return "result/student_update_done.jsp";
    }
}
