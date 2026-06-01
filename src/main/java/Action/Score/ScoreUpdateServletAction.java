package Action.Score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreUpdateServletAction extends Action {

    // 戻り値の型を String から void に変更します
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String studentNo = request.getParameter("student_id");
        String subjectCd = request.getParameter("subject_cd");
        String schoolCd = request.getParameter("school_cd");
        int no = Integer.parseInt(request.getParameter("no"));

        if (request.getMethod().equalsIgnoreCase("POST")) {
            int point = Integer.parseInt(request.getParameter("point"));
            String classNum = request.getParameter("class_num");

            try {
                InitialContext ic = new InitialContext();
                DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

                try (Connection con = ds.getConnection()) {
                    String sql = "UPDATE TEST SET POINT = ?, CLASS_NUM = ? WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
                    try (PreparedStatement st = con.prepareStatement(sql)) {
                        st.setInt(1, point);
                        st.setString(2, classNum);
                        st.setString(3, studentNo);
                        st.setString(4, subjectCd);
                        st.setString(5, schoolCd);
                        st.setInt(6, no);
                        st.executeUpdate();
                    }
                }
                // 【修正】更新成功時はリダイレクトを呼び出し、処理を終了します
                response.sendRedirect("ScoreListServlet.action");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }
        }

        try {
            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

            try (Connection con = ds.getConnection()) {
                String sql = "SELECT * FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
                Map<String, Object> data = new HashMap<>();

                try (PreparedStatement st = con.prepareStatement(sql)) {
                    st.setString(1, studentNo);
                    st.setString(2, subjectCd);
                    st.setString(3, schoolCd);
                    st.setInt(4, no);

                    try (ResultSet rs = st.executeQuery()) {
                        if (rs.next()) {
                            data.put("student_id", rs.getString("STUDENT_NO"));
                            data.put("subject_cd", rs.getString("SUBJECT_CD"));
                            data.put("school_cd", rs.getString("SCHOOL_CD"));
                            data.put("no", rs.getInt("NO"));
                            data.put("point", rs.getInt("POINT"));
                            data.put("class_num", rs.getString("CLASS_NUM"));
                        }
                    }
                }

                request.setAttribute("data", data);
                // 【修正】画面表示時は直接JSPへフォワードします
                request.getRequestDispatcher("/management/score_update.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
