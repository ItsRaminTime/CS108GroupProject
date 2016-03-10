<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ page import="home.*" %>

<% Quiz quiz = (Quiz) request.getServletContext().getAttribute("quiz"); %>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><%= quiz.name %></title>
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

	<h1><%= quiz.name %></h1>
	<hr/>
	
	<form action="QuizServlet?id=<%= quiz.id %>" method="post">
		<% 
			int i = 0;
			for (Question q: quiz.getQuestions()) {
				int j = i+1;
				out.println("<h3>Question " + j + ")</h3>");
				out.println("<p>" + q.getDisplayStr() + "</p>");
				out.println("<input type=\"text\" name=\"answer" + i + "\"/ required>");
				out.println("<p></p>");
				i++;
				
				if (i != quiz.getNumQuestions())
					out.println("<hr/>");
			}
		%>
	
		<input type="submit" value="Submit Answers">
	</form>
</body>

</html>