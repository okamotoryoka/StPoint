package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Bean.Test;

public class TestDAO extends DAO {

public Test search(String student_no, String class_num) throws Exception {
        Test key = new Test();
        key.setStudentNo(student_no);
        key.setClassNum(class_num);
        return search(key);
    }

    // Test.java のプロパティをそのまま使って検索する
    public Test search(Test condition) throws Exception {
        Test test = null;

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(
                "SELECT student_no, subject_cd, school_cd, no, point, class_num "
                        + "FROM Test WHERE student_no = ? AND class_num = ?");

        st.setString(1, condition.getStudentNo());
        st.setString(2, condition.getClassNum());

        ResultSet rs = st.executeQuery();

        if (rs.next()) {
            test = mapResult(rs);
        }

        rs.close();
        st.close();
        con.close();

        return test;
    }

    private Test mapResult(ResultSet rs) throws Exception {
        Test test = new Test();
        test.setStudentNo(rs.getString("student_no"));
        test.setSubjectCd(rs.getString("subject_cd"));
        test.setSchoolCd(rs.getString("school_cd"));
        test.setNo(rs.getInt("no"));
        test.setPoint(rs.getInt("point"));
        test.setClassNum(rs.getString("class_num"));
        return test;
    }
    
    public List<Test> findByStudentNoJoin(String studentNo) throws Exception {
        List<Test> list = new ArrayList<>();
        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(
            "SELECT t.student_no, t.subject_cd, t.school_cd, t.no, t.point, t.class_num " +
            "FROM Student s " +
            "INNER JOIN Test t ON s.no = t.student_no " +
            "WHERE s.no = ?"
        );
        st.setString(1, studentNo);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            list.add(mapResult(rs));
        }
        rs.close();
        st.close();
        con.close();
        return list;
    }
}