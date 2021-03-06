package home;

import java.io.IOException;                                                        
import java.sql.*;                                                                                                                                
import javax.sql.rowset.serial.SerialBlob;                                         
import javax.sql.rowset.serial.SerialException;

public class Database {

	public final static String account = MyDBInfo.MYSQL_USERNAME;
	public final static String password = MyDBInfo.MYSQL_PASSWORD;
	public final static String server = MyDBInfo.MYSQL_DATABASE_SERVER;
	public final static String database = MyDBInfo.MYSQL_DATABASE_NAME;

	Connection con;
	Statement stmt;
	
	public Database() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://" + server, account, password);
			stmt = con.createStatement();
			stmt.executeQuery("USE " + database);
		} catch (SQLException e) {
			e.printStackTrace();
			System.exit(0);
		} catch (ClassNotFoundException e) {
			System.out.println("Class Not Found Exception!");
			e.printStackTrace();
			System.exit(0);
		} 
	}
	
	public ResultSet runQuery(String query) {
		try {
			return stmt.executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	// Inserts a single quiz
	public void insertQuiz(Quiz quiz) 
			throws SerialException, SQLException, IOException {
		byte[] bytes = Serializer.serialize(quiz);
		Blob blob = new SerialBlob(bytes);		
		String sql = "INSERT INTO quizzes (id, data) VALUES (?, ?)";
	    PreparedStatement stmt = con.prepareStatement(sql);
	    stmt.setLong(1, quiz.id);
	    stmt.setBinaryStream(2, blob.getBinaryStream(), (int) blob.length());
	    stmt.execute();
	}
	
	// Inserts a single user
	public void insertUser(User user) 
			throws SerialException, SQLException, IOException {
		byte[] bytes = Serializer.serialize(user);
		Blob blob = new SerialBlob(bytes);		
		String sql = "INSERT INTO users (name, data) VALUES (?, ?)";
	    PreparedStatement stmt = con.prepareStatement(sql);
	    stmt.setString(1, user.name);
	    stmt.setBinaryStream(2, blob.getBinaryStream(), (int) blob.length());
	    stmt.execute();
	}
	
	// Updates a single quiz
	public void updateQuiz(Quiz quiz) 
			throws SerialException, SQLException, IOException {
		byte[] bytes = Serializer.serialize(quiz);
		Blob blob = new SerialBlob(bytes);		
		String sql = "UPDATE quizzes SET data = (?) WHERE id = (?)";
	    PreparedStatement stmt = con.prepareStatement(sql);
	    stmt.setBinaryStream(1, blob.getBinaryStream(), (int) blob.length());
	    stmt.setLong(2, quiz.id);
	    stmt.execute();
	}
	
	// Updates a single user
	public void updateUser(User user) 
			throws SerialException, SQLException, IOException {
		byte[] bytes = Serializer.serialize(user);
		Blob blob = new SerialBlob(bytes);		
		String sql = "UPDATE users SET data = (?) WHERE name = (?)";
	    PreparedStatement stmt = con.prepareStatement(sql);
	    stmt.setBinaryStream(1, blob.getBinaryStream(), (int) blob.length());
	    stmt.setString(2, user.name);
	    stmt.execute();
	}
	

	public void removeUser(User user) 
			throws SerialException, SQLException, IOException {
		if (user.isAdmin || user.name.equals("admin")) return;
		
		byte[] bytes = Serializer.serialize(user);
		Blob blob = new SerialBlob(bytes);		
		String sql = "delete from users where name = (?) limit 1";
	    PreparedStatement stmt = con.prepareStatement(sql);
	    stmt.setString(1, user.name);
	    stmt.execute();
	}
	

	public void removeQuiz(Quiz quiz) 
			throws SerialException, SQLException, IOException {		
		byte[] bytes = Serializer.serialize(quiz);
		Blob blob = new SerialBlob(bytes);		
		String sql = "delete from quizzes where id = (?) limit 1";
	    PreparedStatement stmt = con.prepareStatement(sql);
	    stmt.setLong(1, quiz.id);
	    stmt.execute();
	}
	
	// Inserts a single user
	public void insertAnnouncement(Announcement announcement) 
			throws SerialException, SQLException, IOException {
		byte[] bytes = Serializer.serialize(announcement);
		Blob blob = new SerialBlob(bytes);		
		String sql = "INSERT INTO anns (id, data) VALUES (?, ?)";
	    PreparedStatement stmt = con.prepareStatement(sql);
	    stmt.setLong(1, announcement.id);
	    stmt.setBinaryStream(2, blob.getBinaryStream(), (int) blob.length());
	    stmt.execute();
	}
	
	// Call when context is destroyed
	public void close() {
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
