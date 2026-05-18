package DAO.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;

import Bean.Student;
import DAO.DAO;

public class StudentUpdateDAO extends DAO {
	public boolean updateAttendance(Student stu) throws Exception {
		String sql = "UPDATE Student " +
                     "SET student_name = ?, ent_year = ?, class_num = ?, is_attend = ?, school_id = ? " +
                     "WHERE no = ?";

		
		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, stu.getStudentName());
			ps.setInt(2, stu.getEntYear());
			ps.setInt(3, stu.getClassNum());
			ps.setString(4, stu.getIsAttend());
			ps.setString(6, stu.getSchoolId());
			ps.setString(7, stu.getNo());
			
		    int affectedRows = ps.executeUpdate();
		    return affectedRows > 0;
		}
	}
}