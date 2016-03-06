package home;

import java.io.IOException;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

public class QuizManager {
	
	private Map<Integer, Quiz> quizzes;
	Database db;

	public QuizManager(Database db) {
		this.db = db;
		quizzes = new HashMap<Integer, Quiz>();
		ResultSet rs = db.runQuery("SELECT * FROM quizzes");
		try {
			while(rs.next()) {
				Blob quizBlob = rs.getBlob("data");
				Quiz quiz = Quiz.blobToQuiz(quizBlob);
				quizzes.put(quiz.id, quiz);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		/*
		try {
			insertDefaultQuizzes();
		} catch (SerialException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		*/
	}
	
	// Put default quizzes here
	private void insertDefaultQuizzes() 
			throws SerialException, SQLException, IOException {
		Quiz quiz1 = new Quiz("Math Quiz");
		quiz1.addQuestion(new ResponseQuestion("1 + 1 = ?", "2"));
		quiz1.addQuestion(new ResponseQuestion("5 x 4 = ?", "20"));
		quiz1.addQuestion(new ResponseQuestion("10 / 2 = ?", "5"));
		quizzes.put(quiz1.id, quiz1);
		db.insertQuiz(quiz1);

		Quiz quiz2 = new Quiz("President Quiz");
		quiz2.addQuestion(new ResponseQuestion("Who was the 1st president?", "George Washington"));
		quiz2.addQuestion(new ResponseQuestion("Who is the current president", "Barrack Obama"));
		quiz2.addQuestion(new ResponseQuestion("Who is the next president?", "Donald Trump"));
		quizzes.put(quiz2.id, quiz2);
		db.insertQuiz(quiz2);
		
		Quiz quiz3 = new Quiz("Science Quiz");
		quiz3.addQuestion(new ResponseQuestion("_____ is the powerhouse of the cell.", "mithochondira"));
		quiz3.addQuestion(new ResponseQuestion("How many chromosomes do humans have?", "48"));
		quiz3.addQuestion(new ResponseQuestion("Lizards are _____ blooded.", "cold"));
		quizzes.put(quiz3.id, quiz3);
		db.insertQuiz(quiz3);
	}
	
	// Returns a quiz corresponding to the given id
	public Quiz getQuizById(int id) {
		return quizzes.get(id);
	}
	
	// Currently just returns all quizzes
	public List<Quiz> getPopularQuizzes() {
		return new ArrayList<Quiz>(quizzes.values());
	}
}
