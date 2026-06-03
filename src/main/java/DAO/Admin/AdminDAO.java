package DAO.Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Bean.Admin;
import DAO.DAO;

public class AdminDAO extends DAO {
	public Admin search(String admin_name, String password) throws Exception {
		
		Admin admin = null;
		Connection con = getConnection();
		
		PreparedStatement st = con.prepareStatement(
				"select * from Admin where admin_name=? and password=? "
				);
		
		// 入力された値の前後の空白スペースを削って安全にセットします
		st.setString(1, admin_name != null ? admin_name.trim() : "");
		st.setString(2, password != null ? password.trim() : "");
		
		ResultSet rs = st.executeQuery(); 
		
		while (rs.next()) {
			admin = new Admin();
		
			admin.setAdminId(rs.getString("admin_id"));
			admin.setAdminName(rs.getString("admin_name"));
			admin.setAdminPass(rs.getString("password"));
		}
		
		rs.close();
		st.close();
		con.close();
		
		return admin;
	}
}
