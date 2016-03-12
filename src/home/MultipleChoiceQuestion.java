package home;

import java.util.List;

public class MultipleChoiceQuestion extends Question{
	public MultipleChoiceQuestion(String question, String answer, List<String> options) {
		displayStr = question;	
		correctAnswer = answer;
		this.options = options;
		type = "multchoice";
	}
}
