package home;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CreateUserServlet
 */
@WebServlet("/CreateUserServlet")
public class CreateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().setAttribute("message", "Create New User");
		RequestDispatcher dispatcher = request.getRequestDispatcher("CreateUser.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserManager um = (UserManager) this.getServletContext().getAttribute("um");
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		if(um.canCreate(username, password)) {
			um.createUser(username, password);
			HttpSession session = request.getSession();
	        session.setAttribute("curUser", um.getUserByName(username));
			RequestDispatcher dispatcher = request.getRequestDispatcher("HomePageServlet");
			dispatcher.forward(request, response);
		} else {
			request.getSession().setAttribute("message", "Creation Failed");
			RequestDispatcher dispatcher = request.getRequestDispatcher("CreateUser.jsp");
			dispatcher.forward(request, response);
		}
	}
}
