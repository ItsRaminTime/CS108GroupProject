package home;

import java.io.IOException;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.rowset.serial.SerialException;

public class UserManager {
	
	public Map<String, User> users;
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
				System.out.println(user.name +  " | " + user.password);
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
	
	public void updateUserInDb(User user) {
		try {
			db.updateUser(user);
		} catch (SQLException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public List<QuizCreated> getRecentlyCreatedQuizzes(User curUser) {
		if (curUser == null)
			return null;
		
		if (curUser.numQuizzesCreated == 0)
			return null;
		
		List<QuizCreated> recentlyCreatedQuizzes = new ArrayList<QuizCreated>(curUser.quizzesCreated);
		
		Collections.sort(recentlyCreatedQuizzes, new Comparator<QuizCreated>() {
	        @Override
	        public int compare(QuizCreated qc1, QuizCreated qc2) {;
	        	return qc2.date.compareTo(qc1.date);
	        }
	    });
		
		return recentlyCreatedQuizzes;
	}
	
	public List<QuizResult> getRecentlyTakenQuizzes(User curUser) {
		if (curUser == null)
			return null;
		
		if (curUser.numQuizzesTaken == 0)
			return null;
		
		List<QuizResult> recentlyTakenQuizzes = new ArrayList<QuizResult>(curUser.quizzesTaken);
		
		Collections.sort(recentlyTakenQuizzes, new Comparator<QuizResult>() {
	        @Override
	        public int compare(QuizResult q1, QuizResult q2) {;
	        	return q2.getDate().compareTo(q1.getDate());
	        }
	    });
		
		return recentlyTakenQuizzes;
	}
}
