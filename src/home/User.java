package home;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.*;

public class User implements java.io.Serializable {
	
	public String name;
	public String password;
	
	public ArrayList<String> quizzesTaken;
	public ArrayList<User> friends;
	public ArrayList<String> quizzesCreated;
	
	public ArrayList<Message> messageList;
	
	public int numQuizzesTaken;
	public int numQuizzesCreated;
	
	public String lastAction;
	
	public User(String name, String password) {
		quizzesTaken = new ArrayList<String>();
		friends = new ArrayList<User>();
		this.name = name;
		this.password = PasswordHash.hashPassword(password);
	}
	
	public static User blobToUser(Blob blob) 
			throws ClassNotFoundException, IOException, SQLException {
		byte[] uBytes = blob.getBytes(1, (int) blob.length());
		return (User) Serializer.deserialize(uBytes);
	}
	
	public boolean equals(User usr) {
		return this.name.equals(usr.name);
	}
	
}