package home;

import java.io.IOException;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.sql.rowset.serial.SerialException;

public class UserManager {
	
	private Map<String, User> users;
	Database db;
	
	public UserManager(Database db) {
		this.db = db;
		users = new HashMap<String, User>();
		ResultSet rs = db.runQuery("SELECT * FROM users");
		try {
			while(rs.next()) {
				Blob userBlob = rs.getBlob("data");
				User user = User.blobToUser(userBlob);
				users.put(user.name, user);
				System.out.println(user.name);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// Checks if the username is free
	public boolean canCreate(String username, String password) {
		return !users.containsKey(username) && !username.equals("") && !password.equals("");
	}
		
	// Checks if the username and password are correct 
	public boolean canLogin(String username, String password) {
		if (users.containsKey(username))
			return users.get(username).password.equals(password);
		
		return false;
	}
	
	// Returns a user based off of the username
	public User getUserByName(String username) {
		return users.get(username);
	}
		
	// Adds a user to the database
	public void createUser(String username, String password) {
		User user = new User(username, password);
		
		if (canCreate(username, password)) {
			try {
				db.insertUser(user);
				users.put(username, user);
			} catch (SerialException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
