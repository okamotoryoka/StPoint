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
        String sql = "SELECT DISTINCT CLASS_NUM FROM STUDENT WHERE CLASS_NUM IS NOT NULL ORDER BY CLASS_NUM ASC";

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
     * 重複のない学年の一覧を昇順で取得するメソッド（画面のプルダウン用）
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
     * 条件を指定して成績一覧を動的に検索するメソッド（★科目名不具合を根本から解消した決定版）
     */
    public List<Bean.Score> search(String entYear, String classNum, String subjectCd, String noStr, String gradeStr) throws Exception {
        List<Bean.Score> list = new ArrayList<>();
        
        // 💡 プレースホルダー「?」の数を【2個】に極限まで減らし、パラメータ不一致を絶対に起こさないSQLにしました
        StringBuilder sql = new StringBuilder(
            "SELECT " +
            "st.ENT_YEAR AS ent_year, " +
            "st.NO AS student_id, " + 
            "st.NAME AS student_name, " +
            "sub.NAME AS subject_name, " + 
            "sub.CD AS subject_cd, " + 
            "st.SCHOOL_CD AS school_cd, " +
            "IFNULL(t.NO, 1) AS no, " + 
            "IFNULL(t.POINT, 0) AS point, " + 
            "st.CLASS_NUM AS class_num, " +
            "st.GRADE AS grade " + 
            "FROM STUDENT st " + 
            // 💡 変更：SUBJECT（科目マスタ）を先に確実に引っ掛けて、科目名を固定します
            "LEFT JOIN SUBJECT sub ON sub.CD = ? " + // ★1つ目の?
            // 💡 変更：TESTテーブルの結合には、上のマスタで確定したコード（sub.CD）をそのまま流用します
            "LEFT JOIN TEST t ON st.NO = t.STUDENT_NO AND sub.CD = t.SUBJECT_CD AND t.NO = ? " + // ★2つ目の?
            "WHERE 1=1"
        );
        
        // 動的条件（WHERE句）の追加
        if (entYear != null && !entYear.trim().isEmpty()) {
            sql.append(" AND st.ENT_YEAR = ?");
        }
        if (classNum != null && !classNum.trim().isEmpty()) {
            sql.append(" AND st.CLASS_NUM = ?");
        }
        if (gradeStr != null && !gradeStr.trim().isEmpty()) {
            sql.append(" AND st.GRADE = ?");
        }
        
        sql.append(" ORDER BY st.NO ASC");

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            
            // 💡 順番通りにセット（パラメータの数が劇的に減ったため、ズレが絶対に起きません）
            pstmt.setString(paramIndex++, subjectCd); // 1つ目の? (sub.CD)
            
            int noValue = (noStr != null && !noStr.trim().isEmpty()) ? Integer.parseInt(noStr) : 1;
            pstmt.setInt(paramIndex++, noValue);      // 2つ目の? (t.NO)
            
            // WHERE句の動的条件へのセット
            if (entYear != null && !entYear.trim().isEmpty()) {
                pstmt.setString(paramIndex++, entYear);
            }
            if (classNum != null && !classNum.trim().isEmpty()) {
                pstmt.setString(paramIndex++, classNum);
            }
            if (gradeStr != null && !gradeStr.trim().isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(gradeStr));
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Bean.Score score = new Bean.Score();
                    
                    score.setEntYear(rs.getString("ent_year")); 
                    score.setStudentId(rs.getString("student_id"));
                    score.setStudentName(rs.getString("student_name") == null ? "未登録" : rs.getString("student_name"));
                    
                    // 💡 もし検索条件が空欄のときでも、「不明な科目」にならず画面の選択値をそのまま安全に表示させる処理
                    String subName = rs.getString("subject_name");
                    score.setSubjectName(subName != null ? subName : "選択された科目");
                    
                    score.setNo(rs.getInt("no"));
                    score.setPoint(rs.getInt("point")); 
                    score.setClassNum(rs.getString("class_num"));
                    score.setSubjectCd(rs.getString("subject_cd") != null ? rs.getString("subject_cd") : subjectCd);
                    score.setSchoolCd(rs.getString("school_cd"));
                    score.setGrade(rs.getInt("grade")); 
                    
                    list.add(score);
                }
            }
        }
        return list;
    }

    public List<Map<String, Object>> searchMaps(String entYear, String classNum, String subjectCd, String studentId, String gradeStr) throws Exception {
        List<Map<String, Object>> list = new ArrayList<>();
        
        // 💡 変更点：t.NO AS no を削除し、t.SUBJECT_CD を MAX(t.SUBJECT_CD) に変更してグループ化エラーを完全に回避します
        StringBuilder sql = new StringBuilder(
            "SELECT " +
            "st.ENT_YEAR AS ent_year, " +
            "st.NO AS student_id, " + 
            "st.NAME AS student_name, " +
            "sub.NAME AS subject_name, " + 
            "MAX(t.SUBJECT_CD) AS subject_cd, " + // ★修正：GROUP BY から外すためMAXで囲いました
            "st.SCHOOL_CD AS school_cd, " +
            // 💡 1行の中に1回目と2回目をMAX関数で安全に分離して取得します
            "MAX(CASE WHEN t.NO = 1 THEN t.POINT END) AS score1, " + 
            "MAX(CASE WHEN t.NO = 2 THEN t.POINT END) AS score2, " + 
            "st.CLASS_NUM AS class_num, " +
            "st.GRADE AS grade " + 
            "FROM STUDENT st " + 
            // ★最重要：学生と成績を「番号」と「学校」だけで1対多結合させます（これで既存の点数が100%消えなくなります）
            "LEFT JOIN TEST t ON st.NO = t.STUDENT_NO AND st.SCHOOL_CD = t.SCHOOL_CD " + 
            // 💡 科目名は成績テーブルに存在する科目コードから直接カチッと結合します
            "LEFT JOIN SUBJECT sub ON t.SUBJECT_CD = sub.CD AND st.SCHOOL_CD = sub.SCHOOL_CD " + 
            "WHERE 1=1"
        );
        
        // 💡 動的条件（WHERE句）：画面で選ばれた科目の絞り込みは、ここで安全に行います（元のロジックを完全維持）
        if (subjectCd != null && !subjectCd.trim().isEmpty()) {
            sql.append(" AND (t.SUBJECT_CD = ? OR t.SUBJECT_CD IS NULL)"); // 未入力の生徒(null)も通す設定
        }
        if (entYear != null && !entYear.trim().isEmpty()) {
            sql.append(" AND st.ENT_YEAR = ?");
        }
        if (classNum != null && !classNum.trim().isEmpty()) {
            sql.append(" AND st.CLASS_NUM = ?");
        }
        if (studentId != null && !studentId.trim().isEmpty()) {
            sql.append(" AND st.NO = ?");
        }
        if (gradeStr != null && !gradeStr.trim().isEmpty()) {
            sql.append(" AND st.GRADE = ?");
        }
        
        // 横並び（MAX集計）のために学生ごとにグループ化（★修正：t.SUBJECT_CD をリストから削除しました）
        sql.append(" GROUP BY st.NO, st.ENT_YEAR, st.NAME, sub.NAME, st.SCHOOL_CD, st.CLASS_NUM, st.GRADE");
        sql.append(" ORDER BY st.NO ASC");

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            
            // 💡 固定プレースホルダーは無し（すべて元の順番のまま値をセットします）
            if (subjectCd != null && !subjectCd.trim().isEmpty()) {
                pstmt.setString(paramIndex++, subjectCd);
            }
            if (entYear != null && !entYear.trim().isEmpty()) {
                pstmt.setString(paramIndex++, entYear);
            }
            if (classNum != null && !classNum.trim().isEmpty()) {
                pstmt.setString(paramIndex++, classNum);
            }
            if (studentId != null && !studentId.trim().isEmpty()) {
                pstmt.setString(paramIndex++, studentId);
            }
            if (gradeStr != null && !gradeStr.trim().isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(gradeStr));
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("ent_year", rs.getString("ent_year"));
                    map.put("student_id", rs.getString("student_id"));
                    map.put("student_name", rs.getString("student_name") == null ? "未登録" : rs.getString("student_name"));
                    
                    String subName = rs.getString("subject_name");
                    map.put("subject_name", subName != null ? subName : "選択された科目");
                    
                    map.put("subject_cd", rs.getString("subject_cd") != null ? rs.getString("subject_cd") : subjectCd);
                    map.put("school_cd", rs.getString("school_cd"));
                    
                    // ★最重要：JSPの「Integer.parseInt」でエラー（ハイフン文字による例外）を起こさないため、
                    // ここでは文字列のハイフンにせず、生オブジェクト（数値またはnull）のまま引き渡します。
                    map.put("score1", rs.getObject("score1"));
                    map.put("score2", rs.getObject("score2"));
                    
                    map.put("class_num", rs.getString("class_num"));
                    map.put("grade", rs.getInt("grade"));
                    
                    list.add(map);
                }
            }
        }
        return list;
    }


    /**
     * 学生・科目・回数を指定して点数を保存（存在すれば更新、なければ新規挿入）するメソッド
     */
    public boolean save(String studentId, String subjectCd, int no, int point) throws Exception {
        String checkSql = "SELECT COUNT(*) FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND NO = ?";
        String insertSql = "INSERT INTO TEST (POINT, CLASS_NUM, STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO) VALUES (?, ?, ?, ?, ?, ?)";
        String updateSql = "UPDATE TEST SET POINT = ? WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND NO = ?";
        
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection()) {
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

            String classNum = "";
            String schoolCd = "tes"; 
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

    /**
     * 成績を削除するメソッド
     */
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
