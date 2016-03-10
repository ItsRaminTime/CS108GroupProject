package home;

import java.util.*;

@SuppressWarnings("serial")
public class QuizResult implements java.io.Serializable {
	
	private int quizId;
	private String quizName;
	private String creatorName;
	private String username;
	private int score;
	private int total;
	private Date date;
	private List<Question> questions;
	
	public QuizResult(Quiz quiz, String username, List<Question> questions) {
		this.quizId = quiz.id;
		this.username = username;
		this.questions = questions;
		
		quizName = quiz.name;
		creatorName = quiz.creatorName;
		score = quiz.getNumCorrect();
		total = questions.size();
		date = new Date();
	}
	
	public int getQuizId() {
		return quizId;
	}
	
	public String getQuizName() {
		return quizName;
	}
	
	public String getCreatorName() {
		return creatorName;
	}
	
	
	public String getUsername() {
		return username;
	}
	
	public int getScore() {
		return score;
	}
	
	public int getTotal() {
		return total;
	}
	
	public Date getDate() {
		return date;
	}

	public List<Question> getQuestions() {
		return new ArrayList<Question> (questions);
	}
}