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

    /**
     * 重複のない入学年度の一覧を降順で取得するメソッド
     */
    public List<String> getEntYearList() throws Exception {
        List<String> yearList = new ArrayList<>();
        String sql = "SELECT DISTINCT ENT_YEAR FROM STUDENT WHERE ENT_YEAR IS NOT NULL ORDER BY ENT_YEAR DESC";

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                yearList.add(rs.getString("ENT_YEAR"));
            }
        }
        return yearList;
    }

    /**
     * 重複のないクラス番号の一覧を昇順で取得するメソッド
     */
    public List<String> getClassNumList() throws Exception {
        List<String> classList = new ArrayList<>();
        String sql = "SELECT DISTINCT CLASS_NUM FROM TEST WHERE CLASS_NUM IS NOT NULL ORDER BY CLASS_NUM ASC";

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                classList.add(rs.getString("CLASS_NUM"));
            }
        }
        return classList;
    }

    /**
     * 科目マスタの一覧を取得するメソッド
     */
    public List<Map<String, String>> getSubjectList() throws Exception {
        List<Map<String, String>> subjectList = new ArrayList<>();
        String sql = "SELECT CD, NAME FROM SUBJECT ORDER BY CD";

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

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

    /**
     * 条件を指定して成績一覧を動的に検索するメソッド（確実に動かすためMap形式で返却します）
     */
    /**
     * 条件を指定して成績一覧を動的に検索するメソッド（未選択時は全件表示に対応）
     */
    /**
     * 条件を指定して成績一覧を動的に検索するメソッド（学生番号の検索に対応）
     */
    public List<Bean.Score> search(String entYear, String classNum, String subjectCd, String studentId) throws Exception {
        List<Bean.Score> list = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder(
            "SELECT " +
            "st.ENT_YEAR AS ent_year, " +
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
        
        if (entYear != null && !entYear.trim().isEmpty()) {
            sql.append(" AND st.ENT_YEAR = ?");
        }
        if (classNum != null && !classNum.trim().isEmpty()) {
            sql.append(" AND t.CLASS_NUM = ?");
        }
        if (subjectCd != null && !subjectCd.trim().isEmpty()) {
            sql.append(" AND t.SUBJECT_CD = ?");
        }
        if (studentId != null && !studentId.trim().isEmpty()) {
            sql.append(" AND t.STUDENT_NO = ?");
        }
        
        sql.append(" ORDER BY t.STUDENT_NO ASC, t.NO ASC");

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (entYear != null && !entYear.trim().isEmpty()) {
                pstmt.setString(paramIndex++, entYear);
            }
            if (classNum != null && !classNum.trim().isEmpty()) {
                pstmt.setString(paramIndex++, classNum);
            }
            if (subjectCd != null && !subjectCd.trim().isEmpty()) {
                pstmt.setString(paramIndex++, subjectCd);
            }
            if (studentId != null && !studentId.trim().isEmpty()) {
                pstmt.setString(paramIndex++, studentId);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Bean.Scoreのインスタンスを生成して値を詰める
                    Bean.Score score = new Bean.Score();
                    
                    // 💡 【ここを追加】データベースの ent_year を Java の score に詰め込みます
                    score.setEntYear(rs.getString("ent_year")); 
                    
                    score.setStudentId(rs.getString("student_id"));
                    score.setStudentName(rs.getString("student_name") == null ? "未登録" : rs.getString("student_name"));
                    score.setSubjectName(rs.getString("subject_name") == null ? "不明な科目" : rs.getString("subject_name"));
                    score.setNo(rs.getInt("no"));
                    score.setPoint(rs.getInt("point"));
                    score.setClassNum(rs.getString("class_num"));
                    score.setSubjectCd(rs.getString("subject_cd"));
                    score.setSchoolCd(rs.getString("school_cd"));
                    
                    list.add(score);
                }
            }
        }
        return list;
    }

    
    
    /**
     * 条件を指定して成績一覧を動的に検索するメソッド（確実に動かすためMap形式で返却します）
     */
    /**
     * 条件を指定して成績一覧を動的に検索するメソッド（未選択時は全件表示に対応）
     */
    /**
     * 条件を指定して成績一覧を動的に検索するメソッド（学生番号の検索に対応）
     */
    public List<Map<String, Object>> searchMaps(String entYear, String classNum, String subjectCd, String studentId) throws Exception {
        List<Map<String, Object>> list = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder(
            "SELECT " +
            "st.ENT_YEAR AS ent_year, " +
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
        
        if (entYear != null && !entYear.trim().isEmpty()) {
            sql.append(" AND st.ENT_YEAR = ?");
        }
        if (classNum != null && !classNum.trim().isEmpty()) {
            sql.append(" AND t.CLASS_NUM = ?");
        }
        if (subjectCd != null && !subjectCd.trim().isEmpty()) {
            sql.append(" AND t.SUBJECT_CD = ?");
        }
        // ★追加：学生番号が入力されている場合は条件に加える
        if (studentId != null && !studentId.trim().isEmpty()) {
            sql.append(" AND t.STUDENT_NO = ?");
        }
        
        sql.append(" ORDER BY t.STUDENT_NO ASC, t.NO ASC");

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (entYear != null && !entYear.trim().isEmpty()) {
                pstmt.setString(paramIndex++, entYear);
            }
            if (classNum != null && !classNum.trim().isEmpty()) {
                pstmt.setString(paramIndex++, classNum);
            }
            if (subjectCd != null && !subjectCd.trim().isEmpty()) {
                pstmt.setString(paramIndex++, subjectCd);
            }
            // ★追加：プレースホルダー（?）に値をセット
            if (studentId != null && !studentId.trim().isEmpty()) {
                pstmt.setString(paramIndex++, studentId);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    String dbEntYear = rs.getString("ent_year");
                    map.put("ent_year", dbEntYear == null ? "未設定" : dbEntYear);
                    map.put("student_id", rs.getString("student_id"));
                    map.put("student_name", rs.getString("student_name") == null ? "未登録" : rs.getString("student_name"));
                    map.put("subject_name", rs.getString("subject_name") == null ? "不明な科目" : rs.getString("subject_name"));
                    map.put("subject_cd", rs.getString("subject_cd"));
                    map.put("school_cd", rs.getString("school_cd"));
                    map.put("no", rs.getInt("no"));
                    map.put("point", rs.getInt("point"));
                    map.put("class_num", rs.getString("class_num"));
                    list.add(map);
                }
            }
        }
        return list;
    }


    // 既存のdeleteメソッド等、不要な箇所は省略可能ですが残してあっても問題ありません
    public int delete(Bean.Score score) throws Exception {
        int count = 0;
        String sql = "DELETE FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, score.getStudentId());
            pstmt.setString(2, score.getSubjectCd());
            pstmt.setString(3, score.getSchoolCd());
            pstmt.setInt(4, score.getNo());
            count = pstmt.executeUpdate();
        }
        return count;
    }
    
    /**
     * 指定された学生・科目・回数の点数を更新（上書き）するメソッド
     */
    public boolean save(String studentId, String subjectCd, int no, int point) throws Exception {
        // TESTテーブルの特定のレコードの点数を更新するSQL
        String sql = "UPDATE TEST SET POINT = ? WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND NO = ?";
        
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        
        int rowCount = 0;
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            pstmt.setInt(1, point);
            pstmt.setString(2, studentId);
            pstmt.setString(3, subjectCd);
            pstmt.setInt(4, no);
            
            rowCount = pstmt.executeUpdate();
        }
        // 1行以上更新できたら成功（true）を返す
        return rowCount > 0;
    }

}
