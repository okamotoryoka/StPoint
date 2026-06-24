package Bean;

public class Student implements java.io.Serializable {
    
    private String no;
    private String name;      
    private int entYear;      
    private String classNum;  
    private boolean isAttend; 
    private School school;    
    private int grade;        // 追加: 学年
    
    // --- Getter ---
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
    // 設計図の指定名に修正
    public boolean isAttend() {
        return isAttend;
    }
    public School getSchool() {
        return school;
    }
    // 追加: 学年のゲッター
    public int getGrade() {
        return grade;
    }
    
    // --- Setter ---
    public void setNo(String no) {
        this.no = no;
    }
    public void setName(String name) { 
        this.name = name;
    }
    public void setEntYear(int entYear) {
        this.entYear = entYear;
    }
    public void setClassNum(String classNum) {
        this.classNum = classNum;
    }
    // 設計図の指定名に修正
    public void setAttend(boolean isAttend) { 
        this.isAttend = isAttend;
    }
    public void setSchool(School school) {
        this.school = school; 
    }
    // 追加: 学年のセッター
    public void setGrade(int grade) {
        this.grade = grade;
    }
}
