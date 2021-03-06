<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Set Up Quiz</title>
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
	
	<h1>Set Up Quiz</h1>
	
	<hr/>
	<section>
	<h3>Fill in basic quiz parameters.</h3><hr/>
	<form action="SetUpQuestions.jsp" method="get">
		<p>
			Name of Quiz:
			<input type="text" name="name" required/>
		</p>
		
		<p>
			Number of Question:
			<input type="number" name="numQuestions" min="1" required/>
		</p><hr/>
		
		<input type="submit" value="Submit">
	</form>
	</section>
</body>

</html>