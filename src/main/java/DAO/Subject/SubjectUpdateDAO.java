package DAO.Subject;

import java.sql.Connection;
import java.sql.PreparedStatement;

import Bean.Subject;
import DAO.DAO;

public class SubjectUpdateDAO extends DAO {
	public boolean updateAttendance(Subject sub) throws Exception {
		String sql = "UPDATE Subject " +
                     "SET school_cd = ?, subject_name = ? " +
                     "WHERE cd = ?";

		
		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, sub.getSchoolCd());
			ps.setString(2, sub.getSubjectName());
			ps.setString(3, sub.getCd());
		    int affectedRows = ps.executeUpdate();
		    return affectedRows > 0;
		}
	}
}