package DAO.Subject;

import java.sql.Connection;
import java.sql.PreparedStatement;

import Bean.Subject;
import DAO.DAO;

public class SubjectInsertDAO extends DAO {
	public boolean insertStudent(Subject sub) throws Exception {
        String sql = "INSERT INTO Subject "
                   + "(SCHOOL_CD, CD, SUBJECT_NAME) "
                   + "VALUES (?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, sub.getSchoolCd());
            ps.setString(2, sub.getCd());
            ps.setString(3, sub.getSubjectName());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        }
    }
}