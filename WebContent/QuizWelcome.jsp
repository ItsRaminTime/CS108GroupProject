<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ page import ="home.*" %>
<%@ page import ="java.util.*" %>
 
<% 
	UserManager um = (UserManager) request.getServletContext().getAttribute("um");
	QuizManager qm = (QuizManager) request.getServletContext().getAttribute("qm");
	Quiz quiz = qm.getQuizById(Integer.parseInt(request.getParameter("id")));
%>
 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Quiz Welcome Page</title>
</head>

<body>
	<%@include file="NavBar.jsp" %>
	
	<%
		// curUser declared in NavBar.js
		if (curUser == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} 
		
		if (quiz.creatorName.equals("")) {
			out.println("<h1>Welcome to " + quiz.name + " by (user_account_removed)</h1>");
		} else {
			out.println("<h1>Welcome to " + quiz.name + " by <a class=\"navbar-link\" href=\"UserPage.jsp?username=" + quiz.creatorName + "\">" + quiz.creatorName + "</a></h1>");
		}
	%><hr/>
	
	<section>
	<h3>Created on: <%= quiz.getDate() %></h3>
	<hr/>	
	<p>This quiz has <%= quiz.getNumQuestions() %> question(s)</p>
	<hr/>
	<a href="QuizServlet?id=<%= request.getParameter("id") %>&practice=false">Take Quiz</a>
	<hr/>
	<a href="QuizServlet?id=<%= request.getParameter("id") %>&practice=true">Take Quiz in Practice Mode (Results Not Saved)</a>
	</section>
	
	<section id="top-results" class="scroll-box-wrapper">
		<h3>Top Scores</h3><hr/>
		
		<%
			int userScore = 0; 
			
			if (quiz.getTopResults() == null) {
				out.println("<p>No Top Results</p>");
			} else {
				List<QuizResult> topResults = quiz.getTopResults();
				
				out.println("<ul class=\"scroll-box\">");
				
				for (QuizResult qr: topResults) {
					if (qr.getUsername().equals(curUser.name) && qr.getScore() > userScore) 
						userScore = qr.getScore();
					
					String line = "<li><a href=\"QuizResultServlet?id=" + qr.getQuizId() + "&date=" + qr.getDate() + "\">Results for: " + qr.getCreatorName();
					line += "</a> | Date Taken: " + qr.getDate() + " | Score: " + qr.getScore() + "/" + qr.getTotal() + "</li>";
					out.println(line);				
					
				}
				out.println("</ul>");
			}
		%>
	</section>

	<section id="recent-results" class="scroll-box-wrapper">
		<h3>Recent Activity</h3><hr/>
		
		<%
			if (quiz.getTopResults() == null) {
				out.println("<p>No Recent Activity</p>");
			} else {
				List<QuizResult> recentResults = quiz.getRecentResults();
				
				out.println("<ul class=\"scroll-box\">");
				
				for (QuizResult qr: recentResults) {	
					String line = "<li><a href=\"QuizResultServlet?id=" + qr.getQuizId() + "&date=" + qr.getDate() + "\">Results for: " + qr.getCreatorName();
					line += "</a> | Date Taken: " + qr.getDate() + " | Score: " + qr.getScore() + "/" + qr.getTotal() + "</li>";
					out.println(line);				
					
				}
				out.println("</ul>");
			}
		%>
	</section>	
	
		<section id="users" class="scroll-box-wrapper">
		<h3>Challenge All Users</h3><hr/>
		
		<%
			List<User> users = um.getUsers();
		
			if (users == null || users.size() <= 1) {
				out.println("<p>No Other Users</p>");
			} else {
				out.println("<ul class=\"scroll-box\">");
				
				for (User u: users) {	
					if (!u.name.equals(curUser.name)) {
						String line = "<li><a href=\"ChallengeServlet?receiver=" + u.name + "&sender=" + curUser.name + "&qid=" + quiz.id + "&score=" + userScore + "\">Challenge " + u.name + "</a></li>";
						out.println(line);				
					}
				}
				out.println("</ul>");
			}
		%>
	</section>
</body>

</html>