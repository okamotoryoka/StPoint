package Action.Student;

import Bean.School; // クラス図のStudentがSchoolを保持しているためインポート
import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

// クラス名を「StudentUpdateExecuteAction」に修正
public class StudentUpdatExecuteAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. パラメータを受け取る
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String entYearStr = request.getParameter("entYear");
        
        // 新規登録のパラメータ名に合わせて「classNum」に修正（JSPと一致しているか要確認）
        String classNum = request.getParameter("classNum");
        
        // JSPでチェックボックスにチェックがついている時だけ「true」にする判定
        boolean isAttend = request.getParameter("isAttend") != null;

        // 入力値をリクエストに保持（エラーで戻った際、入力を復元できるようにする）
        request.setAttribute("no", no);
        request.setAttribute("name", name);
        request.setAttribute("entYear", entYearStr);
        request.setAttribute("classNum", classNum);

        // 必須チェック（氏名が未入力の場合）
        if (name == null || name.isEmpty()) {
            request.setAttribute("err", "required");
            return "result/student_update.jsp";
        }

        // 数値変換チェックとtry-catchによるエラー対策
        int entYear = 0;
        try {
            if (entYearStr != null && !entYearStr.isEmpty()) {
                entYear = Integer.parseInt(entYearStr);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("err", "year_invalid");
            return "result/student_update.jsp";
        }

        // 2. Studentオブジェクトに変更内容をセット
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntYear(entYear);
        student.setClassNum(classNum);
        student.setAttend(isAttend); 
        
        // エラー対策：前回同様、StudentDAOの内部仕様やNullPointerException防止のためSchoolをセット
        School school = new School();
        school.setCd("tes");
        student.setSchool(school);

        // 3. データベースへの更新処理を実行
        StudentDAO sDAO = new StudentDAO();
        
        try {
            boolean isSuccess = sDAO.update(student); 
            if (!isSuccess) {
                request.setAttribute("err", "update_failed");
                return "result/student_update.jsp";
            }
        } catch (Exception e) {
            request.setAttribute("err", "update_failed");
            return "result/student_update.jsp";
        }

        // 4. 学生更新完了画面を表示する
        return "result/student_update_done.jsp";
    }
}
