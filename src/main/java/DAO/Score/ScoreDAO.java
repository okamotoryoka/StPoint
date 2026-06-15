package DAO.Score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ScoreDAO {
    // 検索メソッド：JSPのMapキーと一致させる
    public List<Map<String, Object>> searchMaps(String entYear, String classNum, String subjectCd, String studentId) throws Exception {
        List<Map<String, Object>> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT st.ENT_YEAR, t.STUDENT_NO, st.NAME, t.CLASS_NUM, t.POINT " +
            "FROM TEST t " +
            "LEFT JOIN STUDENT st ON t.STUDENT_NO = st.NO " +
            "WHERE 1=1"
        );
        if (entYear != null && !entYear.isEmpty()) sql.append(" AND st.ENT_YEAR = ?");
        if (classNum != null && !classNum.isEmpty()) sql.append(" AND t.CLASS_NUM = ?");
        if (studentId != null && !studentId.isEmpty()) sql.append(" AND t.STUDENT_NO = ?");

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql.toString())) {
            int i = 1;
            if (entYear != null && !entYear.isEmpty()) pstmt.setString(i++, entYear);
            if (classNum != null && !classNum.isEmpty()) pstmt.setString(i++, classNum);
            if (studentId != null && !studentId.isEmpty()) pstmt.setString(i++, studentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("entYear", rs.getString("ENT_YEAR"));
                    map.put("classNum", rs.getString("CLASS_NUM"));
                    map.put("studentId", rs.getString("STUDENT_NO"));
                    map.put("studentName", rs.getString("NAME"));
                    map.put("score1", rs.getInt("POINT"));
                    map.put("score2", "-"); // 仮
                    list.add(map);
                }
            }
        }
        return list;
    }
}