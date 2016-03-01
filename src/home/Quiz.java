package home;

import java.util.LinkedList;
import java.util.List;

public class Quiz {

	private String quizName;
	private List<Question> questions;
	private int id;
	
	private static int numQuizzes = 0;
	
	public Quiz(String quizName) {
		id = numQuizzes;
		numQuizzes++;
		this.quizName = quizName;
		questions = null;
	}
	
	public void initDefaultQuiz1() {
		questions = new LinkedList<Question>();
		questions.add(new ResponseQuestion("What is 1 + 1?", "2"));
		questions.add(new ResponseQuestion("_____ is the president.", "Obama"));
		questions.add(new ResponseQuestion("How many states are there?", "50"));
	}
	
	public List<Question> getQuestions() {
		return questions;
	}
	
	public String getName() {
		return quizName;
	}
	
	public int getId() {
		return id;
	}
	
	public String checkQuiz() {
		int correct = 0;
		int total = 0;
		
		for (Question q: questions) {
			total++;
			
			if (q.isCorrect())
				correct++;
		}
		
		return "Correct: " + correct + " | Total Questions: " + total; 
	}
}
