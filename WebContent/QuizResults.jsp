<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ page import="home.*" %>

<% QuizResult qr = (QuizResult) request.getServletContext().getAttribute("quizResult"); %>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Quiz Results</title>
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
	%>
	
	<h1><%= qr.getUsername() %>'s Score: <%= qr.getScore() %> / <%= qr.getTotal() %></h1>
	<h3>Taken on: <%= qr.getDate() %></h3>
	<hr/>
	
	<% 
		int i = 1;
		for (Question q: qr.getQuestions()) {
			out.println("<h3>Question " + i + ")</h3>");
			out.println("<p>Question: " + q.getDisplayStr() + "</p>");
			out.println("<p>Correct Answer: " + q.getCorrectAnswer() + "</p>");
			out.println("<p>Your Answer: " + q.getGivenAnswer() + "</p>");
			i++;
			
			if (q.isCorrect())
				out.println("<p>CORRECT</p>");
			else
				out.println("<p>WRONG</p>");
			
			out.println("<hr/>");
		}
	%>
	
	<a href="QuizServlet?id=<%= qr.getQuizId() %>">Take Quiz Again</a> | <a href="QuizWelcome.jsp?id=<%= qr.getQuizId() %>">Back to Quiz's Summary Page</a> 
</body>

</html>