package home;

import home.Question;

@SuppressWarnings("serial")
public class TrueFalseQuestion extends Question {
	public TrueFalseQuestion(String question, String answer) {
		displayStr = question;	
		correctAnswer = answer;
		type = "truefalse";
	}
}
