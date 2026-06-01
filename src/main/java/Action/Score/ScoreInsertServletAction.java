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
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String studentNo = request.getParameter("student_id");
        String studentName = request.getParameter("student_name"); 
        String subjectName = request.getParameter("subject_name");
        String schoolCd = request.getParameter("school_cd");
        String classNum = request.getParameter("class_num");
        
        // 1. null stringエラーを防ぐため、一度文字列として取得します
        String noStr = request.getParameter("no");
        String pointStr = request.getParameter("point");

        // 2. 画面を初めて開いたとき（値がnullのとき）
        if (noStr == null || pointStr == null) {
            // 【修正】値は返さず、その場で直接JSPへフォワードして処理を終了します
            request.getRequestDispatcher("/management/score_insert.jsp").forward(request, response); 
            return; 
        }

        // 3. 値がちゃんと存在するときだけ、安全に数字に変換します
        int no = Integer.parseInt(noStr);
        int point = Integer.parseInt(pointStr);

        try {
            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

            try (Connection con = ds.getConnection()) {
                
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

                if (!studentExists) {
                    String insertStudentSql = 
                        "INSERT INTO STUDENT (NO, NAME, SCHOOL_CD, CLASS_NUM, ENT_YEAR, IS_ATTEND) " +
                        "VALUES (?, ?, ?, ?, 2026, true)"; 
                    try (PreparedStatement st = con.prepareStatement(insertStudentSql)) {
                        st.setString(1, studentNo);
                        st.setString(2, studentName); 
                        st.setString(3, schoolCd);
                        st.setString(4, classNum);
                        st.executeUpdate();
                    }
                }

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
                    // 【修正】値を返さない単なる return; に変更します
                    return; 
                }

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

            // 【修正】データの追加が成功した後は、その場でリダイレクトを行います
            response.sendRedirect("ScoreListServlet.action");

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
