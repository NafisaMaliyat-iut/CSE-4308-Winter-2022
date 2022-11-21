import java.sql.*;

public class Task03 {
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

            //--------------task 3
            //List the transactions that occurred in the year 2020
            sql="SELECT T_ID, DTM, A_ID, AMOUNT, TYPE FROM TRANSACTIONS " +
                    "WHERE EXTRACT(YEAR FROM DTM) = 2020";
            System.out.println("Executing the query: " + sql);
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                //get date
                int t_id =rs.getInt("T_ID");
                Date dtm =rs.getDate("DTM");
                int a_id = rs.getInt("A_ID");
                int amount = rs.getInt("AMOUNT");
                String type = rs.getString("TYPE");

                //printing
                System.out.print("Transaction ID " + t_id +
                        " occurred at " + dtm + " where " + amount
                        + " taka has been");
                if(type.charAt(0)=='0')
                    System.out.print(" deposited to");
                else
                    System.out.print(" taken out from");
                System.out.println(" account " + a_id);
            }

            rs.close();
            stmt.close();
            conn.close();
            System.out.println("Query of task 3 completed successfully!");
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
