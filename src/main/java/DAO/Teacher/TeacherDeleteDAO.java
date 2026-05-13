package DAO.Teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;

import DAO.DAO;

public class TeacherDeleteDAO extends DAO {
	private Connection connection;
	
	public TeacherDeleteDAO(Connection connection) {
		this.connection = connection;
	}
	
	public boolean deleteTeacher(String teacher_id) throws Exception {
	    if (teacher_id == null || teacher_id.isBlank()) {
	        return false; // または IllegalArgumentException など
	    }
	    String sql = "DELETE FROM Teacher WHERE teacher_id = ?";
	    try (Connection con = getConnection();
	         PreparedStatement stmt = con.prepareStatement(sql)) {
	        stmt.setString(1, teacher_id);
	        int affectedRows = stmt.executeUpdate();
	        return affectedRows > 0;
	    }
	}
}