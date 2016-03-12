package home;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChallengeServlet
 */
@WebServlet("/ChallengeServlet")
public class ChallengeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChallengeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserManager um = (UserManager) this.getServletContext().getAttribute("um");
		QuizManager qm = (QuizManager) this.getServletContext().getAttribute("qm");
		
		String senderstr = request.getParameter("sender");
		User sender = um.getUserByName(senderstr);
		String receiverstr = request.getParameter("receiver");
		User receiver = um.getUserByName(receiverstr);
		int qid = Integer.parseInt(request.getParameter("qid"));
		Quiz quiz = qm.getQuizById(qid);
		
		String score = request.getParameter("score") + "/" + quiz.getNumQuestions(); 

		Message message = new Message(sender, receiver, quiz, score);
		receiver.challenges.add(message);
		um.updateUserInDb(receiver);
		
		response.sendRedirect("QuizWelcome.jsp?id=" + quiz.id);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
