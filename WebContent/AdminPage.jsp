<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Administrator Page</title>
</head>

<%@ page import ="home.*" %>
<%@ page import ="java.util.*" %>

<body>
	<%@ include file="NavBar.jsp" %>
	
	<%
		UserManager um = (UserManager) request.getServletContext().getAttribute("um");
		QuizManager qm = (QuizManager) request.getServletContext().getAttribute("qm");
		List<User> users = um.getUsers();
		List<Quiz> quizzes = qm.getPopularQuizzes();
		
		int quizzesTaken = 0;
		if (quizzes != null)
			if (quizzes.size() > 0)
				for (Quiz q: quizzes) quizzesTaken += q.numTaken;
	
		// curUser declared in NavBar.js
		if (curUser == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} 
	%>
	
	<h1>Administrator Page</h1>
	<hr/>
	
	<section id="stats">
		<h3>Statistics</h3><hr/>
		<p>Number of users: <%= um.getNumUsers() %></p>
		<p>Number of quizzes: <%= qm.getNumQuizzes() %></p>
		<p>Number of quizzes taken: <%= quizzesTaken %></p>
	</section>
	
	<section id="make-announcement">
		<h3>Make an announcement</h3><hr/>
		
		<form action="AnnouncementServlet" method="post">
			<p><textarea cols="100" rows="5" name="announcement"></textarea></p>
			<br/>
			
			<input type="submit" value="Submit">
		</form>
	</section>
	
	<section id="announcements">
		<%
			AnnouncementManager am = (AnnouncementManager) request.getServletContext().getAttribute("am");
			List<Announcement> anns = am.getAnns();
		
			if (anns == null || anns.size() == 0) {
				out.println("<h3>No Announcements</h3>");
			} else {				
				out.println("<h3>Announcements (" + anns.size() + ")</h3><hr/>");
				out.println("<p class=\"scroll-box\">");
				
				for (Announcement an: anns)
					out.println("Posted on: " + an.date + "<p>" + an.message + "</p><hr/>");
				
				out.println("All announcements are posted by admin accounts.</p>");
			}
		%>
	</section>
	
	<section id="give-admin">
	
	<h3>Click on users to give them admin rights</h3><hr/>
	
	<%
		if (users == null || users.size() == 0) {
			out.println("<p>No Users</p>");
		} else {			
			out.println("<ul class=\"scroll-box\">");
			int numPrinted = 0;
			
			for (User u: users) {
				if (!u.isAdmin && !u.name.equals("admin")) {
					out.println("<li><a href=\"ToggleAdminServlet?id=" + u.name + "\">" + u.name + "</a> | ");
					out.println("<a href=\"UserPage.jsp?username=" + u.name + "\">View Profile</a></li>");
					numPrinted++;	
				}
			}
			
			if (numPrinted == 0) out.println("<li>There is nothing to see here</li>");
			
			out.println("</ul>");
		}
	%>
	</section>
	
	<section id="revoke-admin">
	
	<h3>Click on users to revoke admin rights</h3><hr/>
	
	<%
		if (users == null || users.size() == 0) {
			out.println("<p>No Users</p>");
		} else {			
			out.println("<ul class=\"scroll-box\">");
			int numPrinted = 0;
			
			for (User u: users) {
				if (u.isAdmin && !u.name.equals("admin")) {
					out.println("<li><a href=\"ToggleAdminServlet?id=" + u.name + "\">" + u.name + "</a> | ");
					out.println("<a href=\"UserPage.jsp?username=" + u.name + "\">View Profile</a></li>");
					numPrinted++;
				}
			}
			
			if (numPrinted == 0) out.println("<li>There is nothing to see here</li>");
			
			out.println("</ul>");
		}
	%>
	</section>
	
	<section id="delete-user">
	
		<h3>Click to delete users (admins cannot be deleted)</h3><hr/>
		
		<%
			if (users == null || users.size() == 0) {
				out.println("<p>No Users</p>");
			} else {			
				out.println("<ul class=\"scroll-box\">");
				int numPrinted = 0;
				
				for (User u: users) {
					if (!u.isAdmin && !u.name.equals("admin")) {
						out.println("<li><a href=\"RemoveUserServlet?id=" + u.name + "\">" + u.name + "</a> | ");
						out.println("<a href=\"UserPage.jsp?username=" + u.name + "\">View Profile</a></li>");
						numPrinted++;
					}
				}
				
				if (numPrinted == 0) out.println("<li>There is nothing to see here</li>");
				
				out.println("</ul>");
			}
		%>
	</section>
	
	<section id="delete-quiz-results">
	
		<h3>Click to delete quiz results (leaves the quizzes there, just deletes the results)</h3><hr/>
		
		<%
			if (quizzes == null) {
				out.println("<p>No Quizzes</p>");
			} else {			
				out.println("<ul class=\"scroll-box\">");
				int numPrinted = 0;
				
				for (Quiz q: quizzes) {
					out.println("<li><a href=\"RemoveQuizServlet?id=" + q.id + "&hard=false\">ID: " + q.id + ", Name: " + q.name + "</a> | ");
					out.println("<a href=\"QuizWelcome.jsp?id=" + q.id + "\">View Quiz</a></li>");
					numPrinted++;
				}
				
				if (numPrinted == 0) out.println("<li>There is nothing to see here</li>");
				
				out.println("</ul>");
			}
		%>
	</section>
	
		<section id="delete-quiz">
	
		<h3>Click to delete quizzes (deletes all info relating to a quiz, including the quiz)</h3><hr/>
		
		<%
			if (quizzes == null) {
				out.println("<p>No Quizzes</p>");
			} else {			
				out.println("<ul class=\"scroll-box\">");
				int numPrinted = 0;
				
				for (Quiz q: quizzes) {
					out.println("<li><a href=\"RemoveQuizServlet?id=" + q.id + "&hard=true\">ID: " + q.id + ", Name: " + q.name + "</a> | ");
					out.println("<a href=\"QuizWelcome.jsp?id=" + q.id + "\">View Quiz</a></li>");
					numPrinted++;
				}
				
				if (numPrinted == 0) out.println("<li>There is nothing to see here</li>");
				
				out.println("</ul>");
			}
		%>
	</section>
	
</body>

</html>