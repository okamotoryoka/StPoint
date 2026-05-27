package score;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:h2:~/stpoint";
    private static final String USER = "sa";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws Exception {

        Class.forName("org.h2.Driver");

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }
}