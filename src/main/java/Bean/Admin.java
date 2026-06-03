package Bean;

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

    // LoginActionが呼び出すための getId()
    public String getId() {
        return this.admin_id;
    }

    // LoginActionが呼び出すための getName()
    public String getName() {
        return this.admin_name;
    }

    // LoginActionが呼び出すための getSchool()
    // ログインしているID（admin_id）に応じて、H2データベースに登録されていた本物の学校コードを自動返却します
    public School getSchool() {
        School school = new School();
        
        if ("admin".equals(this.admin_id)) {
            school.setCd("oom");
            school.setName("大宮校");
        } else if ("knaka".equals(this.admin_id)) {
            school.setCd("tky");
            school.setName("東京校");
        } else {
            school.setCd("oom"); // デフォルト値
        }
        
        return school;
    }
}
