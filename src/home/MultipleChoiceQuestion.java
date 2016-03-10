package home;

public class MultipleChoiceQuestion extends Question {
	
	public MultipleChoiceQuestion(String question, String option1, String option2, String option3, String option4, String answer) {
		displayStr = question;
		type = "Multiple"; 
		correctAnswer = answer;
		this.option1 = option1;
		this.option2 = option2;
		this.option3 = option3;
		this.option4 = option4;
	}
}
