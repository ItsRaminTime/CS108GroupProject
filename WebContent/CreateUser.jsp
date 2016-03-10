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
	<title>Create New User</title>
</head>

<body>
	<%@ include file="NavBar.jsp" %>

	<h1><%= message %></h1>
	<hr/>
	
	<h3>Please enter proposed name and password. Usernames and passwords are case sensitive.</h3>
	
	<form action="CreateUserServlet" method="post">
		<p>Username: <input type="text" name="username"><br></p>
		<p>Password: <input type="password" name="password"><br></p>
		<input type="submit" value="Register">
	</form>
</body>

</html>