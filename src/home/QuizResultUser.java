package home;

import java.util.*;


public class QuizResultUser {
	private String name;
	private String id;
	private int highScore;
	private int numTimesTaken;
	public ArrayList<QuizResult> resultList;
	
	public QuizResultUser() {
		resultList = new ArrayList<QuizResult>();
	}
	
	void setName(String name) {
		this.name = name;
	}
	
	String getName() {
		return name;
	}
	
	void setID(String id) {
		this.id = id;
	}
	
	String getID() {
		return id;
	}
	
	void setHighScore(int score) {
		highScore = score;
	}
	
	int getHighScore() {
		return highScore;
	}
	
	void setTimesTaken(int num) {
		numTimesTaken = num;
	}
	
	void incrementTimesTaken() {
		int num = numTimesTaken;
		num++;
		setTimesTaken(num);
	}
	
	int getTimesTaken() {
		return numTimesTaken;
	}
	
}
