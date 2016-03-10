package home;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SendMessageServlet
 */
@WebServlet("/SendMessageServlet")
public class SendMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendMessageServlet() {
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
		UserManager userMan = (UserManager) request.getServletContext().getAttribute("um");
		Database db = (Database) request.getServletContext().getAttribute("db");
		HashMap<String, User> userMap = userMan.getHash();
		String recipient = (String) request.getParameter("recipient");
		User recipUser = userMap.get(recipient);
		User acctUser = (User) request.getSession().getAttribute("curUser");
		String type = (String) request.getParameter("type");
		Message msg;
		String outString = "";
		if (type.equals("message")) {
			msg = new Message(acctUser.name, (String) request.getParameter("message"), recipient);
			outString = "UserPage.jsp?id=" + recipient;
		} else if (type.equals("friend")) {
			msg = new Message(acctUser.name, recipient);
			recipUser.receivedFriendRequests.add(acctUser);
			acctUser.sentFriendRequests.add(recipUser);
			String linkSite = (String) request.getParameter("page");
			if (linkSite.equals("list")) {
				outString = "UserList.jsp";
			} else {
				outString = "UserPage.jsp?id=" + recipient;
			}
		} else {
			String idString = (String) request.getParameter("quiz-id");
			int id = Integer.parseInt(idString);
			msg = new Message(id, acctUser.name, recipient);
			outString = "UserPage.jsp?id=" + recipient;
		}
		recipUser.messageList.add(msg);
		acctUser.messageList.add(msg);
		RequestDispatcher dispatcher = request.getRequestDispatcher(outString);
		dispatcher.forward(request, response);
		doGet(request, response);
	}

}
