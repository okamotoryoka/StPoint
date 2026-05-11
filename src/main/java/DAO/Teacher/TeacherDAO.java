package DAO.Teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DAO.DAO;
import bean.Teacher;

public class TeacherDAO extends DAO {
	public Teacher search(String teacher_name, String password) throws Exception {
		
		Teacher tea = null;
		
		Connection con = getConnection();
		
		PreparedStatement st = con.prepareStatement(
				"select * from Admin where teacher_name=? and password=? "
				);
		
		st.setString(1,teacher_name);
		
		st.setString(2,password);
		
		ResultSet rs = st.executeQuery(); 
		
		while (rs.next()) {
			tea = new Teacher(); //全部のTeacher情報を返す
		
			tea.setTeacherId(rs.getString("teacher_id"));
			tea.setTeacherPass(rs.getString("password"));
			tea.setTeacherName(rs.getString("teacher_name"));
			tea.setSchoolCd(rs.getString("school_cd"));
			tea.setCourseId(rs.getString("course_id"));

		}
		
		
		
		st.close();
		con.close();
		
		return tea;
	}
	
	
	
	 // 教師追加用（管理者用）
    // --------------------------
	public void insert(String teacher_id,String teacher_name, String password, String course_id, int year) throws Exception {
		String sql = "INSERT INTO TEACHER (TEACHER_ID, TEACHER_NAME, PASSWORD, COURSE_ID, \"YEAR\") VALUES (?, ?, ?, ?, ?)";

	    try (Connection con = getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1,teacher_id);
	        ps.setString(2, teacher_name);
	        ps.setString(3, password);
	        ps.setString(4, course_id);
	        ps.setInt(5, year);

	        ps.executeUpdate();
	    }
	}
}