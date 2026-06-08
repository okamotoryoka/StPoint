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
import DAO.DAO;

public class SubjectDAO extends DAO {

    public List<Subject> filter(School school) throws Exception {
        List<Subject> list = new ArrayList<>();
        
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
        
        // 1. データベース接続（stpoint）を取得
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        
        // 2. すでに同じデータ（科目コードと学校コード）が存在するかチェック
        Subject existSubject = get(subject.getCd(), subject.getSchool());
        
        String sql = "";
        if (existSubject != null) {
            // 【データが存在する場合】UPDATE（更新）を行う
            sql = "UPDATE SUBJECT SET NAME = ? WHERE UPPER(TRIM(CD)) = UPPER(TRIM(?)) AND UPPER(TRIM(SCHOOL_CD)) = UPPER(TRIM(?))";
        } else {
            // 【データが存在しない場合】INSERT（新規追加）を行う
            sql = "INSERT INTO SUBJECT (NAME, CD, SCHOOL_CD) VALUES (?, ?, ?)";
        }
        
        try (Connection con = ds.getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            // 💡 ポイント：UPDATE文もINSERT文も「?」の順番を統一しています
            // 1番目: NAME, 2番目: CD, 3番目: SCHOOL_CD
            st.setString(1, subject.getName());
            st.setString(2, subject.getCd());
            st.setString(3, subject.getSchool().getCd());
            
            // クエリを実行（影響を受けた行数が返る）
            count = st.executeUpdate();
        }
        
        return count > 0;
    }
    
    public boolean delete(Subject subject) throws Exception {
        int count = 0;
        
        // データベース接続（stpoint）を取得
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        
        // 科目コードと学校コードが一致する行を削除するSQL
        String sql = "DELETE FROM SUBJECT WHERE UPPER(TRIM(CD)) = UPPER(TRIM(?)) AND UPPER(TRIM(SCHOOL_CD)) = UPPER(TRIM(?))";
        
        try (Connection con = ds.getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            // SQLの「?」に値をセット
            st.setString(1, subject.getCd());
            st.setString(2, subject.getSchool().getCd());
            
            // クエリを実行（削除された行数が返る）
            count = st.executeUpdate();
        }
        
        // 1行以上削除できたら true、失敗（対象なし等）なら false を返す
        return count > 0;
    }
    

  
}
