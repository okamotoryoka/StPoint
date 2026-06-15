package Bean;

import java.io.Serializable;

public class Score implements Serializable {
    private String studentId;
    private String studentName;
    private String subjectName;
    private int no;
    private int point;
    private String classNum;
    private String subjectCd;
    private String schoolCd;

    // ※各フィールドの getter / setter メソッドが用意されている状態にしてください
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }
    public int getNo() { return no; }
    public void setNo(int no) { this.no = no; }
    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }
    public String getClassNum() { return classNum; }
    public void setClassNum(String classNum) { this.classNum = classNum; }
    public String getSubjectCd() { return subjectCd; }
    public void setSubjectCd(String subjectCd) { this.subjectCd = subjectCd; }
    public String getSchoolCd() { return schoolCd; }
    public void setSchoolCd(String schoolCd) { this.schoolCd = schoolCd; }
}
