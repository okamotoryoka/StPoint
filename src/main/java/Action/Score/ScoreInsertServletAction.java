package Action.Score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreInsertServletAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String studentNo = request.getParameter("student_id");
        String studentName = request.getParameter("student_name"); // ★警告なしで使用します
        String subjectName = request.getParameter("subject_name");
        String schoolCd = request.getParameter("school_cd");
        String classNum = request.getParameter("class_num");
        int no = Integer.parseInt(request.getParameter("no"));
        int point = Integer.parseInt(request.getParameter("point"));

        try {
            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

            try (Connection con = ds.getConnection()) {
                
                // -------------------------------------------------------------
                // 【新規追加機能】STUDENTテーブルに生徒が存在するかチェック
                // -------------------------------------------------------------
                boolean studentExists = false;
                String checkStudentSql = "SELECT NO FROM STUDENT WHERE NO = ? AND SCHOOL_CD = ?";
                try (PreparedStatement st = con.prepareStatement(checkStudentSql)) {
                    st.setString(1, studentNo);
                    st.setString(2, schoolCd);
                    try (ResultSet rs = st.executeQuery()) {
                        if (rs.next()) {
                            studentExists = true;
                        }
                    }
                }

                // まだ存在しない新しい生徒だったら、自動でSTUDENTテーブルに名前を登録する
                if (!studentExists) {
                    String insertStudentSql = 
                        "INSERT INTO STUDENT (NO, NAME, SCHOOL_CD, CLASS_NUM, ENT_YEAR, IS_ATTEND) " +
                        "VALUES (?, ?, ?, ?, 2026, true)"; 
                    try (PreparedStatement st = con.prepareStatement(insertStudentSql)) {
                        st.setString(1, studentNo);
                        st.setString(2, studentName); // ここで変数を使用！
                        st.setString(3, schoolCd);
                        st.setString(4, classNum);
                        st.executeUpdate();
                    }
                }
                // -------------------------------------------------------------

                String subjectCd = null;
                String subjectSql =
                        "SELECT CD "
                      + "FROM SUBJECT "
                      + "WHERE NAME = ? "
                      + "AND SCHOOL_CD = ?";

                try (PreparedStatement st = con.prepareStatement(subjectSql)) {
                    st.setString(1, subjectName);
                    st.setString(2, schoolCd);

                    try (ResultSet rs = st.executeQuery()) {
                        if (rs.next()) {
                            subjectCd = rs.getString("CD");
                        }
                    }
                }

                if (subjectCd == null) {
                    response.setContentType("text/html; charset=UTF-8");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().println("科目名が存在しません");
                    return null;
                }

                // TESTテーブルへの登録（エラーの出ない正しい6項目のSQLに戻しました）
                String sql =
                        "INSERT INTO TEST "
                      + "(STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) "
                      + "VALUES (?, ?, ?, ?, ?, ?)";

                try (PreparedStatement st = con.prepareStatement(sql)) {
                    st.setString(1, studentNo);
                    st.setString(2, subjectCd);
                    st.setString(3, schoolCd);
                    st.setInt(4, no);
                    st.setInt(5, point);
                    st.setString(6, classNum);
                    st.executeUpdate();
                }
            }

            return "ScoreListServlet.action";

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
