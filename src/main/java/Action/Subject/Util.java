package Action.Subject;

import Bean.Teacher;
import jakarta.servlet.http.HttpServletRequest;

public class Util {

    // クラス図通り、引数がHttpServletRequestで、戻り値がTeacherのメソッド
    public static Teacher getUser(HttpServletRequest request) {
        // セッションから "user" を取得して Teacher 型にキャストして返す
        return (Teacher) request.getSession().getAttribute("user");
    }

    // クラス図に定義されている他のメソッド（スタブ）
    public static void setClassNumSet(HttpServletRequest request) {}
    public static void setEntYearSet(HttpServletRequest request) {}
    public static void setSubjects(HttpServletRequest request) {}
    public static void setNumSet(HttpServletRequest request) {}
}
