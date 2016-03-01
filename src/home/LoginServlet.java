package home;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		if(!accMan.accountExists(name) || !accMan.passwordMatchesAccount(name, password) ) {
			PrintWriter out = response.getWriter();
			out.println("<h1>Please Try Again</h1>");
			out.println("<p>Either your user name or password is incorrect. Please try again.</p>");
			out.println("<form action=\"LoginServlet\" method=\"post\">");
			out.println("User Name: <input type=\"text\" name=\"Name\"><br>");
			out.println("Password: <input type=\"text\" name=\"Password\"><br>");
			out.println("<input type=\"submit\" value=\"Login\">");
			out.println("</form>");
			out.println("<a href=\"CreateNewPage.html\">Create New Account</a>");
		} else if(accMan.accountExists(name) && accMan.passwordMatchesAccount(name, password)) {
			if(request.getServletContext().getAttribute("Rankings") == null) {
				// TODO: temporary setting it always to null until mason implements quizzes
				//ArrayList<ArrayList<String>> rankings = new ArrayList<ArrayList<String>>();
				//request.getServletContext().setAttribute("Rankings", rankings);
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
			dispatcher.forward(request, response);
		}
	//	doGet(request, response);
	}

}
