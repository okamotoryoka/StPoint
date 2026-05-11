package DAO.Subject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DAO.DAO;
import bean.Subject;

public class SubjectDAO extends DAO {

    public List<Subject> findAll() throws SQLException {
        List<Subject> list = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = getConnection(); // ← 親クラスのメソッド

            String sql = "SELECT school_cd, cd, subject_name FROM Subject";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Subject subject = new Subject();
                subject.setSchoolCd(rs.getString("school_cd"));
                subject.setCd(rs.getString("cd"));
                subject.setSubjectName(rs.getNString("subject_name"));
                list.add(subject);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            rs.close();
            ps.close();
            con.close();
        }

        return list;
    }
}