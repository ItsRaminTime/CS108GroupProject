package home;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.*;

@SuppressWarnings("serial")
public class User implements java.io.Serializable {
	
	public String name;
	public String password;
	
	public boolean isAdmin;
	
	public int numQuizzesTaken;
	public int numQuizzesCreated;
	
	public ArrayList<QuizCreated> quizzesCreated;
	public ArrayList<QuizResult> quizzesTaken;
	
	public ArrayList<String> friends;
	public ArrayList<Message> messageList;
	
	public User(String name, String password) {
		this.name = name;
		this.password = generate(password);
		
		isAdmin = false;
		
		numQuizzesTaken = 0;
		numQuizzesCreated = 0;
		
		quizzesCreated = new ArrayList<QuizCreated>();
		quizzesTaken = new ArrayList<QuizResult>();
		
		friends = new ArrayList<String>();
		messageList = new ArrayList<Message>();
	}
	
	public static User createAdmin() {
		User admin = new User("admin", "admin");
		admin.setAdmin();
		return admin;
	}
	
	private void setAdmin() {
		isAdmin = true;
	}
	
	public boolean isAdmin() {
		return isAdmin;
	}
	
	public static User blobToUser(Blob blob) 
			throws ClassNotFoundException, IOException, SQLException {
		byte[] uBytes = blob.getBytes(1, (int) blob.length());
		return (User) Serializer.deserialize(uBytes);
	}
	
	public void addQuiz(QuizCreated qc) {
		quizzesCreated.add(qc);
	}
	
	// Given a string, we return the hash code
	public static String generate(String str) {
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA");
			byte[] hash = digest.digest(str.getBytes());
			return hexToString(hash);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return "";
		}
	}
	
	/*
	 Given a byte[] array, produces a hex String,
	 such as "234a6f". with 2 chars for each byte in the array.
	 (provided code)
	*/
	public static String hexToString(byte[] bytes) {
		StringBuffer buff = new StringBuffer();
		for (int i=0; i<bytes.length; i++) {
			int val = bytes[i];
			val = val & 0xff;  // remove higher bits, sign
			if (val<16) buff.append('0'); // leading 0
			buff.append(Integer.toString(val, 16));
		}
		return buff.toString();
	}
}