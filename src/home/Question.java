package home;

public class Question {
	protected boolean correct = false;
	protected String displayStr = "";
	protected String jsp = ""; 
	protected String correctAnswer = "";
	protected String givenAnswer = "";
	
	public boolean isCorrect() {
		return correct;
	}
	
	public String  getDisplayStr() {
		return displayStr;
	}

	public String getCorrectAnswer() {
		return correctAnswer;
	}
	
	public String getGivenAnswer() {
		return givenAnswer;
	}

	public String getJsp() {
		return jsp;
	}
	
	public void setResponse(String givenAnswer) {
		this.givenAnswer = givenAnswer;
		correct = givenAnswer.equals(correctAnswer);
	}
}
