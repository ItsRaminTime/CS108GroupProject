package home;

import home.Question;

@SuppressWarnings("serial")
public class FillBlankQuestion extends Question {
	// Difference between this and response, is that this simulates a blank spot
	// When you initialize it, it replaces % with a blank
	public FillBlankQuestion(String question, String answer) {
		displayStr = question.replaceAll("%", "_______");
		correctAnswer = answer;
		type = "fillblank";
	}
}
