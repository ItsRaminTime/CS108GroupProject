package home;

import java.util.List;

@SuppressWarnings("serial")
public class Question implements java.io.Serializable {
	protected boolean correct = false;
	protected String displayStr = "";
	protected String correctAnswer = "";
	protected String givenAnswer = "";
	protected String type = "";
	protected List<String> options = null;
	
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
	
	public List<String> getOptions() {
		return options;
	}
}
