package Action.Student;

import java.util.HashMap;
import java.util.Map;

import Bean.School;
import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentCreateExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. パラメータの取得
        String name = request.getParameter("name");
        String no = request.getParameter("no");
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");

        Map<String, String> errors = new HashMap<>();
        StudentDAO dao = new StudentDAO();

        // ★追加：エラー発生時に戻る画面でも必要なリストを再取得してセットする
        request.setAttribute("entYears", dao.getEntYears());
        request.setAttribute("classNums", dao.getClassNums());

        // 2. バリデーションチェック
        if (entYearStr == null || entYearStr.isEmpty()) {
            errors.put("entYear", "入学年度を選択してください");
        }
        if (no == null || no.isEmpty()) {
            errors.put("no", "学生番号を入力してください");
        } else if (dao.get(no) != null) {
            errors.put("no", "学生番号が重複しています");
        }
        if (name == null || name.isEmpty()) {
            errors.put("name", "氏名を入力してください");
        }

        // 3. エラーがある場合、情報をセットして元の画面（student_create.jsp）に戻る
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("name", name);
            request.setAttribute("no", no);
            request.setAttribute("entYear", entYearStr);
            request.setAttribute("classNum", classNum);
            request.getRequestDispatcher("/result/student_create.jsp").forward(request, response);
            return;
        }

        // 4. 正常時：データベース保存処理
        Student s = new Student();
        s.setNo(no);
        s.setName(name);
        s.setEntYear(Integer.parseInt(entYearStr));
        s.setClassNum(classNum);
        s.setAttend(true);
        School school = new School();
        school.setCd("tes");
        s.setSchool(school);

        if (dao.postFilter(s)) {
            response.sendRedirect("result/student_create_done.jsp");
        } else {
            errors.put("insert", "登録に失敗しました");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/result/student_create.jsp").forward(request, response);
        }
    }
}