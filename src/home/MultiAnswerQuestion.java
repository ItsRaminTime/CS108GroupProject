package home;

public class MultiAnswerQuestion extends Question {
	
	public MultiAnswerQuestion(String question, String answer, int numAnswers) {
		displayStr = question;
		type = "MultiAnswer"; 
		correctAnswer = answer;
		this.numAnswers = numAnswers;
	}
}
