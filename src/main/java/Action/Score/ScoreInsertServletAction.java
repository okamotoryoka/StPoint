package Action.Score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import DAO.Score.ScoreDAO; // DAOをインポート
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreInsertServletAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ScoreDAO dao = new ScoreDAO();

        // 1. 常に必要なセレクトボックス用データを取得（初期表示・登録後共通）
        List<Map<String, String>> subjectList = dao.getSubjectList();
        request.setAttribute("subjectList", subjectList);
        
        List<String> classNumList = dao.getClassNumList();
        request.setAttribute("classList", classNumList);

        // 2. パラメータ取得
        String studentNo = request.getParameter("student_id");
        String studentName = request.getParameter("student_name"); 
        String subjectName = request.getParameter("subject_name");
        String schoolCd = request.getParameter("school_cd");
        String classNum = request.getParameter("class_num");
        
        String noStr = request.getParameter("no");
        String pointStr = request.getParameter("point");

        // 3. 画面を初めて開いたとき（値がnullのとき）
        if (noStr == null || pointStr == null) {
            request.getRequestDispatcher("/management/score_insert.jsp").forward(request, response); 
            return; 
        }

        // 4. 値が存在するときは登録処理へ
        try {
            int no = Integer.parseInt(noStr);
            int point = Integer.parseInt(pointStr);

            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

            try (Connection con = ds.getConnection()) {
                
                // 生徒存在確認
                boolean studentExists = false;
                String checkStudentSql = "SELECT NO FROM STUDENT WHERE NO = ? AND SCHOOL_CD = ?";
                try (PreparedStatement st = con.prepareStatement(checkStudentSql)) {
                    st.setString(1, studentNo);
                    st.setString(2, schoolCd);
                    try (ResultSet rs = st.executeQuery()) {
                        if (rs.next()) studentExists = true;
                    }
                }

                if (!studentExists) {
                    String insertStudentSql = "INSERT INTO STUDENT (NO, NAME, SCHOOL_CD, CLASS_NUM, ENT_YEAR, IS_ATTEND) VALUES (?, ?, ?, ?, 2026, true)"; 
                    try (PreparedStatement st = con.prepareStatement(insertStudentSql)) {
                        st.setString(1, studentNo);
                        st.setString(2, studentName); 
                        st.setString(3, schoolCd);
                        st.setString(4, classNum);
                        st.executeUpdate();
                    }
                }

                // 科目CD取得
                String subjectCd = null;
                String subjectSql = "SELECT CD FROM SUBJECT WHERE NAME = ? AND SCHOOL_CD = ?";
                try (PreparedStatement st = con.prepareStatement(subjectSql)) {
                    st.setString(1, subjectName);
                    st.setString(2, schoolCd);
                    try (ResultSet rs = st.executeQuery()) {
                        if (rs.next()) subjectCd = rs.getString("CD");
                    }
                }

                if (subjectCd == null) {
                    request.setAttribute("message", "科目名が存在しません");
                    request.getRequestDispatcher("/management/score_insert.jsp").forward(request, response);
                    return; 
                }

                // 成績登録
                String sql = "INSERT INTO TEST (STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) VALUES (?, ?, ?, ?, ?, ?)";
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
            response.sendRedirect("ScoreListServlet.action");

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
     
        }
        }
    }
