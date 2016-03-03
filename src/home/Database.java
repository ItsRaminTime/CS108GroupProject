package home;

import java.util.*;
import java.sql.*;

public class Database {

	public static final String MYSQL_USERNAME = "ccs108rahmari";
	public static final String MYSQL_PASSWORD = "nggD9zLqkvr2Wgnh";
	public static final String MYSQL_DATABASE_SERVER = "mysql-user.stanford.edu";
	public static final String MYSQL_DATABASE_NAME = "c_cs108_rahmari";

	public ArrayList<User> users;
	public ArrayList<Quiz> quizzes;

	public Database()  {
	
		users = new ArrayList<User>();
		quizzes = new ArrayList<Quiz>();

		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://" + MYSQL_DATABASE_SERVER, MYSQL_USERNAME, MYSQL_PASSWORD);

			Statement stmt = con.createStatement();
			stmt.executeQuery("USE " + MYSQL_DATABASE_NAME);
			ResultSet rs = stmt.executeQuery("SELECT * FROM users");
			
			while(rs.next()) {
				User user;
				user = (User)rs.getBlob("data");
				users.add(user);
			}
			
			rs = stmt.executeQuery("SELECT * FROM quizzes");
			
			while(rs.next()) {
				Quiz quiz;
				quiz = (Quiz)rs.getBlob("data");
				quizzes.add(quiz);
			}
			con.close();

		} catch (SQLException e) {
			System.out.println("SQL Exception!");
			System.exit(0);

		} catch (ClassNotFoundException e) {
			System.out.println("Class Not Found Exception!");
			System.exit(0);
		}
	}

}

