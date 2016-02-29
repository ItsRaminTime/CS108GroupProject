package home;

import java.util.*;

public class User {
	
	public String name;
	public String id;
	
	public ArrayList<String> quizzesTaken;
	public ArrayList<User> friends;
	public ArrayList<String> quizzesCreated;
	
	public int numQuizzesTaken;
	public int numQuizzesCreated;
	
	public String lastAction;
	
	
	public User() {
		quizzesTaken = new ArrayList<String>();
		friends = new ArrayList<User>();
	}
}