package DAO.Teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;

import Bean.Teacher;
import DAO.DAO;

public class TeacherUpdateDAO extends DAO {
	public boolean updateAttendance(Teacher tea) throws Exception {
		String sql = "UPDATE Student " +
                     "SET password = ?, teacher_name = ?, school_cd = ? " +
                     "WHERE teacher_id = ?";

		
		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, tea.getTeacherPass());
			ps.setString(2, tea.getTeacherName());
			ps.setString(3, tea.getSchoolCd());
			ps.setString(6, tea.getTeacherId());
			
		    int affectedRows = ps.executeUpdate();
		    return affectedRows > 0;
		}
	}
}