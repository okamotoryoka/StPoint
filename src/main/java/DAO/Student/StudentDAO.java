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
     * 学籍番号から学生を取得（重複チェック・更新画面の初期表示用）
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
     * 学生の条件検索・ソート処理（クラス完全一致修正版）
     */
    public List<Student> search(String name, String classNum, String sort) throws Exception {

        List<Student> list = new ArrayList<>();

        // クラスを「LIKE」から「=」による完全一致に修正。未選択（""）の時は全件通す工夫を入れています。
        String sql =
            "SELECT * FROM student " +
            "WHERE name LIKE ? " +
            "AND (? = '' OR class_num = ?) ";

        // ソート条件の追加
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
            // クラス未選択（null）の場合は空文字に変換してバインド
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
                    s.setAttend(rs.getBoolean("is_attend"));

                    list.add(s);
                }
            }
        }
        return list;
    }
    
    /**
     * 学生情報を全件取得する（一覧表示用・重複なし選択肢の生成用）
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
                s.setAttend(rs.getBoolean("is_attend"));
                
                list.add(s);
            }
        }
        return list;
    }
    
    /**
     * 学生情報の変更（クラス変更なし・氏名と在学フラグのみを安全にUPDATE）
     */
    public boolean update(Student s) throws Exception {
        // ⭕ 画面から送られてこないクラスと入学年度をSQLの更新対象から外しました。
        // これにより、データが新しく増えてしまうバグを完全に防ぎ、安全に上書きします。
        String sql = "UPDATE student SET name = ?, is_attend = ? WHERE no = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, s.getName());
            st.setBoolean(2, s.isAttend());
            st.setString(3, s.getNo());

            int count = st.executeUpdate();
            return count > 0;
        }
    }

    /**
     * 学生情報の新規保存（INSERT）
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
            st.setBoolean(5, s.isAttend());
            st.setString(6, s.getSchool() != null ? s.getSchool().getCd() : "tes");

            count = st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw e; 
        }
        return count > 0;
    }
}
