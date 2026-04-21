package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class StudentDeleteDAO extends DAO {
	private Connection connection;
	
	public StudentDeleteDAO(Connection connection) {
		this.connection = connection;
	}
	
	public boolean deleteStudent(String no) throws Exception {
		if (no == null || no.isBlank()) {
			return false;
		}
		String sql = "DELETE FROM Student WHERE no = ?";
		try (Connection con = getConnection();
			 PreparedStatement stmt = con.prepareStatement(sql)) {
			stmt.setString(1, no);
			int affectedRows = stmt.executeUpdate();
			return affectedRows > 0;
		}
	}
	
}