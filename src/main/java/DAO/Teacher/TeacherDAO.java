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
        
        // H2データベースの列名に合わせて検索
        PreparedStatement st = con.prepareStatement(
            "SELECT * FROM TEACHER WHERE ID = ? AND PASSWORD = ?"
        );
        
        st.setString(1, teacher_id);
        st.setString(2, password);
        
        ResultSet rs = st.executeQuery(); 
        
        if (rs.next()) {
            tea = new Teacher();
            
            // Beanに新しく追加されたメソッド群を使って値を格納します
            tea.setTeacherId(rs.getString("ID"));         
            tea.setTeacherName(rs.getString("NAME"));     
            tea.setTeacherPass(rs.getString("PASSWORD"));
            
            // 内部で自動的に School オブジェクトが組み立てられます
            tea.setSchoolCd(rs.getString("SCHOOL_CD")); 
        }
        
        rs.close();
        st.close();
        con.close();
        
        return tea;
    }
}
