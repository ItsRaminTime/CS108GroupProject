package home;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SendRequestServlet
 */
@WebServlet("/SendRequestServlet")
public class SendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendRequestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserManager um = (UserManager) this.getServletContext().getAttribute("um");
		HttpSession session = request.getSession();
        User sender = (User) session.getAttribute("curUser");
		String receiverstr = request.getParameter("user");
		User receiver = um.getUserByName(receiverstr);
		
		if (sender.isFriendsWith(receiverstr)) {
			ArrayList<User> u1 = new ArrayList<User>();
			for (User u: receiver.friends)
				if (!u.name.equals(sender.name))
					u1.add(u);
	
			receiver.friends = u1;
		
			ArrayList<User> u2 = new ArrayList<User>();
			for (User u: sender.friends)
				if (!u.name.equals(receiver.name))
					u2.add(u);

			sender.friends = u2;
			
			um.updateUserInDb(sender);
			um.updateUserInDb(receiver);
		} else if (!sender.pending.contains(receiver.name)) {	
			sender.pending.add(receiver.name);
			Message message = new Message(sender, receiver);
			receiver.requests.add(message);
			um.updateUserInDb(sender);
			um.updateUserInDb(receiver);
		}
		
		User curUser = (User) session.getAttribute("curUser");
        session.setAttribute("curUser", um.getUserByName(curUser.name));
		
		response.sendRedirect("FriendCenter.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
