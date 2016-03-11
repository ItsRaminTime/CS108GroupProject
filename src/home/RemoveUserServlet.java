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
