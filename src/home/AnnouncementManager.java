package home;

import java.io.IOException;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

public class AnnouncementManager {
	private Database db;
	public List<Announcement> anns = null;
	private int largestId = 0;

	public AnnouncementManager(Database db) {
		this.db = db;
		anns = new LinkedList<Announcement>();
		ResultSet rs = db.runQuery("SELECT * FROM anns");
		
		try {
			while(rs.next()) {
				Blob anBlob = rs.getBlob("data");
				Announcement an = Announcement.blobToAnnouncement(anBlob);
				anns.add(an);
				
				if (an.id > largestId) 
					largestId = an.id;
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
	public void addAnnouncementToDb(Announcement an) {
		an.id = largestId + 1;
		largestId = an.id;
		anns.add(an);
		
		try {
			db.insertAnnouncement(an);
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<Announcement> getAnns() {
		if (anns.size() == 0)
			return null;
		
		List<Announcement> result = new ArrayList<Announcement>(anns);
		
		Collections.sort(result, new Comparator<Announcement>() {
	        @Override
	        public int compare(Announcement a1, Announcement a2) {;
	        	return a2.date.compareTo(a1.date);
	        }
	    });
		
		return result;
	}
}
