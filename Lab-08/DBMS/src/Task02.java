import java.sql.*;

public class Task02 {
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

            //------------task 2
            //Count the number of debits (type=1)
            sql="SELECT COUNT(t_id) AS COUNT_DEBIT FROM TRANSACTIONS " +
                    "WHERE TYPE = 1";
            System.out.println("Executing the query: " + sql);
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                //get date
                int count =rs.getInt("COUNT_DEBIT");

                //printing
                System.out.print("Total number of debits is " + count+ "\n");
            }

            rs.close();
            stmt.close();
            conn.close();
            System.out.println("Query of task 2 completed successfully!");
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
