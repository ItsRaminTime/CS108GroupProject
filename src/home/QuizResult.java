package home;

import java.util.*;

public class QuizResult {
	
	private Date date;
	private int score;
	private int duration;
	
	public QuizResult(Date date, int score, int duration) {
		this.date = date;
		this.score = score;
		this.duration = duration;
	}
	
	void setDate(Date date) {
		this.date = date;
	}
	
	Date getDate() {
		return date;
	}
	
	void setScore(int score) {
		this.score = score;
	}
	
	int getScore() {
		return score;
	}
	
	void setDuration(int duration) {
		this.duration = duration;
	}
	
	int getDuration() {
		return duration;
	}
}