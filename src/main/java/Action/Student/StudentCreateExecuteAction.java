package Action.Student;

import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentCreateExecuteAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // パラメータの取得
        String name = request.getParameter("name");
        String no = request.getParameter("no");
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");

        // 1. 必須チェック
        if (no == null || no.isEmpty() || name == null || name.isEmpty()) {
            request.setAttribute("err", "required");
            return "result/student_create.jsp";
        }

        StudentDAO dao = new StudentDAO();

        // 2. ★重複チェック（クラス図の get メソッドを使用）
        if (dao.get(no) != null) {
            // 既に学籍番号が存在する場合
            request.setAttribute("err", "insert"); // JSPの「学籍番号重複など」を表示させる
            return "result/student_create.jsp";
        }

        // 3. 数値チェックとBean作成
        int entYear;
        try {
            entYear = Integer.parseInt(entYearStr);
        } catch (NumberFormatException e) {
            request.setAttribute("err", "year");
            return "result/student_create.jsp";
        }

        Student s = new Student();
        s.setNo(no);
        s.setName(name);
        s.setEntYear(entYear);
        s.setClassNum(classNum);
        s.setIsAttend(true);

        // 4. 保存処理
        try {
            boolean isSuccess = dao.postFilter(s);
            if (isSuccess) {
                request.setAttribute("ok", "1");
            } else {
                request.setAttribute("err", "insert");
            }
        } catch (Exception e) {
            request.setAttribute("err", "insert");
        }

        return "result/student-result.jsp";
    }
}
