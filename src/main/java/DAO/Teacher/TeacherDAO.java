package DAO.Teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Bean.Teacher;
import DAO.DAO;

public class TeacherDAO extends DAO {
	public Teacher search(String teacher_id, String password) throws Exception {
		
		Teacher tea = null;
		
		Connection con = getConnection();
		
		PreparedStatement st = con.prepareStatement(
				"select * from Admin where admin_name=? and password=? "
				);
		
		st.setString(1,teacher_id);
		
		st.setString(2,password);
		
		ResultSet rs = st.executeQuery(); 
		
		while (rs.next()) {
			tea = new Teacher();
		
			tea.setTeacherId(rs.getString("teacher_id"));
			tea.setTeacherName(rs.getString("teacher_name"));
			tea.setSchoolCd(rs.getString("school_cd"));
			tea.setTeacherPass(rs.getString("password"));

		}
		
		st.close();
		con.close();
		
		return tea;
	}
}