package section2;

import java.sql.*;

public class Application2 {

    public static void main(String[] args) {

        String driver = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/mysql";
        String user = "yeonjin";
        String password = "yeonjin";

        Connection con = null;
        Statement stmt = null;
        ResultSet rset = null;


        try {
            Class.forName(driver);

            con = DriverManager.getConnection(url, user, password);
            System.out.println(con);

            stmt = con.createStatement();
            rset = stmt.executeQuery("select dept_title from department");


            while (rset.next()){

                System.out.println(rset.getString("dept_title"));
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }finally {
            if(rset != null) {
                try {
                    rset.close();
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if(stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if(con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }

        }

    }

}
