package Bean;

// クラス図に合わせ、フィールド名と型を変更します
public class Subject implements java.io.Serializable {
	
	private String cd;
	private String name;      // subject_name から name に変更
	private School school;    // String school_cd から School school に変更
	
	// cd のゲッター・セッター
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	
	// name のゲッター・セッター（クラス図の getName / setName に合わせます）
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	// school のゲッター・セッター（DAOが呼び出しているメソッドです）
	public School getSchool() {
		return school;
	}
	public void setSchool(School school) {
		this.school = school;
	}
}
