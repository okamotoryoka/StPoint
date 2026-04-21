package Bean;

public class Subject implements java.io.Serializable {
	
	private String school_cd;
	private String cd;
	private String subject_name;
	
	public String getSchoolCd() {
		return school_cd;
	}
	
	public String getCd() {
		return cd;
	}
	
	public String getSubjectName() {
		return subject_name;
	}
	
	public void setSchoolCd(String school_cd) {
		this.school_cd = school_cd;
	}
	
	public void setCd(String cd) {
		this.cd = cd;
	}
	
	public void setSubjectName(String subject_name) {
		this.subject_name = subject_name;
	}
}