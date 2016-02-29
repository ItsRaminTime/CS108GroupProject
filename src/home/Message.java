package home;

public class Message {
	
	String sender;
	String time;
	String message;
	boolean read;
	
	public Message(String sender, String time, String message) {
		this.sender = sender;
		this.time = time;
		this.message = message;
		read = false;
	}
	
	public void setRead() {
		read = true;
	}
	
	public void setUnread() {
		read = false;
	}
}
