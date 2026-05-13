package Bean;

public class Test implements java.io.Serializable {
	
	private String student_no;
	private String subject_cd;
	private String school_cd;
	private int no;
	private int point;
	private String class_num;
	
	public String getStudentNo() {
		return student_no;
	}
	
	public String getSubjectCd() {
		return subject_cd;
	}
	
	public String getSchoolCd() {
		return school_cd;
	}
	
	public int getNo() {
		return no;
	}
	
	public int getPoint() {
		return point;
	}
	
	public String getClassNum() {
		return class_num;
	}
	
	public void setStudentNo(String student_no) {
		this.student_no = student_no;
	}
	
	public void setSubjectCd(String subject_cd) {
		this.subject_cd = subject_cd;
	}
	
	public void setSchoolCd(String school_cd) {
		this.school_cd = school_cd;
	}
	
	public void setNo(int no) {
		this.no = no;
	}
	
	public void setPoint(int point) {
		this.point = point;
	}
	
	public void setClassNum(String class_num) {
		this.class_num = class_num;
	}
}