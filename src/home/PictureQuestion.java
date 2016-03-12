package home;

public class PictureQuestion extends Question {
	public PictureQuestion(String question, String answer) {
		displayStr = question;
		correctAnswer = answer;
		type = "pic";
	}
}
