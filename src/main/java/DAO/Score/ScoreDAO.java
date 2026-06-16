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

    // 検索用（引数5つ：入学年度、クラス、科目、学生番号、回数に対応）
    public List<Bean.Score> search(String entYear, String classNum, String subjectCd, String studentId, String noStr) throws Exception {
        List<Bean.Score> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT st.ENT_YEAR AS ent_year, t.STUDENT_NO AS student_id, st.NAME AS student_name, " +
            "sub.NAME AS subject_name, t.SUBJECT_CD AS subject_cd, t.SCHOOL_CD AS school_cd, " +
            "t.NO AS no, t.POINT AS point, t.CLASS_NUM AS class_num " +
            "FROM TEST t " +
            "LEFT JOIN STUDENT st ON t.STUDENT_NO = st.NO AND t.SCHOOL_CD = st.SCHOOL_CD " +
            "LEFT JOIN SUBJECT sub ON t.SUBJECT_CD = sub.CD AND t.SCHOOL_CD = sub.SCHOOL_CD " +
            "WHERE 1=1"
        );

        if (entYear != null && !entYear.trim().isEmpty()) sql.append(" AND st.ENT_YEAR = ?");
        if (classNum != null && !classNum.trim().isEmpty()) sql.append(" AND t.CLASS_NUM = ?");
        if (subjectCd != null && !subjectCd.trim().isEmpty()) sql.append(" AND t.SUBJECT_CD = ?");
        if (studentId != null && !studentId.trim().isEmpty()) sql.append(" AND t.STUDENT_NO = ?");
        if (noStr != null && !noStr.trim().isEmpty()) sql.append(" AND t.NO = ?");
        
        sql.append(" ORDER BY t.STUDENT_NO ASC, t.NO ASC");

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (entYear != null && !entYear.trim().isEmpty()) pstmt.setString(paramIndex++, entYear);
            if (classNum != null && !classNum.trim().isEmpty()) pstmt.setString(paramIndex++, classNum);
            if (subjectCd != null && !subjectCd.trim().isEmpty()) pstmt.setString(paramIndex++, subjectCd);
            if (studentId != null && !studentId.trim().isEmpty()) pstmt.setString(paramIndex++, studentId);
            if (noStr != null && !noStr.trim().isEmpty()) pstmt.setInt(paramIndex++, Integer.parseInt(noStr));

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
                    list.add(score);
                }
            }
        }
        return list;
    }

    public List<Map<String, Object>> searchMaps(String entYear, String classNum, String subjectCd, String studentId) throws Exception {
        return new ArrayList<>(); 
    }

    public int delete(Bean.Score score) throws Exception {
        int count = 0;
        String sql = "DELETE FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, score.getStudentId());
            pstmt.setString(2, score.getSubjectCd());
            pstmt.setString(3, score.