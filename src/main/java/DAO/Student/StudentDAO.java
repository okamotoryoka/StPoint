package DAO.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;

import DAO.DAO;
import bean.Student;

public class StudentDAO extends DAO {

    public void insert(Student s) throws Exception {
        Connection con = getConnection();
        
        // SQL文：school_cdも含めて6つのパラメータがあるか確認してください
        String sql = "INSERT INTO student (no, name, ent_year, class_num, is_attend, school_cd) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, s.getNo());
            st.setString(2, s.getName());
            st.setInt(3, s.getEntYear());
            st.setString(4, s.getClassNum());
            st.setBoolean(5, s.isIsAttend());
            
            // ★重要：もしSchoolオブジェクトが空なら一旦固定値(例:"tes")を入れる
            // 実際の運用ではログインユーザーの学校コードをセットします
            if (s.getSchool() != null) {
                st.setString(6, s.getSchool().getCd());
            } else {
                st.setString(6, "tes"); // ここをDBに実在する学校コードに書き換えてください
            }

            st.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace(); // ★原因をコンソールに出力する（これが無いと理由がわかりません）
            throw e; // Actionクラスに例外を投げて "insert" エラーを表示させる
        } finally {
            if (con != null) con.close();
        }
    }
}
