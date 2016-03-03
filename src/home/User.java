package home;

import java.util.*;

public class User {
	
	public String name;
	public String password;
	
	public ArrayList<String> quizzesTaken;
	public ArrayList<User> friends;
	public ArrayList<String> quizzesCreated;
	
	public int numQuizzesTaken;
	public int numQuizzesCreated;
	
	public String lastAction;
	
	
	public User(String name, String password) {
		quizzesTaken = new ArrayList<String>();
		friends = new ArrayList<User>();
		this.name = name;
		this.password = password;
	}
}