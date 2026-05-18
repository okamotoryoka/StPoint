package DAO.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;

import Bean.Student;
import DAO.DAO;

public class StudentInsertDAO extends DAO {
	public boolean insertStudent(Student stu) throws Exception {
        String sql = "INSERT INTO STUDENT "
                   + "(NO, STUDENT_NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_ID) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, stu.getNo());
            ps.setString(2, stu.getStudentName());
            ps.setInt(3, stu.getEntYear());
            ps.setInt(4, stu.getClassNum());
            ps.setString(5, stu.getIsAttend());   // カラム名に合わせてそのままセット
            ps.setString(6, stu.getSchoolId());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        }
    }
}