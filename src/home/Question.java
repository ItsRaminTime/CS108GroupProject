package home;

public class Question implements java.io.Serializable {
	protected boolean correct = false;
	protected String displayStr = "";
	protected String correctAnswer = "";
	protected String givenAnswer = "";
	protected String type = "";
	protected String option1 = "";
	protected String option2 = "";
	protected String option3 = "";
	protected String option4 = "";
	
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
	
	public void setResponse(String givenAnswer) {
		this.givenAnswer = givenAnswer;
		correct = givenAnswer.equals(correctAnswer);
	}
	
	public String getType() {
		return type;
	}
	
	public String getOption1() {
		return option1;
	}
	
	public String getOption2() {
		return option2;
	}
	
	public String getOption3() {
		return option3;
	}
	
	public String getOption4() {
		return option4;
	}
}
