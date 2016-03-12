<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%
	String message = (String) request.getSession().getAttribute("message");
	if (message == null) message = "Create Account";		
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Login</title>
</head>

<body background="https://images5.alphacoders.com/381/381373.jpg">
	<%@ include file="NavBar.jsp" %>
	
	<h1><%= message %></h1>
	<hr/>
	
	<section>
	<h3>Please log in. Entering "admin" as both the name and password grants access to default admin account.</h3><hr/>
	
	<form action="LoginServlet" method="post">
		<p>User Name: <input type="text" name="username" required><br></p>
		<p>Password: <input type="password" name="password" required><br></p>
		<input type="submit" value="Login">
	</form>
	</section>
</body>

</html>