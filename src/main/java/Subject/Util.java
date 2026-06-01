package Subject;

import Bean.Teacher; // セッションから取り出すTeacherクラスをインポート
import jakarta.servlet.http.HttpServletRequest;

public class Util {

    // ユーザー情報（教員）を取得するメソッド
    public static Teacher getUser(HttpServletRequest request) {
        return (Teacher) request.getSession().getAttribute("user");
    }

    // 他の画面で使用するスタブ（空のメソッド）
    public static void setClassNumSet(HttpServletRequest request) {}
    public static void setEntYearSet(HttpServletRequest request) {}
    public static void setSubjects(HttpServletRequest request) {}
    public static void setNumSet(HttpServletRequest request) {}
}