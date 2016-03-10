package home;

import java.util.*;

public class Message {
	
	String sender;
	String time;
	String message;
	boolean read;
	String type;
	Date date;
	int quizID;
	public String recipient;
	
	public static final String CHALLENGE = "challenge";
	public static final String FRIEND = "friend";
	public static final String MESSAGE = "message";
	
	
	/*public Message(String sender, String time, String message) {
		this.sender = sender;
		this.time = time;
		this.message = message;
		read = false;
	}*/
	
	public Message(int quizID, String sender, String recipient) {
		this.sender = sender;
		this.quizID = quizID;
		this.date = new Date();
		this.type = CHALLENGE;
		this.recipient = recipient;
	}
	
	public Message(String sender, String recipient) {
		this.sender = sender;
		this.date = new Date();
		this.type = FRIEND;
		this.recipient = recipient;
	}
	
	public Message(String sender, String message, String recipient) {
		this.sender = sender;
		this.message = message;
		this.date = new Date();
		this.type = MESSAGE;
		this.recipient = recipient;
	}
	
	public void setRead() {
		read = true;
	}
	
	public void setUnread() {
		read = false;
	}
}
