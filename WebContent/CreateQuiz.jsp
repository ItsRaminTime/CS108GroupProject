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
	
	<%
		// curUser declared in NavBar.js
		if (curUser == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} 
	%>

	<h1>Create Your Quiz</h1>
	<hr/>
	<section>
	<h3>Now it's time to fill in the questions.</h3>
	<hr/>
	
	<form action="CreateQuizServlet" method="post">
		<% 
			for (int i = 0; i < numQuestions; i++) {
				out.println("<h3>Question #" + (i+1) + "</h3>");
				
				out.println("<p>");
				if (types.get(i).equals("response")) {
					out.println("Question: <input type=\"text\" name=\"question" + i + "\" required><br/><br/>");
					out.println("Answer: <input type=\"text\" name=\"answer" + i + "\" required>");
				} else if (types.get(i).equals("fillblank")) {
					out.println("Type a '%' wherever you want a blank. For example, '% is cool' becomes '_______ is cool.'<br/><br/>");
					out.println("Question: <input type=\"text\" name=\"question" + i + "\" required><br/><br/>");
					out.println("Answer: <input type=\"text\" name=\"answer" + i + "\" required>");
				} else if (types.get(i).equals("truefalse")) {
					out.println("Question: <input type=\"text\" name=\"question" + i + "\" required><br/><br/>");
					out.println("True: <input type=\"radio\" name=\"answer" + i + "\" value=\"true\" required>");
					out.println("False: <input type=\"radio\" name=\"answer" + i + "\" value=\"false\" required>");
				} else if (types.get(i).equals("multchoice")) {
					out.println("Answer must match one of the options, otherwise a random option is chosen as the correct one.<br/><br/>");
					out.println("Question: <input type=\"text\" name=\"question" + i + "\" required><br/><br/>");
					out.println("Option A: <input type=\"text\" name=\"optiona" + i + "\" required><br/>");
					out.println("Option B: <input type=\"text\" name=\"optionb" + i + "\" required><br/>");
					out.println("Option C: <input type=\"text\" name=\"optionc" + i + "\" required><br/>");
					out.println("Option D: <input type=\"text\" name=\"optiond" + i + "\" required><br/><br/>");
					out.println("Answer: <input type=\"text\" name=\"answer" + i + "\" required>");
				} else if (types.get(i).equals("pic")) {
					out.println("Enter a url: <input type=\"text\" name=\"question" + i + "\" required><br/><br/>");
					out.println("Answer: <input type=\"text\" name=\"answer" + i + "\" required>");
				}
				out.println("</p><hr/>");
			}
		%>
		
		<input type="submit" value="Submit">
	</form>
	</section>
</body>

</html>