package DAO.Subject; // パッケージ名を正確に指定します

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Bean.School;
import Bean.Subject;
import DAO.DAO; // 親クラスのDAOをインポート

public class SubjectDAO extends DAO {

    public Subject get(String cd, School school) throws Exception {
        Subject subject = null;
        Connection connection = getConnection();
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            String sql = "SELECT * FROM subject WHERE cd = ? AND school_cd = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, cd);
            statement.setString(2, school.getCd());
            
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                subject = new Subject();
                subject.setCd(resultSet.getString("cd"));
                subject.setName(resultSet.getString("name"));
                subject.setSchool(school);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }

        return subject;
    }

    public List<Subject> filter(School school) throws Exception {
        List<Subject> list = new ArrayList<>();
        Connection connection = getConnection();
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            String sql = "SELECT * FROM subject WHERE school_cd = ? ORDER BY cd ASC";
            statement = connection.prepareStatement(sql);
            statement.setString(1, school.getCd());
            
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Subject subject = new Subject();
                subject.setCd(resultSet.getString("cd"));
                subject.setName(resultSet.getString("name"));
                subject.setSchool(school);
                list.add(subject);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }

        return list;
    }

    public boolean save(Subject subject) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        int count = 0;

        try {
            Subject exists = get(subject.getCd(), subject.getSchool());
            
            if (exists != null) {
                String sql = "UPDATE subject SET name = ? WHERE cd = ? AND school_cd = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, subject.getName());
                statement.setString(2, subject.getCd());
                statement.setString(3, subject.getSchool().getCd());
            } else {
                String sql = "INSERT INTO subject (cd, name, school_cd) VALUES (?, ?, ?)";
                statement = connection.prepareStatement(sql);
                statement.setString(1, subject.getCd());
                statement.setString(2, subject.getName());
                statement.setString(3, subject.getSchool().getCd());
            }

            count = statement.executeUpdate();
            
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }

        return count > 0;
    }
}
