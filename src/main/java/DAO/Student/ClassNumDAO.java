package DAO.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import DAO.DAO;

public class ClassNumDAO extends DAO {

    public List<String> filter(String schoolCd) throws Exception {
        List<String> list = new ArrayList<>();
        
        Connection connection = getConnection();
        
        PreparedStatement st = connection.prepareStatement(
            "SELECT DISTINCT class_num FROM student WHERE class_num IS NOT NULL ORDER BY class_num ASC"
        );
        
        ResultSet rs = st.executeQuery();
        
        while (rs.next()) {
            list.add(rs.getString("class_num"));
        }
        
        st.close();
        connection.close();
        
        return list;
    }
}
