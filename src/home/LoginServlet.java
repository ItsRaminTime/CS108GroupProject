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

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		request.getSession().setAttribute("Password", password);
		String hashedPassword = PasswordHash.hashPassword(password);
		
		if(!accMan.accountExists(name) || !accMan.passwordMatchesAccount(name, hashedPassword) ) {
			PrintWriter out = response.getWriter();
			out.println("<h1>Please Try Again</h1>");
			out.println("<p>Either your user name or password is incorrect. Please try again.</p>");
			out.println("<form action=\"LoginServlet\" method=\"post\">");
			out.println("User Name: <input type=\"text\" name=\"Name\"><br>");
			out.println("Password: <input type=\"text\" name=\"Password\"><br>");
			out.println("<input type=\"submit\" value=\"Login\">");
			out.println("</form>");
			out.println("<a href=\"CreateNew.html\">Create New Account</a>");
		} else if(accMan.accountExists(name) && accMan.passwordMatchesAccount(name, hashedPassword)) {
			QuizManager quizMan = (QuizManager) this.getServletContext().getAttribute("Quiz Manager");
			List<Quiz> rankings = quizMan.getPopularQuizzes();
			request.getServletContext().setAttribute("QuizRankings", rankings);
			//NF added User object to session
			User user = new User(name, hashedPassword);
			request.getSession().setAttribute("User", user);
			RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
			dispatcher.forward(request, response);
		}
	}

}
