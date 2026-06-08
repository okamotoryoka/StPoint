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
}
