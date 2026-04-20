package bean;

public class Student implements java.io.Serializable {
	
	private String no;
	private String student_name;
	private int ent_year;
	private int class_num;
	private String is_attend;
	private String school_id;
	
	public String getNo() {
		return no;
	}
	
	public String getStudentName() {
		return student_name;
	}
	
	public int getEntYear() {
		return ent_year;
	}
	
	public int getClassNum() {
		return class_num;
	}
	
	public String getIsAttend() {
		return is_attend;
	}
	
	public String getSchoolId() {
		return school_id;
	}
	
	public void setNo(String no) {
		this.no = no;
	}
	
	public void setStudentName(String student_name) {
		this.student_name = student_name;
	}
	
	public void setEntYear(int ent_year) {
		this.ent_year = ent_year;
	}
	
	public void setClassNum(int class_num) {
		this.class_num = class_num;
	}
	
	public void setIsAttend(String is_attend) {
		this.is_attend = is_attend;
	}
	
	public void setSchoolId(String school_id) {
		this.school_id = school_id; 
	}
}