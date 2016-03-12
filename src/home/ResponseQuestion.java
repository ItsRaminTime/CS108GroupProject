package home;

import home.Question;

@SuppressWarnings("serial")
public class ResponseQuestion extends Question {
	// Simplest question form. Just a question and answer
	public ResponseQuestion(String question, String answer) {
		displayStr = question;
		correctAnswer = answer;
		type = "response";
	}
}
