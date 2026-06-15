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
     * 学籍番号から学生を取得
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
                    student.setEntYear(rs.getInt("ent_year"));
                    student.setClassNum(rs.getString("class_num"));
                    student.setAttend(rs.getBoolean("is_attend"));
                }
            }
        }
        return student;
    }
    
    /**
     * 学生の条件検索・ソート処理
     */
    public List<Student> search(String name, String classNum, String sort) throws Exception {
        List<Student> list = new ArrayList<>();
        String sql =
            "SELECT * FROM student " +
            "WHERE name LIKE ? " +
            "AND (? = '' OR class_num = ?) ";

        if ("no".equals(sort)) {
            sql += " ORDER BY no ASC";
        } else if ("class".equals(sort)) {
            sql += " ORDER BY class_num ASC";
        } else {
            sql += " ORDER BY no ASC";
        }

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, "%" + name + "%");
            String cls = (classNum != null) ? classNum : "";
            st.setString(2, cls);
            st.setString(3, cls);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Student s = new Student();
                    s.setNo(rs.getString("no"));
                    s.setName(rs.getString("name"));
                    s.setEntYear(rs.getInt("ent_year"));
                    s.setClassNum(rs.getString("class_num"));
                    // 修正：getIntをやめてgetBooleanに統一
                    s.setAttend(rs.getBoolean("is_attend"));
                    list.add(s);
                }
            }
        }
        return list;
    }
    
    /**
     * 学生情報の全件取得
     */
    public List<Student> findAll() throws Exception {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM student ORDER BY no ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                Student s = new Student();
                s.setNo(rs.getString("no"));
                s.setName(rs.getString("name"));
                s.setEntYear(rs.getInt("ent_year"));
                s.setClassNum(rs.getString("class_num"));
                // 修正：getIntをやめてgetBooleanに統一
                s.setAttend(rs.getBoolean("is_attend"));
                list.add(s);
            }
        }
        return list;
    }
    
    // update, postFilter, getEntYears, getClassNums はそのまま維持
    public boolean update(Student s) throws Exception {
        String sql = "UPDATE student SET name = ?, class_num = ?, is_attend = ? WHERE no = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, s.getName());
            st.setString(2, s.getClassNum());
            st.setBoolean(3, s.isAttend());
            st.setString(4, s.getNo());
            return st.executeUpdate() > 0;
        }
    }

    public boolean postFilter(Student s) throws Exception {
        String sql = "INSERT INTO student (no, name, ent_year, class_num, is_attend, school_cd) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, s.getNo());
            st.setString(2, s.getName());
            st.setInt(3, s.getEntYear());
            st.setString(4, s.getClassNum());
            st.setBoolean(5, s.isAttend());
            st.setString(6, s.getSchool() != null ? s.getSchool().getCd() : "tes");
            return st.executeUpdate() > 0;
        }
    }

    public List<Integer> getEntYears() throws Exception {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT DISTINCT ent_year FROM student ORDER BY ent_year DESC";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getInt("ent_year"));
            }
        }
        return list;
    }

    public List<String> getClassNums() throws Exception {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT class_num FROM student ORDER BY class_num ASC";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("class_num"));
            }
        }
        return list;
    }
}