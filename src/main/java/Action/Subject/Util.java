package Action.Subject;

import java.util.List;

import Bean.School;
import Bean.Subject;
import Bean.Teacher;
import DAO.Subject.SubjectDAO; // お使いのDAOのクラス名（大文字・小文字）に合わせてください
import jakarta.servlet.http.HttpServletRequest;

public class Util {

    // クラス図通り、引数がHttpServletRequestで、戻り値がTeacherのメソッド
    public static Teacher getUser(HttpServletRequest request) {
        // セッションから "user" を取得して Teacher 型にキャストして返す
        return (Teacher) request.getSession().getAttribute("user");
    }

    // --- ここから下を設計図通りに実装します ---

    public static void setSubjects(HttpServletRequest request) {
        try {
            // 1. セッションからログイン中の教員情報と、所属する学校情報を取得
            Teacher teacher = getUser(request);
            if (teacher != null) {
                School school = teacher.getSchool();
                
                // 2. SubjectDAOを使ってデータベースから該当する学校の科目一覧を取得
                SubjectDAO subjectDao = new SubjectDAO();
                List<Subject> list = subjectDao.filter(school);
                
                // 3. JSP（subject_list.jsp）が受け取る名前「"subjects"」でリクエストにセット
                request.setAttribute("subjects", list);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 今回は使わない他のメソッドも、コンパイルエラーを防ぐために残しておきます
    public static void setClassNumSet(HttpServletRequest request) {}
    public static void setEntYearSet(HttpServletRequest request) {}
    public static void setNumSet(HttpServletRequest request) {}
}
