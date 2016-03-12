package home;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RemoveUserServlet
 */
@WebServlet("/RemoveUserServlet")
public class RemoveUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserManager um = (UserManager) this.getServletContext().getAttribute("um");
		QuizManager qm = (QuizManager) this.getServletContext().getAttribute("qm");
		String username = request.getParameter("id");
		
		if (!username.equals("admin")) {
			User user = um.getUserByName(username);
			if (!user.isAdmin) {
				//1
				for (QuizCreated qc: user.quizzesCreated) {
					Quiz q = qm.getQuizById(qc.quizId);
					q.creatorName = "";
					qm.updateQuizInDb(q);
				}
			
				//2
				for (QuizResult qr: user.quizzesTaken) {
					Quiz q = qm.getQuizById(qr.getQuizId());
					List<QuizResult> newResults = new ArrayList<QuizResult>();
					
					for (QuizResult qr2: q.getResults()) {
						if (!qr2.getUsername().equals(username))
							newResults.add(qr2);
					}
					
					q.results = newResults;
					q.numTaken = newResults.size();
					qm.updateQuizInDb(q);
				}
				
				//3
				for (User u: um.getUsers()) {
					if (u.name.equals(user.name)) continue;
					
					boolean updated = false;
					ArrayList<Message> newChallenges = new ArrayList<Message>();
					for (Message c: u.challenges) {
						if (c.sender.name.equals(user.name))
							updated = true;
						else
							newChallenges.add(c);
					}
			
					if (updated) {
						u.challenges = newChallenges;
						um.updateUserInDb(user);
					}
					
					updated = false;
					ArrayList<Message> newMessages = new ArrayList<Message>();
					for (Message c: u.messages) {
						if (c.sender.name.equals(user.name))
							updated = true;
						else
							newMessages.add(c);
					}
			
					if (updated) {
						u.messages = newMessages;
						um.updateUserInDb(user);
					}
					
					
					updated = false;
					ArrayList<Message> newRequests = new ArrayList<Message>();
					for (Message c: u.requests) {
						if (c.sender.name.equals(user.name))
							updated = true;
						else
							newRequests.add(c);
					}
			
					if (updated) {
						u.requests = newRequests;
						um.updateUserInDb(user);
					}
					
					updated = false;
					ArrayList<String> newPending = new ArrayList<String>();
					for (String s: u.pending) {
						if (s.equals(user.name))
							updated = true;
						else
							newPending.add(s);
					}
			
					if (updated) {
						u.pending = newPending;
						um.updateUserInDb(user);
					}
					
					updated = false;
					ArrayList<User> newFriends = new ArrayList<User>();
					for (User f: u.friends) {
						if (f.name.equals(user.name))
							updated = true;
						else
							newFriends.add(f);
					}
			
					if (updated) {
						u.friends = newFriends;
						um.updateUserInDb(user);
					}
				}
				
				um.removeUserFromDb(user);
			}
		}
		
		response.sendRedirect("AdminPage.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
