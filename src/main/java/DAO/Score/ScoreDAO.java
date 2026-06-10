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

// BeanフォルダーのScoreクラスを使用するためにインポートします
import Bean.Score;

public class ScoreDAO {

    /**
     * 条件を指定して成績一覧を動的に検索するメソッド（Bean.Scoreを使用）
     */
    public List<Score> search(String entYear, String classNum, String subjectCd, String noStr) throws Exception {
        List<Score> list = new ArrayList<>();
        
        // 1. ベースとなるSQL文
        StringBuilder sql = new StringBuilder(
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
            "LEFT JOIN STUDENT st ON t.STUDENT_NO = st.NO AND t.SCHOOL_CD = st.SCHOOL_CD " +
            "LEFT JOIN SUBJECT sub ON t.SUBJECT_CD = sub.CD AND t.SCHOOL_CD = sub.SCHOOL_CD " +
            "WHERE 1=1"
        );
        
        // 2. 動的SQLの条件追加
        if (entYear != null && !entYear.isEmpty()) {
            sql.append(" AND st.ENT_YEAR = ?");
        }
        if (classNum != null && !classNum.isEmpty()) {
            sql.append(" AND t.CLASS_NUM = ?");
        }
        if (subjectCd != null && !subjectCd.isEmpty()) {
            sql.append(" AND t.SUBJECT_CD = ?");
        }
        if (noStr != null && !noStr.isEmpty()) {
            sql.append(" AND t.NO = ?");
        }

        // 3. DataSourceの取得
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {
            
            // 4. パラメータのセット
            int paramIndex = 1;
            if (entYear != null && !entYear.isEmpty()) {
                pstmt.setString(paramIndex++, entYear);
            }
            if (classNum != null && !classNum.isEmpty()) {
                pstmt.setString(paramIndex++, classNum);
            }
            if (subjectCd != null && !subjectCd.isEmpty()) {
                pstmt.setString(paramIndex++, subjectCd);
            }
            if (noStr != null && !noStr.isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(noStr));
            }

            // 5. 検索結果を Bean.Score オブジェクトに詰め替える
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Score score = new Score();
                    score.setStudentId(rs.getString("student_id"));
                    // 名前がnullの場合は「未登録」とする判定も継承
                    score.setStudentName(rs.getString("student_name") == null ? "未登録" : rs.getString("student_name"));
                    score.setSubjectName(rs.getString("subject_name"));
                    score.setSubjectCd(rs.getString("subject_cd"));
                    score.setSchoolCd(rs.getString("school_cd"));
                    score.setNo(rs.getInt("no"));
                    score.setPoint(rs.getInt("point"));
                    score.setClassNum(rs.getString("class_num"));
                    
                    list.add(score);
                }
            }
        }
        return list;
    }
    
    public List<Map<String, String>> getSubjectList() throws Exception {
        List<Map<String, String>> subjectList = new ArrayList<>();
        String sql = "SELECT CD, NAME FROM SUBJECT ORDER BY CD";

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        // tryのカッコの中に con, pstmt, rs をすべて並べることで、処理終了後に自動で安全にクローズされます
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("cd", rs.getString("CD"));
                map.put("name", rs.getString("NAME"));
                subjectList.add(map);
            }
        }
        return subjectList;
    }
}
