package score;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns={"/score/insert"})
public class ScoreInsertServlet extends HttpServlet {

    public void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String studentNo =
                request.getParameter("student_id");

        // 科目名を受け取る
        String subjectName =
                request.getParameter("subject_name");

        String schoolCd =
                request.getParameter("school_cd");

        String classNum =
                request.getParameter("class_num");

        int no =
                Integer.parseInt(
                        request.getParameter("no"));

        int point =
                Integer.parseInt(
                        request.getParameter("point"));

        try {

            InitialContext ic =
                    new InitialContext();

            DataSource ds =
                    (DataSource) ic.lookup(
                            "java:/comp/env/jdbc/stpoint");

            try (Connection con =
                    ds.getConnection()) {

                // 科目コード取得
                String subjectCd = null;

                String subjectSql =
                        "SELECT CD "
                      + "FROM SUBJECT "
                      + "WHERE NAME = ?";

                try (
                    PreparedStatement st =
                            con.prepareStatement(subjectSql)
                ) {

                    st.setString(1, subjectName);

                    try (
                        ResultSet rs =
                                st.executeQuery()
                    ) {

                        if (rs.next()) {
                            subjectCd =
                                    rs.getString("CD");
                        }
                    }
                }

                // 科目が存在しない場合
                if (subjectCd == null) {

                    response.getWriter().println(
                            "科目名が存在しません");

                    return;
                }

                // TEST登録
                String sql =
                        "INSERT INTO TEST "
                      + "(STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) "
                      + "VALUES (?, ?, ?, ?, ?, ?)";

                try (
                    PreparedStatement st =
                            con.prepareStatement(sql)
                ) {

                    st.setString(1, studentNo);
                    st.setString(2, subjectCd);
                    st.setString(3, schoolCd);
                    st.setInt(4, no);
                    st.setInt(5, point);
                    st.setString(6, classNum);

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