import javax.xml.transform.Result;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class Task04 {
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

            //-----------task 4
            //Count the number of CIP, VIP, and OPs.
            // Also show the number of people that do not fall in any
            //of the categories




            //calculate balance
            HashMap<Integer, Integer> account_balance = new HashMap();
            sql = "SELECT A_ID, AMOUNT, TYPE FROM TRANSACTIONS";

            System.out.println("Executing the query: " + sql);
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()) {
                int a_id = rs.getInt("A_ID");
                int amount = rs.getInt("AMOUNT");
                String type = rs.getString("TYPE");

                //if map already has a_id
                if(account_balance.containsKey(a_id)){
                    if(type.charAt(0)=='0'){
                        account_balance.put(a_id, account_balance.get(a_id) - amount);
                    }
                    else{
                        account_balance.put(a_id, account_balance.get(a_id) + amount);
                    }
                }

                //if it does not exist
                else{
                    if(type.charAt(0)=='0'){
                        account_balance.put(a_id, - amount);
                    }
                    else{
                        account_balance.put(a_id, amount);
                    }
                }
            }





            ArrayList<Integer> id_traversed = new ArrayList<Integer>();


            // count_cip
            sql = "SELECT A_ID FROM TRANSACTIONS GROUP BY A_ID HAVING SUM(AMOUNT)>5000000" ;
            System.out.println("Executing the query: " + sql);
            rs = stmt.executeQuery(sql);

            int count_cip = 0;
            while(rs.next())
            {
                int a_id = rs.getInt("A_ID");
                if(account_balance.get(a_id) > 1000000){
                    count_cip++;
                    id_traversed.add(a_id);
                }

            }
            //printing
            System.out.print("Number of CIP accounts: " + count_cip + "\n");



            //count_vip
            sql = "SELECT A_ID FROM TRANSACTIONS GROUP BY A_ID HAVING SUM(AMOUNT)> 2500000 AND SUM(AMOUNT)<4500000" ;
            System.out.println("Executing the query: " + sql);
            rs = stmt.executeQuery(sql);
            int count_vip = 0;
            while(rs.next())
            {
                //count_vip
                int a_id =rs.getInt("a_id");

                if(account_balance.get(a_id) > 500000 && account_balance.get(a_id) <900000 && !id_traversed.contains(a_id)){
                    count_vip++;
                    id_traversed.add(a_id);
                }

            }
            //printing
            System.out.print("Number of VIP accounts: " + count_vip + "\n");




            //count_op
            sql = "SELECT A_ID FROM TRANSACTIONS GROUP BY A_ID HAVING SUM(AMOUNT)<1000000";
            System.out.println("Executing the query: " + sql);
            rs = stmt.executeQuery(sql);
            int count_op = 0;
            while(rs.next())
            {
                //count_op
                int a_id = rs.getInt("A_ID");

                if(account_balance.get(a_id) < 100000 && !id_traversed.contains(a_id)) {
                    id_traversed.add(a_id);
                    count_op++;
                }

            }
            //printing
            System.out.print("Number of OP accounts: " + count_op + "\n");


            //count_others
            int count_other = 0;
            for (HashMap.Entry<Integer,Integer> entry : account_balance.entrySet()){
                if(!id_traversed.contains(entry.getKey())){
                    count_other++;
                }
            }
            //printing
            System.out.print("Number of other accounts: " + count_other + "\n");


            rs.close();
            stmt.close();
            conn.close();
            System.out.println("Query of task 4 completed successfully!");
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
