package home;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Date;

public class Announcement implements java.io.Serializable {
	public int id;
	public String message;
	public Date date;
	
	public Announcement(String message) {
		this.id = id;
		this.message = message;
		date = new Date();
	}
	
	public static Announcement blobToAnnouncement(Blob blob) 
			throws ClassNotFoundException, IOException, SQLException {
		byte[] uBytes = blob.getBytes(1, (int) blob.length());
		return (Announcement) Serializer.deserialize(uBytes);
	}
}