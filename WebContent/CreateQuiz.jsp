<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ page import="home.*" %>
<%@ page import="java.util.*" %>

<%
	Quiz quiz = (Quiz) request.getSession().getAttribute("quiz");
	request.getSession().setAttribute("quiz", quiz);
	
	int numQuestions = (Integer) request.getSession().getAttribute("numQuestions");
	request.getSession().setAttribute("numQuestions", numQuestions);

	@SuppressWarnings("unchecked")
	List<String> types = (ArrayList<String>) request.getSession().getAttribute("types");
	request.getSession().setAttribute("types", types);
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Create New Quiz</title>
</head>

<body>
	<%@ include file="NavBar.jsp" %>

	<h1>Create Your Quiz</h1>
	<h3>Now it's time to fill in the questions.</h3>
	<hr/>
	
	<form action="CreateQuizServlet" method="post">
		<% 
			for (int i = 0; i < numQuestions; i++) {
				out.println("<h3>Question #" + (i+1) + "</h3>");
				
				out.println("<p>");
				if (types.get(i).equals("response")) {
					out.println("Question: <input type=\"text\" name=\"question" + i + "\" required><br/>");
					out.println("Answer: <input type=\"text\" name=\"answer" + i + "\" required>");
				}
				out.println("</p>");
			}
		%>
		
		<input type="submit" value="Submit">
	</form>
</body>

</html>