package DAO.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;// ★「javax」から「java」に修正しました
import javax.sql.DataSource;       // ★新しく追加しました

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
                    student.setGrade(rs.getInt("grade")); // 追加: 学年
                }
            }
        }
        return student;
    }
    
    /**
     * 学生の条件検索・ソート処理（学年追加版）
     * @param grade 検索したい学年（0 の場合は全学年を対象とする）
     */
    public List<Student> search(String name, String classNum, int grade, String sort) throws Exception {
        List<Student> list = new ArrayList<>();
        // SQL修正: 学年の絞り込み条件（? = 0 の時は全件一致）を追加
        String sql =
            "SELECT * FROM student " +
            "WHERE name LIKE ? " +
            "AND (? = '' OR class_num = ?) " +
            "AND (? = 0 OR grade = ?) ";

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
            
            // 追加: 学年のプレースホルダーをセット
            st.setInt(4, grade);
            st.setInt(5, grade);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Student s = new Student();
                    s.setNo(rs.getString("no"));
                    s.setName(rs.getString("name"));
                    s.setEntYear(rs.getInt("ent_year"));
                    s.setClassNum(rs.getString("class_num"));
                    s.setAttend(rs.getBoolean("is_attend"));
                    s.setGrade(rs.getInt("grade")); // 追加: 学年
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
                s.setAttend(rs.getBoolean("is_attend"));
                s.setGrade(rs.getInt("grade")); // 追加: 学年
                list.add(s);
            }
        }
        return list;
    }
    
    // update, postFilter にも grade を追加
    public boolean update(Student s) throws Exception {
        // SQL修正: grade を更新対象に追加
        String sql = "UPDATE student SET name = ?, class_num = ?, is_attend = ?, grade = ? WHERE no = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, s.getName());
            st.setString(2, s.getClassNum());
            st.setBoolean(3, s.isAttend());
            st.setInt(4, s.getGrade()); // 追加: 学年
            st.setString(5, s.getNo());
            return st.executeUpdate() > 0;
        }
    }

    public boolean postFilter(Student s) throws Exception {
        // SQL修正: grade を挿入対象に追加
        String sql = "INSERT INTO student (no, name, ent_year, class_num, is_attend, school_cd, grade) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, s.getNo());
            st.setString(2, s.getName());
            st.setInt(3, s.getEntYear());
            st.setString(4, s.getClassNum());
            st.setBoolean(5, s.isAttend());
            st.setString(6, s.getSchool() != null ? s.getSchool().getCd() : "tes");
            st.setInt(7, s.getGrade()); // 追加: 学年
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

    /**
     * 追加: 登録されている学年の一覧を取得（画面のプルダウン用）
     */
    public List<Integer> getGrades() throws Exception {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT DISTINCT grade FROM student WHERE grade IS NOT NULL ORDER BY grade ASC";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getInt("grade"));
            }
        }
        return list;
    }
    
    public boolean promoteAllStudents() throws Exception {
        // 💡 4年制の学校運用ルール（新入生の1年自動設定付き）
        
        // ① 先に、現在「4年生」の在学生をすべて卒業（非在学: 'FALSE'）に切り替える
        String graduationSql = "UPDATE STUDENT SET IS_ATTEND = 'FALSE' WHERE IS_ATTEND = 'TRUE' AND GRADE = 4";
        
        // ② 次に、在学中（'TRUE'）の「1年〜3年」の生徒を1年ずつ進級させる
        String promotionSql = "UPDATE STUDENT SET GRADE = GRADE + 1 WHERE IS_ATTEND = 'TRUE' AND GRADE BETWEEN 1 AND 3";

        // ③ 【新設】在学中（'TRUE'）で、学年が未登録（null または 0）の生徒を一括で「1年生」にする
        // ※これにより、新しく入ってきた生徒や未設定の生徒が、年度更新で自動的に1年生としてスタートします
        String freshersSql = "UPDATE STUDENT SET GRADE = 1 WHERE IS_ATTEND = 'TRUE' AND (GRADE IS NULL OR GRADE = 0)";

        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");

        try (Connection con = ds.getConnection()) {
            con.setAutoCommit(false); // トランザクション開始

            try (PreparedStatement pstmtGrad = con.prepareStatement(graduationSql);
                 PreparedStatement pstmtProm = con.prepareStatement(promotionSql);
                 PreparedStatement pstmtFresh = con.prepareStatement(freshersSql)) { // ★追加
                
                // 1. 4年生を卒業にする
                pstmtGrad.executeUpdate();
                
                // 2. 1〜3年生を進級させる
                pstmtProm.executeUpdate();
                
                // 3. 学年未設定の生徒を1年生にする（★追加）
                pstmtFresh.executeUpdate();
                
                con.commit(); // すべて成功したら保存
                return true;
            } catch (Exception e) {
                con.rollback(); // エラー時は完全に巻き戻す
                throw e;
            }
        }
    }


}
