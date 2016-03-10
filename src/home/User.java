package home;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.*;

@SuppressWarnings("serial")
public class User implements java.io.Serializable {
	
	public String name;
	public String password;
	
	public int numQuizzesTaken;
	public int numQuizzesCreated;
	
	public ArrayList<QuizCreated> quizzesCreated;
	public ArrayList<QuizResult> quizzesTaken;
	
	public ArrayList<String> friends;
	public ArrayList<Message> messageList;
	
	public User(String name, String password) {
		this.name = name;
		this.password = password;
		
		numQuizzesTaken = 0;
		numQuizzesCreated = 0;
		
		quizzesCreated = new ArrayList<QuizCreated>();
		quizzesTaken = new ArrayList<QuizResult>();
		
		friends = new ArrayList<String>();
		messageList = new ArrayList<Message>();
	}
	
	public static User blobToUser(Blob blob) 
			throws ClassNotFoundException, IOException, SQLException {
		byte[] uBytes = blob.getBytes(1, (int) blob.length());
		return (User) Serializer.deserialize(uBytes);
	}
	
	public void addQuiz(QuizCreated qc) {
		quizzesCreated.add(qc);
	}
}