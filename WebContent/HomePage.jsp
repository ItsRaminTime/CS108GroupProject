<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ page import="home.*" %>
<%@ page import="java.util.*" %>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Home Page</title>
</head>

<body>
	<%@ include file="NavBar.jsp" %>

	<%
		// curUser declared in NavBar.js
		if (curUser == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} else {
			out.println("<h1>Welcome " + curUser.name + "</h1>");
		}
	%>
	<hr/>
	
	
	<section id="announcements" class="scroll-box-wrapper">
		<h3>Announcements</h3>
		
		<%
			if (request.getServletContext().getAttribute("announcements") == null) {
				out.println("<p>No Announcements</p>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<String> announcements = (ArrayList<String>) request.getServletContext().getAttribute("announcements");
				
				out.println("<p>" + announcements.size() + " Announcement(s):</p>");
				out.println("<ul class=\"scroll-box\">");
				
				for (String s: announcements)	
					out.println("<li>" + s + "</li>");
				
				out.println("</ul>");
			}
		%>
		
		<hr/>
	</section>

	<section id="popular-quizzes" class="scroll-box-wrapper">
		<h3>Popular Quizzes</h3>
		
		<%
			if (request.getServletContext().getAttribute("popularQuizzes") == null) {
				out.println("<p>No Popular Quizzes</p>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<Quiz> popularQuizzes = (ArrayList<Quiz>) request.getServletContext().getAttribute("popularQuizzes");
				
				out.println("<ul class=\"scroll-box\">");
				
				for (Quiz q: popularQuizzes)	
					out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.id + "\">" + q.name + "</a> | Times Taken: " + q.numTaken + "</li>");
				
				out.println("</ul>");
			}
		%>
		
		<hr/>
	</section>

	<section id="recently-created-quizzes" class="scroll-box-wrapper">
		<h3>Recently Created Quizzes</h3>
		
		<%
			if (request.getServletContext().getAttribute("recentlyCreatedQuizzes") == null) {
				out.println("<p>No Recently Created Quizzes</p>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<Quiz> recentlyCreatedQuizzes = (ArrayList<Quiz>) request.getServletContext().getAttribute("recentlyCreatedQuizzes");
				
				out.println("<ul class=\"scroll-box\">");
				
				for (Quiz q: recentlyCreatedQuizzes)	
					out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.id + "\">" + q.name + "</a> | Date Created: " + q.getDate() + "</li>");
				
				out.println("</ul>");
			}
		%>
		
		<hr/>
	</section>
	
	<section id="your-recently-created-quizzes" class="scroll-box-wrapper">
		<h3>Your Recently Created Quizzes</h3>
		
		<%
			if (request.getServletContext().getAttribute("yourRecentlyCreatedQuizzes") == null) {
				out.println("<p>No Recently Created Quizzes By You</p>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<QuizCreated> yourRecentlyCreatedQuizzes = (ArrayList<QuizCreated>) request.getServletContext().getAttribute("yourRecentlyCreatedQuizzes");
				
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
		
		<%
			if (request.getServletContext().getAttribute("yourRecentlyTakenQuizzes") == null) {
				out.println("<p>No Recently Taken Quizzes By You</p>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<QuizResult> yourRecentlyTakenQuizzes = (ArrayList<QuizResult>) request.getServletContext().getAttribute("yourRecentlyTakenQuizzes");
				
				out.println("<ul class=\"scroll-box\">");
				
				for (QuizResult qr: yourRecentlyTakenQuizzes) {
					String line = "<li><a href=\"QuizResultServlet?id=" + qr.getQuizId() + "&date=" + qr.getDate() + "\">Results for " + qr.getQuizName();
					line += "</a> | Date Taken: " + qr.getDate() + " | Score: " + qr.getScore() + "/" + qr.getTotal() + "</li>";
					out.println(line);
				}
				
				out.println("</ul>");
			}
		%>
		
		<hr/>
	</section>
	
	<section id="achievements" class="scroll-box-wrapper">
		<h3>Achievements</h3>
		
		<%
			if (request.getServletContext().getAttribute("achievements") == null) {
				out.println("<p>No Achievements</p>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<String> achievements = (ArrayList<String>) request.getServletContext().getAttribute("achievements");
				
				out.println("<p>" + achievements.size() + " Achievement(s):</p>");
				out.println("<ul class=\"scroll-box\">");
				
				for (String s: achievements)	
					out.println("<li>" + s + "</li>");
				
				out.println("</ul>");
			}
		%>
		
		<hr/>
	</section>
	
	<section id="messages" class="scroll-box-wrapper">
		<h3>Messages</h3>
		
		<%
			if (request.getServletContext().getAttribute("messages") == null) {
				out.println("<p>No Messages</p>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<String> messages = (ArrayList<String>) request.getServletContext().getAttribute("messages");
				
				out.println("<p>" + messages.size() + " Messages:</p>");
				out.println("<ul class=\"scroll-box\">");
				
				for (String s: messages)	
					out.println("<li>" + s + "</li>");
				
				out.println("</ul>");
			}
		%>
		
		<hr/>
	</section>
	
	<section id="friend-activity" class="scroll-box-wrapper">
		<h3>Friend Activity</h3>
		
		<%
			if (request.getServletContext().getAttribute("friendActivity") == null) {
				out.println("<p>No Friend Activity</p>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<String> friendActivity = (ArrayList<String>) request.getServletContext().getAttribute("friendActivity");
				
				out.println("<p>" + friendActivity.size() + " Friend Activity Item(s):</p>");
				out.println("<ul class=\"scroll-box\">");
				
				for (String s: friendActivity)	
					out.println("<li>" + s + "</li>");
				
				out.println("</ul>");
			}
		%>
	</section>
</body>

</html>