package bean;

public class Admin implements java.io.Serializable {

	private String admin_id;
	private String admin_name;
	private String password;
    
    

    public String getAdminId() {
    	return admin_id;
    }
    
    public String getAdminName() {
    	return admin_name;
    }
    
    public String getAdminPass() {
    	return password;
    }

    public void setAdminId(String admin_id) {
    	this.admin_id = admin_id;
    }
    
    public void setAdminName(String admin_name) {
    	this.admin_name = admin_name;
    }
    
    public void setAdminPass(String password) {
    	this.password = password;
    }
   
}