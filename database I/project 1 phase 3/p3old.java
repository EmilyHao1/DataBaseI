import java.sql.*;
import java.util.*; 
import java.util.Scanner;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;


public class p3 {
public static void main (String[] argv) {
    String userid = "";
    String password = "";
    String[] user_input;
    int arg_3 = 0;

    if (argv.length == 2) {
      System.out.println("1- Report Wine Information");
      System.out.println("2- Report Company Rep Information");
      System.out.println("3- Report Wine Label Form Information");
      System.out.println("4- Update Phone Number");
      System.out.println("5- Exit Program");

      return;
    }
    else if (argv.length == 3) {
      try {
        userid = argv[0];
        password = argv[1];
        arg_3 = Integer.parseInt(argv[2]);

        // when the third argument is not a number in 1,2,3,4
        if ((arg_3 > 5) || (arg_3 < 1)) {
          System.out.println("You can only input command 1, 2, 3, 4, 5!");
          return;
        }
        user_input = getInput(arg_3);
      }

      // When the third argument is not an Integer
      catch (NumberFormatException e) {
        System.out.println("You can only input command 1, 2, 3, 4, 5!");
        return;
      }
    } else {
      System.out.println("Your input should be in <username> <password> numberCommand format");
      return;
    }

    System.out.println("-------- Oracle JDBC Connection Testing ------");
    System.out.println("-------- Step 1: Registering Oracle Driver ------");
    try {
      Class.forName("oracle.jdbc.driver.OracleDriver");
    } catch (ClassNotFoundException e) {
      System.out.println("Where is your Oracle JDBC Driver? Did you follow the execution steps. ");
      System.out.println("");
      System.out.println("*****Open the file and read the comments in the beginning of the file****");
      System.out.println("");
      e.printStackTrace();
      return;
    }

    System.out.println("Oracle JDBC Driver Registered Successfully !");

    System.out.println("-------- Step 2: Building a Connection ------");
    Connection connection = null;
    try {
      connection = DriverManager.getConnection("jdbc:oracle:thin:@oracle.wpi.edu:1521:orcl", userid, password);
    } catch (SQLException e) {
      System.out.println("Connection Failed! Check output console");
      e.printStackTrace();
      return;
    }

    if (connection != null) {
      System.out.println("You made it. Connection is successful. Take control of your database now!");
      System.out.print(" ");
    } else {
      System.out.println("Failed to make connection!");
    }

    switch (arg_3) {
      case 1:
      getWineInfo(user_input[0], connection);
      break;
      case 2:
      getCompanyRep(user_input[0], connection);
      break;
      case 3:
      getWineLabelForm(user_input[0], connection);
      break;
      case 4:
      updatePhoneNumber(user_input[0], user_input[1], connection);
      break;
      case 5: 
      break; 
    }
  }
    // helper
  private static String[] getInput(int command) {
    System.out.print(" ");

    String[] command_input = new String[5];

    Scanner in = new Scanner(System.in);

    if (command == 4) {
      System.out.print("Enter Company Rep login Name:  ");
      command_input[0] = in.nextLine();

      System.out.print("Enter the Updated Phone Number: ");
      command_input[1] = in.nextLine();

    } else {
      switch(command) {
        case 1:
        System.out.print("Enter Wine ID: ");
        command_input[0] = in.nextLine();
        break;
        case 2:
        System.out.print("Enter Company Rep login name:  ");
        command_input[0] = in.nextLine();
        break;
        case 3:
        System.out.print("Enter Wine Label Form ID:  ");
        command_input[0] = in.nextLine();
        break;
        case 5: 
        break; 
      }
    }

    in.close();

    return command_input;
  }
    // functions
  // Q1
  public static void getWineInfo(String WineID, Connection connection){
  	int newWineID = Integer.parseInt(WineID); 
    try {

      Statement stmt = connection.createStatement();
      String str = "SELECT * FROM Wines WHERE WineID = '" + newWineID + "'";
      ResultSet rset = stmt.executeQuery(str);

      String Brand = "";
      String ClassType = "";
      double Alcohol = 0.0; 
      String Appellation = "";
      double netContent = 0.0; 
      String bottlerName = "";

      int count = 0;

      while (rset.next()) {
        count++;
        Brand = rset.getString("Brand");
        ClassType = rset.getString("ClassType");
        Alcohol = rset.getDouble("Alcohol"); 
        Appellation = rset.getString("Appellation");
        netContent = rset.getDouble("netContent"); 
        bottlerName = rset.getString("bottlerName");


        System.out.println(" ");
        System.out.println("Wine ID: " + newWineID);
        System.out.println("Wine Brand: " + Brand);
        System.out.println("Wine ClassType: " + ClassType);
        System.out.println("Wine Alcohol: " + Alcohol);
        System.out.println("Wine Appellation: " + Appellation);
        System.out.println("Wine netContent: " + netContent);
        System.out.println("Wine bottlerName: " + bottlerName);
      }

      if (count == 0) {
        System.out.println("There is no wine with this wineID!");
      }

      rset.close();
      stmt.close();
      connection.close();
    } catch (SQLException e) {
      System.out.println("Failed to get data! Try again!");
      e.printStackTrace();
      return;
    }
  }

    // functions
  // Q2
  public static void getCompanyRep(String RepLoginName, Connection connection){
    try {

      Statement stmt = connection.createStatement();
      String str = "SELECT * FROM Reps inner Join Accounts on Reps.loginName = Accounts.loginName WHERE Reps.LoginName = '" + RepLoginName + "'";
      ResultSet rset = stmt.executeQuery(str);

      String Role = "";
      int RepID = 0; 
      String CompanyName = "";
      String FullName = ""; 
      String phone = ""; 
      String email = ""; 

      int count = 0;

      while (rset.next()) {
        count++;
        Role = rset.getString("Role");
        RepID = rset.getInt("RepID");
        CompanyName = rset.getString("CompanyName");
        FullName = rset.getString("Name"); 
        phone = rset.getString("phone"); 
        email = rset.getString("email"); 



        System.out.println(" ");
        System.out.println("Rep LoginName: " + RepLoginName);
        System.out.println("Rep Role: " + Role);
        System.out.println("Rep RepID: " + RepID);
        System.out.println("Rep CompanyName: " + CompanyName);
        System.out.println ("Rep Full Name: " + FullName); 
        System.out.println ("Rep phone: " + phone); 
        System.out.println ("Rep email: " + email); 

       }


      if (count == 0) {
        System.out.println("There is no Rep with this RepLoginName!");
      }

      rset.close();
      stmt.close();
      connection.close();
    }
     catch (SQLException e) {
      System.out.println("Failed to get data! Try again!");
      e.printStackTrace();
      return;
    }
  
}
  // functions
  // Q3
  public static void getWineLabelForm(String formID, Connection connection){
  	int newformID = Integer.parseInt(formID); 
    try {

      Statement stmt = connection.createStatement();
      String str = "SELECT distinct *  FROM Forms natural join (select Reps.RepID, Accounts.Name as RepName From Reps inner Join Accounts on Reps.loginName = Accounts.loginName) natural Join (select distinct Accounts.name as AgentName From Process inner join Agents On Agents.TtbID = Process.TTBID inner join Accounts On Agents.TtbID = Process.TTBID )inner Join Wines on Forms.wineID = Wines.wineID WHERE Forms.formID = '" + newformID + "'";
      ResultSet rset = stmt.executeQuery(str);

      String status = "";
      String Brand = "";
      double vintage = 0.0; 
      String dateSubmitted = "";
      String dateRejected = "";
      String dateApproved = "";
      int currentReviwerID = 0;
      String repName = ""; 
      List<String> Agents = new ArrayList<String>();


      int count = 0;

      while (rset.next()) {
        count++;
        status = rset.getString("status");
        vintage = rset.getDouble("vintage"); 
        dateSubmitted = rset.getString("dateSubmitted");
        dateRejected = rset.getString("dateRejected");
        dateApproved = rset.getString("dateApproved");
        repName = rset.getString("RepName");
        Agents.add(rset.getString ("AgentName")); 
        System.out.println(Agents); 




        System.out.println(" ");
        System.out.println("Wine label Form formID: " + newformID);
        System.out.println("Wine label Form status: " + status);
        System.out.println("Wine label Form vintage: " + vintage);
        System.out.println("Wine label Form dateSubmitted: " + dateSubmitted);
        System.out.println("Wine label Form dateRejected: " + dateRejected);
        System.out.println("Wine label Form dateApproved: " + dateApproved);
        System.out.println("Wine label Form currentReviwerID: " + currentReviwerID);
        System.out.println("Wine label Form rep full name Name: " + repName);
      }
      if (count == 0) {
        System.out.println("There is no wine label form with this formID!");
      }

      rset.close();
      stmt.close();
      connection.close();
    } catch (SQLException e) {
      System.out.println("Failed to get data! Try again!");
      e.printStackTrace();
      return;
    }
  }
   // Q4
  public static void updatePhoneNumber(String RepLoginName, String phone, Connection connection) {
		try {
			String updateStr = "UPDATE Accounts SET phone = ? WHERE LoginName = ?";
			PreparedStatement pstatement = connection.prepareStatement(updateStr);

			pstatement.setString(1, phone);
			pstatement.setString(2, RepLoginName);

			pstatement.executeUpdate();

			pstatement.close();
			connection.close();
		} catch (SQLException e) {
      System.out.println("Failed to get data! Try again!");
			e.printStackTrace();
		}
	}

 } 