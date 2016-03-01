package home;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CreateAccountServlet
 */
@WebServlet("/CreateAccountServlet")
public class CreateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateAccountServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountManager accMan = (AccountManager) this.getServletContext().getAttribute("Account Manager");
		String name = request.getParameter("Name");
		request.getSession().setAttribute("Username", name);
		String password = request.getParameter("Password");
		if(!accMan.accountExists(name)) {
			accMan.createNewAccount(name, password);
			
			QuizManager quizMan = (QuizManager) this.getServletContext().getAttribute("Quiz Manager");
			List<Quiz> rankings = quizMan.getPopularQuizzes();
			request.getServletContext().setAttribute("QuizRankings", rankings);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
			dispatcher.forward(request, response);
		} else if(accMan.accountExists(name)) {
			PrintWriter out = response.getWriter();
			out.println("<h1>The Name " + name + " is Already In Use</h1>");
			out.println("<p>Please enter another name and password.</p>");
			out.println("<form action=\"CreateAccountServlet\" method=\"post\">");
			out.println("User Name: <input type=\"text\" name=\"Name\"><br>");
			out.println("Password: <input type=\"text\" name=\"Password\"><br>");
			out.println("<input type=\"submit\" value=\"Register\">");
			out.println("</form>");
		}
	}

}
