package home;

import java.io.IOException;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QuizManager {
	
	private Database db;
	private Map<Integer, Quiz> quizzes;
	private int largestId = 0;

	public QuizManager(Database db) {
		this.db = db;
		quizzes = new HashMap<Integer, Quiz>();
		ResultSet rs = db.runQuery("SELECT * FROM quizzes");
		
		try {
			while(rs.next()) {
				Blob quizBlob = rs.getBlob("data");
				Quiz quiz = Quiz.blobToQuiz(quizBlob);
				quizzes.put(quiz.id, quiz);
				
				if (quiz.id > largestId) 
					largestId = quiz.id;
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// Inserts quiz into database
	public void addQuizToDb(Quiz quiz) {
		quiz.id = largestId + 1;
		largestId = quiz.id;
		quizzes.put(quiz.id, quiz);
		
		try {
			db.insertQuiz(quiz);
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
	}
	
	// Returns a quiz corresponding to the given id
	public Quiz getQuizById(int id) {
		System.out.println("dskndlksnlkdsnlkdnslkfnd9999999");
		return quizzes.get(id);
	}
	
	// Currently just returns all quizzes
	public List<Quiz> getPopularQuizzes() {
		List<Quiz> popularQuizzes = new ArrayList<Quiz>(quizzes.values());
		
		Collections.sort(popularQuizzes, new Comparator<Quiz>() {
	        @Override
	        public int compare(Quiz q1, Quiz q2) {
	        	return q2.numTaken - q1.numTaken;
	        }
	    });
		
		return popularQuizzes;
	}
	
	public List<Quiz> getRecentlyCreatedQuizzes() {
		List<Quiz> recentlyCreatedQuizzes = new ArrayList<Quiz>(quizzes.values());
		
		if (recentlyCreatedQuizzes.size() == 0) return null;
		
		Collections.sort(recentlyCreatedQuizzes, new Comparator<Quiz>() {
	        @Override
	        public int compare(Quiz q1, Quiz q2) {;
	        	return q2.date.compareTo(q1.date);
	        }
	    });
		
		return recentlyCreatedQuizzes;
	}
	
	public void updateQuizInDb(Quiz quiz) {
		try {
			db.updateQuiz(quiz);
		} catch (SQLException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}