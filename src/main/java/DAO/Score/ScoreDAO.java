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
     * 追加: 重複のない学年の一覧を昇順で取得するメソッド（画面のプルダウン用）
     */
    public List<String> getGradeList() throws Exception {
        List<String> gradeList = new ArrayList<>();
        String sql = "SELECT DISTINCT GRADE FROM STUDENT WHERE GRADE IS NOT NULL ORDER BY GRADE ASC";

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                gradeList.add(rs.getString("GRADE"));
            }
        }
        return gradeList;
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
     * 条件を指定して成績一覧を動的に検索するメソッド（学年絞り込み対応版）
     */
    public List<Bean.Score> search(String entYear, String classNum, String subjectCd, String noStr, String gradeStr) throws Exception {
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
            "t.CLASS_NUM AS class_num, " +
            "st.GRADE AS grade " + // 追加: SELECT項目に学生の学年を追加
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
        if (noStr != null && !noStr.trim().isEmpty()) {
            sql.append(" AND t.NO = ?");
        }
        // 追加: 学年の絞り込み条件
        if (gradeStr != null && !gradeStr.trim().isEmpty()) {
            sql.append(" AND st.GRADE = ?");
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
            if (noStr != null && !noStr.trim().isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(noStr));
            }
            // 追加: 学年のプレースホルダーへのデータセット
            if (gradeStr != null && !gradeStr.trim().isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(gradeStr));
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Bean.Score score = new Bean.Score();
                    
                    score.setEntYear(rs.getString("ent_year")); 
                    score.setStudentId(rs.getString("student_id"));
                    score.setStudentName(rs.getString("student_name") == null ? "未登録" : rs.getString("student_name"));
                    score.setSubjectName(rs.getString("subject_name") == null ? "不明な科目" : rs.getString("subject_name"));
                    score.setNo(rs.getInt("no"));
                    score.setPoint(rs.getInt("point"));
                    score.setClassNum(rs.getString("class_num"));
                    score.setSubjectCd(rs.getString("subject_cd"));
                    score.setSchoolCd(rs.getString("school_cd"));
                    score.setGrade(rs.getInt("grade")); 
                    
                    // 💡 もし Bean.Score 側にも setGrade メソッドを将来的に作る場合は、ここで rs.getInt("grade") をセット可能です。
                    
                    list.add(score);
                }
            }
        }
        return list;
    }

    /**
     * 条件を指定して成績一覧を動的に検索するメソッド（Map形式・学年絞り込み対応版）
     */
    public List<Map<String, Object>> searchMaps(String entYear, String classNum, String subjectCd, String studentId, String gradeStr) throws Exception {
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
            "t.CLASS_NUM AS class_num, " +
            "st.GRADE AS grade " + // 追加
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
        // 追加: 学年の絞り込み条件
        if (gradeStr != null && !gradeStr.trim().isEmpty()) {
            sql.append(" AND st.GRADE = ?");
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
            // 追加: 学年のプレースホルダーへのデータセット
            if (gradeStr != null && !gradeStr.trim().isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(gradeStr)); // 💡 Integer.parseInt() で囲む
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("ent_year", rs.getString("ent_year"));
                        map.put("student_id", rs.getString("student_id"));
                        map.put("student_name", rs.getString("student_name") == null ? "未登録" : rs.getString("student_name"));
                        map.put("subject_name", rs.getString("subject_name") == null ? "不明な科目" : rs.getString("subject_name"));
                        map.put("subject_cd", rs.getString("subject_cd"));
                        map.put("school_cd", rs.getString("school_cd"));
                        map.put("no", rs.getInt("no"));
                        map.put("point", rs.getInt("point"));
                        map.put("class_num", rs.getString("class_num"));
                        map.put("grade", rs.getInt("grade")); // 追加: 学年をMapに格納
                        
                        list.add(map);
                    }
                }
            }
            return list;
        }
    
    /**
     * 追加: 学生・科目・回数を指定して点数を保存（存在すれば更新、なければ新規挿入）するメソッド
     */
    public boolean save(String studentId, String subjectCd, int no, int point) throws Exception {
        // まずデータが存在するか確認
        String checkSql = "SELECT COUNT(*) FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND NO = ?";
        String insertSql = "INSERT INTO TEST (POINT, CLASS_NUM, STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO) VALUES (?, ?, ?, ?, ?, ?)";
        String updateSql = "UPDATE TEST SET POINT = ? WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND NO = ?";
        
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection()) {
            // 1. 既存データの存在チェック
            boolean isExist = false;
            try (PreparedStatement pstmt = con.prepareStatement(checkSql)) {
                pstmt.setString(1, studentId);
                pstmt.setString(2, subjectCd);
                pstmt.setInt(3, no);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        isExist = true;
                    }
                }
            }

            // 2. 所属クラス番号をSTUDENTテーブルからついでに取得（新規登録用）
            String classNum = "";
            String schoolCd = "tes"; // デフォルト値
            String studentSql = "SELECT CLASS_NUM, SCHOOL_CD FROM STUDENT WHERE NO = ?";
            try (PreparedStatement pstmt = con.prepareStatement(studentSql)) {
                pstmt.setString(1, studentId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        classNum = rs.getString("CLASS_NUM");
                        schoolCd = rs.getString("SCHOOL_CD");
                    }
                }
            }

            // 3. 存在すればUPDATE、なければINSERT
            if (isExist) {
                try (PreparedStatement pstmt = con.prepareStatement(updateSql)) {
                    pstmt.setInt(1, point);
                    pstmt.setString(2, studentId);
                    pstmt.setString(3, subjectCd);
                    pstmt.setInt(4, no);
                    return pstmt.executeUpdate() > 0;
                }
            } else {
                try (PreparedStatement pstmt = con.prepareStatement(insertSql)) {
                    pstmt.setInt(1, point);
                    pstmt.setString(2, classNum != null ? classNum : "");
                    pstmt.setString(3, studentId);
                    pstmt.setString(4, subjectCd);
                    pstmt.setString(5, schoolCd);
                    pstmt.setInt(6, no);
                    return pstmt.executeUpdate() > 0;
                }
            }
        }
        
    }
    public boolean delete(Bean.Score score) throws Exception {
        String sql = "DELETE FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            pstmt.setString(1, score.getStudentId());
            pstmt.setString(2, score.getSubjectCd());
            pstmt.setString(3, score.getSchoolCd());
            pstmt.setInt(4, score.getNo());
            
            return pstmt.executeUpdate() > 0;
        }
    }

}
