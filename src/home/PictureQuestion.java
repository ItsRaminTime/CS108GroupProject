package home;

public class PictureQuestion extends Question {
	
	public PictureQuestion(String question, String url, String answer) {
		displayStr = question;
		type = "Picture"; 
		correctAnswer = answer;
		this.url = url;
	}
}
