package bean;

public class Teacher implements java.io.Serializable {
	
	private String teacher_id;
	private String password;
	private String teacher_name;
	private String school_cd;
	
	public String getTeacherId() {
		return teacher_id;
	}
	
	public String getTeacherPass() {
		return password;
	}
	
	public String getTeacherName() {
		return teacher_name;
	}
	
	public String getSchoolCd() {
		return school_cd;
	}
	
	public void setTeacherId(String teacher_id) {
		this.teacher_id = teacher_id;
	}
	
	public void setTeacherPass(String password) {
		this.password = password;
	}
	
	public void setTeacherName(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	
	public void setSchoolCd(String school_cd) {
		this.school_cd = school_cd;
	}
}