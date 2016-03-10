package home;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialException;

import java.util.*;

/**
 * Servlet implementation class AddFriend
 */
@WebServlet("/AddFriend")
public class AddFriend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddFriend() {
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
		UserManager userMan = (UserManager) request.getServletContext().getAttribute("um");
		Database db = (Database) request.getServletContext().getAttribute("db");
		HashMap<String, User> userMap = userMan.getHash();
		String name = (String) request.getParameter("user");
		User usr = userMap.get(name);
		User acctUser = (User) request.getSession().getAttribute("curUser");
		acctUser.friends.add(usr);
		usr.friends.add(acctUser);
		try {
			db.updateUser(acctUser);
			db.updateUser(usr);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String linkSite = (String) request.getParameter("page");
		String outString = "";
		if (linkSite.equals("list")) {
			outString = "UserList.jsp";
		} else {
			outString = "UserPage.jsp?id=" + usr.name;
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(outString);
		dispatcher.forward(request, response);
		doGet(request, response);
	}

}
