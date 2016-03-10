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

<body>
	<%@ include file="NavBar.jsp" %>
	
	<h1>Set Up Your Questions</h1>
	<h3>What type of questions do you want?</h3>
	<hr/>

	<form action="CreateQuizServlet" method="get">
		<% 
			for (int i = 0; i < numQuestions; i++) {
				out.println("<p>Question Type for #" + (i+1) + ":");
				out.println("<select name=\"questionType" + i + "\">");
				out.println("<option value=\"response\">Response</option>");
				out.println("</select></p>");
			}
		%>
		
		<input type="submit" value="Submit">
	</form>
</body>

</html>