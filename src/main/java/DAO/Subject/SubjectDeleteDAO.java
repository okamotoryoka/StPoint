package DAO.Subject;

import java.sql.Connection;
import java.sql.PreparedStatement;

import DAO.DAO;

public class SubjectDeleteDAO extends DAO {
	private Connection connection;
	
	public SubjectDeleteDAO(Connection connection) {
		this.connection = connection;
	}
	
	public boolean deleteStudent(String cd) throws Exception {
		if (cd == null || cd.isBlank()) {
			return false;
		}
		String sql = "DELETE FROM Subject WHERE cd = ?";
		try (Connection con = getConnection();
			 PreparedStatement stmt = con.prepareStatement(sql)) {
			stmt.setString(1, cd);
			int affectedRows = stmt.executeUpdate();
			return affectedRows > 0;
		}
	}
	
}