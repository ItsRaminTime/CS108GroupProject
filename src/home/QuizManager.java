package home;

import java.util.*;

public class QuizManager {
	
	private LinkedList<Quiz> allQuizzes;
	
	public QuizManager() {
		allQuizzes = new LinkedList<Quiz>();
		addDefaultQuizzes();
	}
	
	public List<Quiz> getPopularQuizzes() {
		return new LinkedList<Quiz>(allQuizzes);
	}
	
	public Quiz getQuizById(int id) {
		if (allQuizzes.size() > id)
			return allQuizzes.get(id);
		else
			return null;
	}
	
	private void addDefaultQuizzes() {
		Quiz quiz1 = new Quiz("defaultQuiz1");
		quiz1.initDefaultQuiz1();
		allQuizzes.add(quiz1);
	}
}
