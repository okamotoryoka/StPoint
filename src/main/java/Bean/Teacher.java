package Bean;

public class Teacher implements java.io.Serializable {
	
	private String id;
	private String password;
	private String name;
	private School school; // school_cd から School型の school に変更
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	// Actionクラスから呼び出される必要なメソッドです
	public School getSchool() {
		return school;
	}
	
	public void setSchool(School school) {
		this.school = school;
	}

	// 新しく降ってきたTeacherDAOのエラーを消すために追加（ハイブリッド化）

	public void setSchoolCd(String schoolCd) {
		if (this.school == null) {
			this.school = new School();
		}
		this.school.setCd(schoolCd); 
	}

	public String getSchoolCd() {
		if (this.school != null) {
			return this.school.getCd(); 
		}
		return null;
	}

	public void setTeacherId(String teacherId) {
		this.id = teacherId;
	}

	public String getTeacherId() {
		return this.id;
	}

	public void setTeacherName(String teacherName) {
		this.name = teacherName;
	}

	public String getTeacherName() {
		return this.name;
	}

	public void setTeacherPass(String teacherPass) {
		this.password = teacherPass;
	}

	public String getTeacherPass() {
		return this.password;
	}
}
