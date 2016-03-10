package home;

import home.Question;

@SuppressWarnings("serial")
public class ResponseQuestion extends Question {
	public ResponseQuestion(String question, String answer) {
		displayStr = question;
		correctAnswer = answer;
	}
}
