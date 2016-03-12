package home;

import java.util.Date;

public class Message implements java.io.Serializable {
		
	public User sender;
	public User receiver;
	public String type;
	public String message;
	public String url;
	public int qid;
	public Date date;
	
	// Notes
	public Message(User sender, User receiver, String message) {
		this.sender = sender;
		this.receiver = receiver;
		this.type = "note";
		this.message = message;
		this.url = "";
		this.qid = 0;
		this.date = new Date();
	}
	
	// Challenges
	public Message(User sender, User receiver, Quiz q, String score) {
		this.sender = sender;
		this.receiver = receiver;
		this.type = "challenge";
		this.message = sender.name + " has challenged you to take " + q.name + "! Their score is: " + score + ".";
		this.url = "QuizWelcome.jsp?id=" + q.id;
		this.qid = q.id;
		this.date = new Date();
	}
	
	// Friend requests
	public Message(User sender, User receiver) {
		this.sender = sender;
		this.receiver = receiver;
		this.type = "friend";
		this.message = sender.name + " wants to be your friend.";
		this.url = "AcceptFriendServlet?s=" + sender.name + "&r=" + receiver.name;
		this.qid = 0;
		this.date = new Date();
	}	
}
