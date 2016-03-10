package home;

public class ResponseQuestion extends Question {
	public ResponseQuestion(String question, String answer) {
		displayStr = question;
		correctAnswer = answer;
		type = "Response";
	}
}
