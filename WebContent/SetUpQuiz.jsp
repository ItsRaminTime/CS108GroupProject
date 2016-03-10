<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Set Up Quiz</title>
</head>

<body>
	<%@ include file="NavBar.jsp" %>
	
	<h1>Set Up Quiz</h1>
	<h3>Fill in basic quiz parameters.</h3>
	<hr/>
	
	<form action="SetUpQuestions.jsp" method="get">
		<p>
			Name of Quiz:
			<input type="text" name="name" required/>
		</p>
		
		<p>
			Number of Question:
			<input type="number" name="numQuestions" min="1" required/>
		</p>
		
		<input type="submit" value="Submit">
	</form>
</body>

</html>