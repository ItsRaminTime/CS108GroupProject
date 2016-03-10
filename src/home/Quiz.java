package home;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

public class Quiz implements java.io.Serializable {

	public int id;
	public String name;
	private List<Question> questions;	
	private static int numQuizzes = 0;
	public int nVisits = 0;
	public HashMap<String, ArrayList<Integer>> scores;
	public int numReported;
	HashMap<String, Integer> ratings; 
	
	// Initializes quiz
	public Quiz(String name) {
		id = numQuizzes;
		this.name = name;
		questions = new ArrayList<Question>();
		numQuizzes++;
		scores = new HashMap<String, ArrayList<Integer>>();
		ratings = new HashMap<String, Integer>();
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
}
