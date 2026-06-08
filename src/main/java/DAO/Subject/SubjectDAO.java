package DAO.Subject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import Bean.School;
import Bean.Subject;
import DAO.DAO; // 設計図通り、親クラスのDAOを継承したままにします

public class SubjectDAO extends DAO {

    // クラス図に定義されている通りのメソッド名と引数
    public List<Subject> filter(School school) throws Exception {
        List<Subject> list = new ArrayList<>();
        
        // 成績のコードと同じ、本物のデータベース接続（stpoint）を取得します
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        
        String sql = "SELECT * FROM SUBJECT WHERE UPPER(TRIM(SCHOOL_CD)) = UPPER(TRIM(?)) ORDER BY CD ASC";
        
        try (Connection con = ds.getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, school.getCd());
            
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Subject subject = new Subject();
                    subject.setCd(rs.getString("CD").trim());
                    subject.setName(rs.getString("NAME").trim());
                    subject.setSchool(school);
                    list.add(subject);
                }
            }
        }
        return list;
    }
    
    public Subject get(String cd, School school) throws Exception {
        Subject subject = null;
        
        // データベース接続（stpoint）を取得
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        
        // 科目コードと学校コードが一致する1件を取得するSQL
        String sql = "SELECT * FROM SUBJECT WHERE UPPER(TRIM(CD)) = UPPER(TRIM(?)) AND UPPER(TRIM(SCHOOL_CD)) = UPPER(TRIM(?))";
        
        try (Connection con = ds.getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, cd);
            st.setString(2, school.getCd());
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    subject = new Subject();
                    subject.setCd(rs.getString("CD").trim());
                    subject.setName(rs.getString("NAME").trim());
                    subject.setSchool(school);
                }
            }
        }
        return subject;
    }
    
    public boolean save(Subject subject) throws Exception {
        int count = 0;
        
        // データベース接続（stpoint）を取得
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        
        // 指定された科目コード（CD）と学校コード（SCHOOL_CD）を条件に、科目を更新するSQL
        String sql = "UPDATE SUBJECT SET NAME = ? WHERE UPPER(TRIM(CD)) = UPPER(TRIM(?)) AND UPPER(TRIM(SCHOOL_CD)) = UPPER(TRIM(?))";
        
        try (Connection con = ds.getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            // SQLの「?」に値をセット
            st.setString(1, subject.getName());
            st.setString(2, subject.getCd());
            st.setString(3, subject.getSchool().getCd());
            
            // クエリを実行（影響を受けた行数が返る）
            count = st.executeUpdate();
        }
        
        // 1行以上更新できたら true、更新失敗（対象なし等）なら false を返す
        return count > 0;
    }

    
}
