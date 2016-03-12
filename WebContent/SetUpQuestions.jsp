<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%  
	String name = request.getParameter("name");
	request.getSession().setAttribute("name", name);
	
	int numQuestions = Integer.parseInt(request.getParameter("numQuestions"));
	request.getSession().setAttribute("numQuestions", numQuestions);
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Set Up Questions</title>
</head>

<body background="https://images5.alphacoders.com/381/381373.jpg">
	<%@ include file="NavBar.jsp" %>
	
	<%
		// curUser declared in NavBar.js
		if (curUser == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} 
	%>
	
	<h1>Set Up Your Questions</h1>
	<hr/>

	<section>
	<h3>What type of questions do you want?</h3><hr>

	<form action="CreateQuizServlet" method="get">
		<% 
			for (int i = 0; i < numQuestions; i++) {
				out.println("<p>Question Type for #" + (i+1) + ":");
				out.println("<select name=\"questionType" + i + "\">");
				out.println("<option value=\"response\">Response</option>");
				out.println("<option value=\"fillblank\">Fill In The Blank</option>");
				out.println("<option value=\"truefalse\">True/False</option>");
				out.println("<option value=\"multchoice\">Multiple Choice</option>");
				out.println("<option value=\"pic\">Picture Response</option>");
				out.println("</select></p>");
			}
		%><hr/>
		
		<input type="submit" value="Submit">
	</form>
	</section>
</body>

</html>