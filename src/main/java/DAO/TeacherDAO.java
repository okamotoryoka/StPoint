package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.Teacher;

public class TeacherDAO extends DAO {
	public Teacher search(String teacher_name, String password) throws Exception {
		
		Teacher tea = null;
		
		Connection con = getConnection();
		
		PreparedStatement st = con.prepareStatement(
				"select * from Admin where admin_name=? and password=? "
				);
		
		st.setString(1,teacher_name);
		
		st.setString(2,password);
		
		ResultSet rs = st.executeQuery(); 
		
		while (rs.next()) {
			tea = new Teacher();
		
			tea.setTeacherId(rs.getString("teacher_id"));
			tea.setTeacherPass(rs.getString("password"));
			tea.setTeacherName(rs.getString("teacher_name"));
			tea.setSchoolCd(rs.getString("school_cd"));

		}
		
		st.close();
		con.close();
		
		return tea;
	}
}