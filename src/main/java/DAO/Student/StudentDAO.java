package DAO.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Bean.Student;
import DAO.DAO;

public class StudentDAO extends DAO {

    /**
     * 学籍番号から学生を取得（重複チェック用）
     */
    public Student get(String no) throws Exception {
        Student student = null;
        String sql = "SELECT * FROM student WHERE no = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, no);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    student = new Student();
                    student.setNo(rs.getString("no"));
                    student.setName(rs.getString("name"));
                }
            }
        }
        return student;
    }

    /**
     * 学生情報の保存
     */
    public boolean postFilter(Student s) throws Exception {
        String sql = "INSERT INTO student (no, name, ent_year, class_num, is_attend, school_cd) VALUES (?, ?, ?, ?, ?, ?)";
        int count = 0;

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, s.getNo());
            st.setString(2, s.getName());
            st.setInt(3, s.getEntYear());
            st.setString(4, s.getClassNum());
            st.setBoolean(5, s.isIsAttend());
            st.setString(6, s.getSchool() != null ? s.getSchool().getCd() : "tes");

            count = st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw e; 
        }
        return count > 0;
    }
}
