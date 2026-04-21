package DAO.Teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;

import DAO.DAO;
import bean.Teacher;

//beanのStudentとつながっている
public class TeacherInsertDAO extends DAO {
	public boolean insertTeacher(Teacher tea) throws Exception {
		String sql = "INSERT INTO Teacher (teacher_id, password, teacher_name, school_cd) VALUES(?, ?, ?, ?)";

		
		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, tea.getTeacherId());
			ps.setString(2, tea.getTeacherPass());
			ps.setString(3, tea.getTeacherName());
			ps.setString(4, tea.getSchoolCd());
			
		    int affectedRows = ps.executeUpdate();
		    return affectedRows > 0;
		}
	}
}