<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ page import ="home.*" %>
<%@ page import ="java.util.*" %>

<%
	UserManager um = (UserManager) request.getServletContext().getAttribute("um");
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Profile Page</title>
</head>

<body>
	<%@include file="NavBar.jsp" %>
	
	<%
		int numTaken = 0;
		int numCreated = 0;
		List<QuizResult> yourRecentlyTakenQuizzes = null;
		List<QuizCreated> yourRecentlyCreatedQuizzes = null;
	
		// curUser declared in NavBar.js
		if (curUser == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} else {
			out.println("<h1>" + curUser.name + "'s Profile</h1>");
			numTaken = curUser.numQuizzesTaken;
			numCreated = curUser.numQuizzesCreated;
			yourRecentlyTakenQuizzes = um.getRecentlyTakenQuizzes(curUser);
			yourRecentlyCreatedQuizzes = um.getRecentlyCreatedQuizzes(curUser);
		}
	%>

	<hr/>
	
	<section id="your-recently-created-quizzes" class="scroll-box-wrapper">
		<h3>Your Recently Created Quizzes</h3>
		<p>Quizzes created: <%= numCreated %></p>
		
		<%
			if (um == null || yourRecentlyCreatedQuizzes == null) {
				out.println("<p>No Recently Created Quizzes By You</p>");
			} else {				
				out.println("<ul class=\"scroll-box\">");
				
				for (QuizCreated qc: yourRecentlyCreatedQuizzes)	
					out.println("<li><a href=\"QuizWelcome.jsp?id=" + qc.quizId + "\">" + qc.quizName + "</a> | Date Created: " + qc.date + "</li>");
				
				out.println("</ul>");
			}
		%>
		
		<hr/>
	</section>
	
	<section id="your-recently-taken-quizzes" class="scroll-box-wrapper">
		<h3>Your Recently Taken Quizzes</h3>
		<p>Quizzes taken: <%= numTaken %></p>
		
		<%
			if (um == null || yourRecentlyTakenQuizzes == null) {
				out.println("<p>No Recently Taken Quizzes By You</p>");
			} else {
				out.println("<ul class=\"scroll-box\">");
				
				for (QuizResult qr: yourRecentlyTakenQuizzes) {
					String line = "<li><a href=\"QuizResultServlet?id=" + qr.getQuizId() + "&date=" + qr.getDate() + "\">Results for: " + qr.getQuizName();
					line += "</a> | Date Taken: " + qr.getDate() + " | Score: " + qr.getScore() + "/" + qr.getTotal() + "</li>";
					out.println(line);
				}
				
				out.println("</ul>");
			}
		%>
	</section>
</body>

</html>