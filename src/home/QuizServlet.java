package home;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class QuizServlet
 */
@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuizServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		QuizManager qm = (QuizManager) this.getServletContext().getAttribute("qm");
		Quiz quiz = qm.getQuizById(Integer.parseInt(request.getParameter("id")));		
		
		if (quiz == null) {
			request.getServletContext().setAttribute("QuizRankings", qm.getPopularQuizzes());
			RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
			dispatcher.forward(request, response);
		} else {
			request.getServletContext().setAttribute("quiz", quiz);
			RequestDispatcher dispatcher = request.getRequestDispatcher("Quiz.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		QuizManager qm = (QuizManager) this.getServletContext().getAttribute("qm");
		UserManager um = (UserManager) this.getServletContext().getAttribute("um");
		Quiz quiz = qm.getQuizById(Integer.parseInt(request.getParameter("id")));
		HttpSession session = request.getSession();
        User curUser = (User) session.getAttribute("curUser");
		
		if (quiz == null) {
			request.getServletContext().setAttribute("QuizRankings", qm.getPopularQuizzes());
			RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
			dispatcher.forward(request, response);
		} else {
			List<Question> allQuestions = quiz.getQuestions();
			int i = 0;
			
			for (Question q: allQuestions) {
				q.setResponse(request.getParameter("answer" + i));
				i++;
			}
			
			QuizResult qr = new QuizResult(quiz, curUser.name, allQuestions);
			request.getServletContext().setAttribute("quizResult", qr);
			
			curUser.quizzesTaken.add(qr);
			curUser.numQuizzesTaken++;
			quiz.addResult(qr);
			qm.updateQuizInDb(quiz);
			um.updateUserInDb(curUser);

			RequestDispatcher dispatcher = request.getRequestDispatcher("QuizResults.jsp");
			dispatcher.forward(request, response);
		}
	}

}
