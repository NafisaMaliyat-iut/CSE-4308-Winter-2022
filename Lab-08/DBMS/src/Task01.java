import java.sql.*;

public class Task01 {
    static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
    static final String DB_URL= "jdbc:oracle:thin:@localhost:1521:xe";
    static final String USER="S200042133";
    static final String PASS="nafisamaliyat";

    public static void main (String args[]) {
        Connection conn = null;
        Statement stmt = null;
        try {
            Class.forName(JDBC_DRIVER);
            System.out.println("Connecting to database");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Creating statement");
            stmt = conn.createStatement();
            String sql;

            //----------task 1
            //Count the total number of transactions conducted under account 45
            sql = "SELECT COUNT(t_id) AS T_COUNT FROM TRANSACTIONS " +
                    "GROUP BY A_ID HAVING A_ID = 45";
            System.out.println("Executing the query: " + sql);
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                //get date
                int count = rs.getInt("T_COUNT");

                //printing
                System.out.print("Total number of "
                        + count );
                if(count==1)
                    System.out.print(" transaction");
                else
                    System.out.print(" transactions");
                System.out.print(" were conducted under account 45.\n");
            }

            rs.close();
            stmt.close();
            conn.close();
            System.out.println("Query of task 1 completed successfully!");
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
