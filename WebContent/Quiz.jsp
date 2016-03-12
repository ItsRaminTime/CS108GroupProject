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

<body background="https://images5.alphacoders.com/381/381373.jpg">
	<%@include file="NavBar.jsp" %>
	
	<%
		request.getServletContext().setAttribute("practice", request.getServletContext().getAttribute("practice"));
		// curUser declared in NavBar.js
		if (curUser == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} 
	%>

	<h1><%= quiz.name %></h1>
	<hr/>
	
	<section>
	<form action="QuizServlet?id=<%= quiz.id %>" method="post">
		<% 
			int i = 0;
			for (Question q: quiz.getQuestions()) {
				int j = i+1;
				out.println("<h3>Question " + j + ")</h3>");
				out.println("<p>" + q.getDisplayStr() + "</p>");
				
				if (q.getType().equals("response") || q.getType().equals("fillblank") || q.getType().equals("pic")){
					out.println("<input type=\"text\" name=\"answer" + i + "\"/ required>");	
				} else if (q.getType().equals("truefalse")) {
					out.println("True: <input type=\"radio\" name=\"answer" + i + "\" value=\"true\" required>");
					out.println("False: <input type=\"radio\" name=\"answer" + i + "\" value=\"false\" required>");
				} else if (q.getType().equals("multchoice")) {
					out.println("Multiple Choice: <select name=\"answer" + i + "\" required>");
					for (String s: q.getOptions())
						out.println("<option value=\"" + s + "\">" + s +"</option>");
					out.println("</select>");
				}
				
				out.println("<p></p>");
				out.println("<hr/>");
				i++;
			}
		%>
	
		<input type="submit" value="Submit Answers">
	</form>
	</section>
</body>

</html>