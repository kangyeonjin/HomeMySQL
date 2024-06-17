package section2;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Template {

    public static Connection getConnection(){

        Connection con =null;
        Properties prop = new Properties();

        try {

            prop.load(new FileReader("jdbc:mysql://localhost:3306/employee_db"));

            String driver = prop.getProperty("driver");
            String url = prop.getProperty("url");
            String user = prop.getProperty("user");
            String password = prop.getProperty("password");

            Class.forName(driver);

            con = DriverManager.getConnection(url, prop);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return con;
    }
    public static void close(Connection con){

        try {
            if(con != null && !con.isClosed())
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


}
