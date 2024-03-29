import java.sql.*;
public class otest {
		// Replace the "USERID" and "PASSWORD" with your username and password to get this to work.
		// Note: Remember that your Oracle USERID for many of you is different than your regular login name
 		private static final String USERID = "USERID";
    		private static final String PASSWORD = "PASSWORD";

	public static void main(String[] args) {
		System.out.println("-------Oracle JDBC COnnection Testing ---------");
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
		} catch (ClassNotFoundException e){
			System.out.println("Where is your Oracle JDBC Driver?");
			e.printStackTrace();
			return;
		}
		
		System.out.println("Oracle JDBC Driver Registered!");
		Connection connection = null;
		
		try {
			 connection = DriverManager.getConnection(
			 		"jdbc:oracle:thin:@oracle.wpi.edu:1521:orcl", USERID, PASSWORD);
		} catch (SQLException e) {
			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			return;
		}
		System.out.println("Oracle JDBC Driver Connected!");
		
		// Performing the query
		try {
			Statement stmt = connection.createStatement();
			String str = "SELECT * FROM CUSTOMER";
			ResultSet rset = stmt.executeQuery(str);

			int custID = 0;
			String custName = "";
			String city = "";
			int age = 0;
			// Process the results
			while (rset.next()) {
				custID = rset.getInt("ID");
				custName = rset.getString("name");
				city = rset.getString("city");
				age = rset.getInt("age");
				System.out.println("ID: " + custID + "   Name: " + custName + "   City: " + city + "   Age: " + age);
			} // end while
						
			rset.close();
			stmt.close();
			connection.close();
		} catch (SQLException e) {
			System.out.println("Get Data Failed! Check output console");
			e.printStackTrace();
			return;			
		}

	}
}