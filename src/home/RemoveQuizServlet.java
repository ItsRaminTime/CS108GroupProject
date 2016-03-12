package home;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RemoveQuizServlet
 */
@WebServlet("/RemoveQuizServlet")
public class RemoveQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveQuizServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserManager um = (UserManager) this.getServletContext().getAttribute("um");
		QuizManager qm = (QuizManager) this.getServletContext().getAttribute("qm");
		int quizid = Integer.parseInt(request.getParameter("id"));
		boolean hard = request.getParameter("hard").equals("true");
		System.out.println(request.getParameter("hard"));
		Quiz quiz = qm.getQuizById(quizid);
		
		for (User u: um.getUsers()) {

			boolean updated = false;
			ArrayList<QuizResult> newResults = new ArrayList<QuizResult>();
			
			//1
			for (QuizResult qr: u.quizzesTaken) {
				if (qr.getQuizId() == quiz.id) {
					updated = true;
				} else {
					newResults.add(qr);
				}
			}
			
			if (updated) {
				u.quizzesTaken = newResults;
				u.numQuizzesTaken = newResults.size();
				um.updateUserInDb(u);
			}
			
			//2
			updated = false;
			ArrayList<Message> newChallenges = new ArrayList<Message>();
			for (Message m: u.challenges) {
				if (m.qid == quiz.id) {
					updated = true;
				} else {
					newChallenges.add(m);
				}
			}
			
			if (updated) {
				u.challenges = newChallenges;
				um.updateUserInDb(u);
			}
			
			//3
			if (hard && quiz.creatorName != "") {
				updated = false;
				ArrayList<QuizCreated> newCreated = new ArrayList<QuizCreated>();
				
				for (QuizCreated qc: u.quizzesCreated) {
					if (qc.quizId == quiz.id) {
						updated = true;
					} else {
						newCreated.add(qc);
					}
				}
				
				if (updated) {
					u.quizzesCreated = newCreated;
					u.numQuizzesTaken = newCreated.size();
					um.updateUserInDb(u);
				}
			}
		}
		

		HttpSession session = request.getSession();
		User curUser = (User) session.getAttribute("curUser");
		session.setAttribute("curUser", um.getUserByName(curUser.name));
		
		if (hard) {
			System.out.println("slkdnflkdnsf");
			qm.removeQuizFromDb(quiz);
		} else {
			quiz.results.clear();
			quiz.numTaken = 0;
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
