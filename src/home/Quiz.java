package home;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.sql.Blob;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

@SuppressWarnings("serial")
public class Quiz implements java.io.Serializable {

	public int id;
	public String name;
	public String creatorName;
	public int numTaken;
	private List<Question> questions;
	public List<QuizResult> results;
	Date date;
	
	// Initializes quiz
	public Quiz(String name, String creatorName) {
		id = 0;
		this.name = name;
		this.creatorName = creatorName;
		numTaken = 0;
		questions = new ArrayList<Question>();
		results = new ArrayList<QuizResult>();
		date = new Date();
	}
	
	// Takes in a blob, returns a quiz
	public static Quiz blobToQuiz(Blob blob) 
			throws ClassNotFoundException, IOException, SQLException {
		byte[] bytes = blob.getBytes(1, (int) blob.length());
		return (Quiz) Serializer.deserialize(bytes);
	}
	
	// Returns a list of all the questions
	public List<Question> getQuestions() {
		return questions;
	}
	
	// Returns total number of questions
	public int getNumQuestions() {
		return questions.size();
	}
	
	public Date getDate() {
		return date;
	}
	
	// Returns total number of correct questions
	public int getNumCorrect() {
		int correct = 0;
		
		for (Question q: questions) {
			if (q.isCorrect())
				correct++;
		}
		
		return correct;
	}
	
	// Adds a question to the quiz
	public void addQuestion(Question question) {
		questions.add(question);
	}
	
	public void addResult(QuizResult qr) {
		results.add(qr);
		numTaken++;
	}
	
	public List<QuizResult> getResults() {
		return results;
	}
	
	public QuizResult getResultByDate(String dateStr) throws URISyntaxException {
		//SimpleDateFormat formatter = new SimpleDateFormat("MMM DD HH:mm:ss z PST yyyy");
		//Date date = formatter.parse(dateStr);
		
		for (QuizResult qr: results) {
			if (qr.getDate().toString().equals(dateStr))
				return qr;
		}
		
		return null;
	}
	
	public List<QuizResult> getTopResults() {
		List<QuizResult> top = new ArrayList<QuizResult>(results);
		
		if (top.size() == 0) return null;
		
		Collections.sort(top, new Comparator<QuizResult>() {
	        @Override
	        public int compare(QuizResult qr1, QuizResult qr2) {;
	        	return qr2.getScore() - qr1.getScore();
	        }
	    });
		
		return top;
	}
	
	public List<QuizResult> getRecentResults() {
		List<QuizResult> recent = new ArrayList<QuizResult>(results);
		
		if (recent.size() == 0) return null;
		
		Collections.sort(recent, new Comparator<QuizResult>() {
	        @Override
	        public int compare(QuizResult qr1, QuizResult qr2) {;
	        	return qr2.getDate().compareTo(qr1.getDate());
	        }
	    });
		
		return recent;
	}
}
