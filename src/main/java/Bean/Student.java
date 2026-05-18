package Bean;

public class Student implements java.io.Serializable {
	
	private String no;
	private String name;      // student_name から name に変更
	private int entYear;      // ent_year から entYear に変更
	private String classNum;  // int から String に変更（設計図に合わせる）
	private boolean isAttend; // String から boolean に変更（設計図に合わせる）
	private School school;    // String school_id から Schoolクラス に変更
	
	// --- Getter（取得） ---
	public String getNo() {
		return no;
	}
	public String getName() {
		return name;
	}
	public int getEntYear() {
		return entYear;
	}
	public String getClassNum() {
		return classNum;
	}
	public boolean isIsAttend() {
		return isAttend;
	}
	public School getSchool() {
		return school;
	}
	
	// --- Setter（セット） ---
	public void setNo(String no) {
		this.no = no;
	}
	public void setName(String name) { // これでActionのエラーが消えます
		this.name = name;
	}
	public void setEntYear(int entYear) {
		this.entYear = entYear;
	}
	public void setClassNum(String classNum) {
		this.classNum = classNum;
	}
	public void setIsAttend(boolean isAttend) { // booleanを受け取るように修正
		this.isAttend = isAttend;
	}
	public void setSchool(School school) {
		this.school = school; 
	}
}
