package Action.Score;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns={"/score/delete"})
public class ScoreDeleteServlet extends HttpServlet {

    public void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String studentNo =
                request.getParameter("student_id");

        String subjectCd =
                request.getParameter("subject_cd");

        String schoolCd =
                request.getParameter("school_cd");

        int no =
                Integer.parseInt(
                        request.getParameter("no"));

        try {

            InitialContext ic =
                    new InitialContext();

            DataSource ds =
                    (DataSource) ic.lookup(
                            "java:/comp/env/jdbc/stpoint");

            try (Connection con =
                    ds.getConnection()) {

                String sql =
                        "DELETE FROM TEST "
                      + "WHERE STUDENT_NO = ? "
                      + "AND SUBJECT_CD = ? "
                      + "AND SCHOOL_CD = ? "
                      + "AND NO = ?";

                try (
                    PreparedStatement st =
                            con.prepareStatement(sql)
                ) {

                    st.setString(1, studentNo);
                    st.setString(2, subjectCd);
                    st.setString(3, schoolCd);
                    st.setInt(4, no);

                    st.executeUpdate();
                }
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/score/list");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}