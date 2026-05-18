package DAO.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
    
    public List<Student> search(
            String name,
            String classNum,
            String sort
    ) throws Exception {

        List<Student> list = new ArrayList<>();

        String sql =
            "SELECT * FROM student " +
            "WHERE name LIKE ? " +
            "AND class_num LIKE ? ";

        // ソート
        if ("no".equals(sort)) {

            sql += "ORDER BY no";

        } else if ("class".equals(sort)) {

            sql += "ORDER BY class_num";

        }

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, "%" + name + "%");
            st.setString(2, "%" + classNum + "%");

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    Student s = new Student();

                    s.setNo(rs.getString("no"));
                    s.setName(rs.getString("name"));
                    s.setEntYear(rs.getInt("ent_year"));
                    s.setClassNum(rs.getString("class_num"));
                    s.setIsAttend(rs.getBoolean("is_attend"));

                    list.add(s);
                }
            }
        }

        return list;
    }
    
    public List<Student> findAll() throws Exception {

        List<Student> list = new ArrayList<>();

        String sql = "SELECT * FROM student";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {

                Student s = new Student();

                s.setNo(rs.getString("no"));
                s.setName(rs.getString("name"));
                s.setEntYear(rs.getInt("ent_year"));
                s.setClassNum(rs.getString("class_num"));
                s.setIsAttend(rs.getBoolean("is_attend"));

                list.add(s);
            }
        }

        return list;
    }
    
    public boolean update(Student s) throws Exception {

        String sql = "UPDATE student SET name = ?, ent_year = ?, class_num = ?, is_attend = ? WHERE no = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, s.getName());
            st.setInt(2, s.getEntYear());
            st.setString(3, s.getClassNum());
            st.setBoolean(4, s.isIsAttend());
            st.setString(5, s.getNo());

            int count = st.executeUpdate();
            return count > 0;
        }
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
