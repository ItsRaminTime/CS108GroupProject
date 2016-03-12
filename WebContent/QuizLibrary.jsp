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

<% 
	QuizManager qm = (QuizManager) request.getServletContext().getAttribute("qm");
	List<Quiz> popularQuizzes = qm.getPopularQuizzes();
	List<Quiz> recentlyCreatedQuizzes = qm.getRecentlyCreatedQuizzes();
	int size = qm.getNumQuizzes();
%>

<body background="https://images5.alphacoders.com/381/381373.jpg">
	<%@ include file="NavBar.jsp" %>

	<%
		// curUser declared in NavBar.js
		if (curUser == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} else {
			out.println("<h1>Quiz Library (" + size + " Total)</h1>");
		}
	%>
	<hr/>
	
	<section id="popular-quizzes">
		<h3>All Quizzes Sorted By Popularity</h3><hr/>
		
		<%
			if (popularQuizzes == null) {
				out.println("<p>No Popular Quizzes</p>");
			} else {				
				out.println("<ul class=\"scroll-box\">");
		 		
				for (Quiz q: popularQuizzes)	
					out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.id + "\">" + q.name + "</a> | Times Taken: " + q.numTaken + "</li>");
				
				out.println("</ul>");
			}
		%>
	</section>

	<section id="recently-created-quizzes">
		<h3>All Quizzes Sorted By Creation Date</h3><hr/>
		
		<%
			if (recentlyCreatedQuizzes == null) {
				out.println("<p>No Recently Created Quizzes</p>");
			} else {
				out.println("<ul class=\"scroll-box\">");
				
				for (Quiz q: recentlyCreatedQuizzes)	
					out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.id + "\">" + q.name + "</a> | Date Created: " + q.getDate() + "</li>");
				
				out.println("</ul>");
			}
		%>
	</section>
</body>

</html>