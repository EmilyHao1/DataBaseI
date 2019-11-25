import java.sql.*;
import java.util.*; 
import java.util.Scanner;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

/**
  * CS 3431 Project Phase 3
  *
  * @author Haozhe Jiang, Emily Hao
  *
  */

public class p3 {
	private static String userID = "";
	private static String password = "";
	private static int mode;
	private static Connection connection;
	
    public static boolean login() {
        System.out.println("-------Oracle JDBC Connection Testing---------");
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

        } catch (ClassNotFoundException e){
            System.out.println("Where is your Oracle JDBC Driver?");
            e.printStackTrace();
            return false;
        }

        System.out.println("Oracle JDBC Driver Registered!");

        try {
             connection = DriverManager.getConnection(
                     "jdbc:oracle:thin:@oracle.wpi.edu:1521:orcl", userID, password);
        } catch (SQLException e) {
            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return false;
        }
        System.out.println("Oracle JDBC Driver Connected!");
        return true;
    }
	
	public static void printUsage(){
        System.out.println("1 - Report Wine Information");
        System.out.println("2 - Report Company Rep Information");
        System.out.println("3 - Report Wine Label Form Information");
        System.out.println("4 - Update Phone Number");
        System.out.println("5 - Exit Program");
    }
	
	public static void runQuery(Object arg) {
		
		try {
			Statement stmt = connection.createStatement();
			String str = null;
			
			if(mode == 1) {
				str = "SELECT * FROM Wines WHERE wineID = '"+arg+"'";
			}
			if(mode == 2) {
				str = "SELECT * FROM Reps inner Join Accounts on Reps.loginName = Accounts.loginName WHERE Reps.LoginName = '" + arg + "'";
			}
			if(mode == 3) {
				str = "select distinct Forms.formID, Forms.status, brand, vintage, name as RepName, Process.ttbID, AgentName "
						+ " from Forms join Wines on Forms.wineID = Wines.wineID join Reps on Forms.RepID = Reps.RepID" 
						+ " join Accounts on Reps.loginName = Accounts.loginName join Process on Forms.formID = Process.formID" 
						+ " join (select Process.ttbID, name as AgentName from Accounts join Agents on Accounts.loginName = Agents.loginName" 
						+ " join Process on Agents.ttbID = Process.ttbID order by Process.formID, Process.ttbID) A on Process.ttbID = A.ttbID" 
						+ " where Forms.formID = '" + arg + "'"
						+ " order by Forms.formID";
						}

			 ResultSet rset = stmt.executeQuery(str);

    
            while(rset.next()) {
            //System.out.println(rset.getString("AgentName"));

            	if (mode == 1) {
                    System.out.println("Wines Information");
                    System.out.println("Wine ID: " + rset.getString("WineID"));
                    System.out.println("Brand Name: " + rset.getString("Brand"));
                    System.out.println("Class/Type: " + rset.getString("ClassType"));
                    System.out.println("Alcohol: " + rset.getDouble("Alcohol") + "%");
                    System.out.println("Appellation: "+ rset.getString("Appellation"));
                    System.out.println("Net Content: "+ rset.getDouble("netContent"));
                    System.out.println("Bottler: "+ rset.getString("bottlerName"));
                }
            	if(mode == 2) {
            		System.out.println("Company Representative Information");
            		System.out.println("Login Name: " + rset.getString("loginName"));
            		System.out.println("RepID: " + rset.getString("repID"));
            		System.out.println("FullName: " + rset.getString("name"));
            		System.out.println("Phone: " + rset.getString("phone"));
            		System.out.println("Email Address: " + rset.getString("email"));
            		System.out.println("Company Name: " + rset.getString("companyName"));
            	}
            	if(mode == 3) {
            		System.out.println("Wine Label Form Information");
            		System.out.println("Form ID: " + rset.getString("formID"));
            		System.out.println("Status: " + rset.getString("status"));
            		System.out.println("WineBrand: " + rset.getString("brand"));
            		System.out.println("Vintage: " + rset.getString("vintage"));
            		System.out.println("Company Rep Full Name: " + rset.getString("RepName"));
                System.out.println("Company Agent Full Name: " + rset.getString("AgentName"));
                while(rset.next()) {
                System.out.println("Company Agent Full Name: " + rset.getString("AgentName"));
                }
            	}
            }
		}
		catch(SQLException e){
			System.out.println("Get Data Failed! Check output console");
            e.printStackTrace();
            return;
		}
	}
	
	public static void runUpdate(String loginName, int phone) {
		try {
			Statement stmt = connection.createStatement();
			String s = "UPDATE Accounts SET phone = '" + phone + "'  WHERE LoginName = '" + loginName + "'";
			int count = stmt.executeUpdate(s);
		}
		catch (SQLException e){
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		
		if(args.length < 2) {
			System.out.println("Username and password should be included as parameters!");
		}
		
		userID = args[0];
		password = args[1];
		
		if(!login()) return;
		
		if(args.length == 2) {
			printUsage();
			return;
		}
		
		mode = Integer.parseInt(args[2]);
		Scanner s = new Scanner(System.in);
		
		if(mode == 1) {
			System.out.print("Enter Wine ID: ");
			int wineID = s.nextInt();
			runQuery(wineID);
		}
		
		if(mode == 2) {
			System.out.print("Enter Company Rep login name: ");
			String loginName = s.nextLine();
			runQuery(loginName);
		}
		
		if(mode == 3) {
			System.out.print("Enter Wine Label Form ID: ");
			int formID = s.nextInt();
			runQuery(formID);
		}
		
		if(mode == 4) {
			System.out.print("Enter Company Rep Login Name: ");
			String loginName = s.nextLine();
			System.out.print("Enter the Updated Phone Number: ");
			int phone = s.nextInt();
			runUpdate(loginName, phone);
		}
		
		s.close();
		
		if(mode == 5) {
			System.out.println("exiting");
			return;
		}
	}
}