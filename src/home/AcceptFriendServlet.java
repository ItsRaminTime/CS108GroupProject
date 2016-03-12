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
 * Servlet implementation class AcceptFriendServlet
 */
@WebServlet("/AcceptFriendServlet")
public class AcceptFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AcceptFriendServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserManager um = (UserManager) this.getServletContext().getAttribute("um");
		HttpSession session = request.getSession();
		String receiverstr = request.getParameter("r");
		User receiver = um.getUserByName(receiverstr);
		String senderstr = request.getParameter("s");
		User sender = um.getUserByName(senderstr);
		
		
		sender.pending.remove(receiver.name);
		receiver.pending.remove(sender.name);
		
		boolean update = false;
		if (receiver.requests.size() > 0) {
			ArrayList<Message> rm = new ArrayList<Message>();
			
			for (Message m: receiver.requests) {
				if (m.sender.name.equals(sender.name))
					update = true;
				else
					rm.add(m);
			}
			
			if (update) receiver.requests = rm;
		}
	
		
		if (sender.requests.size() > 0) {
			ArrayList<Message> sm = new ArrayList<Message>();
			update = false;
			
			for (Message m: sender.requests) {
				
				if (m.sender.name.equals(receiver.name))
					update = true;	
				else
					sm.add(m);
			}
			
			if (update) sender.requests = sm;
		}
		
		sender.friends.add(receiver);
		receiver.friends.add(sender);
		
		um.updateUserInDb(sender);
		um.updateUserInDb(receiver);
		
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
