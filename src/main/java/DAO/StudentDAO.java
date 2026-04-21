package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Bean.Student;

public class StudentDAO extends DAO {
	public Student search(String student_name, int no) throws Exception {
		
		Student stu = null;
		
		Connection con = getConnection();
		
		PreparedStatement st = con.prepareStatement(
				"select * from Student where admin_name=? and password=? "
				);
		
		st.setString(1,student_name);
		
		st.setInt(2,no);
		
		ResultSet rs = st.executeQuery(); 
		
		while (rs.next()) {
			stu = new Student();
		
//			stu.setNo(rs.getInt("no"));
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