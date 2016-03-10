package home;

public class MultipleChoiceCheckbox extends Question {
	
	public MultipleChoiceCheckbox(String question, String option1, String option2, String option3, String option4, String answer1, String answer2, String answer3, String answer4) {
		displayStr = question;
		type = "Checkbox"; 
		correctAnswer = answer1;
		correctAnswer2 = answer2;
		correctAnswer3 = answer3;
		correctAnswer4 = answer4;
		this.option1 = option1;
		this.option2 = option2;
		this.option3 = option3;
		this.option4 = option4;
	}
}
