package home;

import java.util.Date;
import java.util.List;

public class QuizCreated implements java.io.Serializable {
	public int quizId;
	public String quizName;
	public String creatorName;
	public Date date;
	
	public QuizCreated(Quiz quiz)  {
		quizId = quiz.id;
		quizName = quiz.name;
		creatorName = quiz.creatorName;
		date = new Date(); 
	}
	
	
}
