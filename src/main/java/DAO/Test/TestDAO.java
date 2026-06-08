package DAO.Test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import Bean.School;
import Bean.Student;
import Bean.Subject;
import Bean.Test;

public class TestDAO {

    // クラス図に定義されている通りのメソッド名、引数、戻り値の型
    public List<Test> filter(School school, int entYear, String classNum, Subject subject) throws Exception {
        List<Test> list = new ArrayList<>();
        
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        
        // 学校コード、入学年度、クラス、科目に一致する学生と、すでに登録されている点数を取得するSQL
        String sql = 
            "SELECT " +
            "  st.NO AS student_no, " +
            "  st.NAME AS student_name, " +
            "  st.CLASS_NUM AS class_num, " +
            "  t.POINT AS point, " +
            "  t.NO AS test_no " +
            "FROM STUDENT st " +
            "LEFT JOIN TEST t " +
            "  ON st.NO = t.STUDENT_NO " +
            "  AND st.SCHOOL_CD = t.SCHOOL_CD " +
            "  AND t.SUBJECT_CD = ? " +
            "WHERE UPPER(TRIM(st.SCHOOL_CD)) = UPPER(TRIM(?)) " +
            "  AND st.ENT_YEAR = ? " +
            "  AND st.CLASS_NUM = ? " +
            "ORDER BY st.NO ASC";
            
        try (Connection con = ds.getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, subject.getCd());
            st.setString(2, school.getCd());
            st.setInt(3, entYear);
            st.setString(4, classNum);
            
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Test test = new Test();
                    
                    // 学生オブジェクト（Student）を生成してセット
                    Student student = new Student();
                    student.setNo(rs.getString("student_no"));
                    student.setName(rs.getString("student_name"));
                    student.setClassNum(rs.getString("class_num"));
                    student.setSchool(school);
                    student.setEntYear(entYear);
                    test.setStudent(student);
                    
                    // 科目と学校をセット
                    test.setSubject(subject);
                    test.setSchool(school);
                    
                    // 回数と点数をセット（点数がnullの場合は-1等の初期値にするか、独自仕様に合わせます）
                    test.setNo(rs.getInt("test_no"));
                    test.setPoint(rs.getInt("point"));
                    if (rs.wasNull()) {
                        test.setPoint(-1); // 点数が未登録の場合は-1
                    }
                    
                    list.add(test);
                }
            }
        }
        return list;
    }
}
