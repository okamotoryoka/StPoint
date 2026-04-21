package DAO.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DAO.DAO;
import bean.Student;

public class StudentDAO extends DAO {
	public Student search(String student_name, int no) throws Exception {
		
		Student stu = null;
		
		Connection con = getConnection();
		
		PreparedStatement st = con.prepareStatement(
				"select * from Admin where student_name=? and no=? "
				);
		
		st.setString(1,student_name);
		
		st.setInt(2,no);
		
		ResultSet rs = st.executeQuery(); 
		
		while (rs.next()) {
			stu = new Student();
		
			stu.setNo(rs.getString("no"));
			stu.setStudentName(rs.getString("student_name"));
			stu.setEntYear(rs.getInt("ent_year"));
			stu.setClassNum(rs.getInt("class_num"));
			stu.setSchoolId(rs.getString("school_id"));

		}
		
		st.close();
		con.close();
		
		return stu;
	}
}