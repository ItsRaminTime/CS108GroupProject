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
 * Servlet implementation class HomePageServlet
 */
@WebServlet("/HomePageServlet")
public class HomePageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomePageServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserManager um = (UserManager) this.getServletContext().getAttribute("um");
		QuizManager qm = (QuizManager) this.getServletContext().getAttribute("qm");
		HttpSession session = request.getSession();
        User curUser = (User) session.getAttribute("curUser");
		
		request.getServletContext().setAttribute("popularQuizzes", qm.getPopularQuizzes());
		request.getServletContext().setAttribute("recentlyCreatedQuizzes", qm.getRecentlyCreatedQuizzes());
		request.getServletContext().setAttribute("yourRecentlyCreatedQuizzes", um.getRecentlyCreatedQuizzes(curUser));
		request.getServletContext().setAttribute("yourRecentlyTakenQuizzes", um.getRecentlyTakenQuizzes(curUser));
		RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
