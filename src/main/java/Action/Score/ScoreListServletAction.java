package Action.Score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreListServletAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

            try (Connection con = ds.getConnection()) {
                String sql =
                    "SELECT " +
                    "t.STUDENT_NO AS student_id, " +
                    "st.NAME AS student_name, " +
                    "sub.NAME AS subject_name, " +
                    "t.SUBJECT_CD AS subject_cd, " +
                    "t.SCHOOL_CD AS school_cd, " +
                    "t.NO AS no, " +
                    "t.POINT AS point, " +
                    "t.CLASS_NUM AS class_num " +
                    "FROM TEST t " +
                    "LEFT JOIN STUDENT st " +
                    "ON t.STUDENT_NO = st.NO " + // 
                    "AND t.SCHOOL_CD = st.SCHOOL_CD " +
                    "LEFT JOIN SUBJECT sub " +
                    "ON t.SUBJECT_CD = sub.CD " +
                    "AND t.SCHOOL_CD = sub.SCHOOL_CD";

                ArrayList<Map<String, Object>> list = new ArrayList<>();

                try (PreparedStatement st = con.prepareStatement(sql);
                     ResultSet rs = st.executeQuery()) {

                    while (rs.next()) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("student_id", rs.getString("student_id"));
                        map.put("student_name", rs.getString("student_name") == null ? "未登録" : rs.getString("student_name"));
                        map.put("subject_name", rs.getString("subject_name"));
                        map.put("subject_cd", rs.getString("subject_cd"));
                        map.put("school_cd", rs.getString("school_cd"));
                        map.put("no", rs.getInt("no"));
                        map.put("point", rs.getInt("point"));
                        map.put("class_num", rs.getString("class_num"));
                        list.add(map);
                    }
                }

                request.setAttribute("list", list);
                return "/management/score_list.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
