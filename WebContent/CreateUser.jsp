<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New User</title>
</head>
<body>

<%@include file="NavBar.jsp" %>

<h1><%= request.getSession().getAttribute("message") %></h1>
<p>Please enter proposed name and password.</p>
<form action="CreateUserServlet" method="post">
	User Name: <input type="text" name="username"><br>
	Password: <input type="password" name="password"><br>
	<input type="submit" value="Register">
</form>

</body>
</html>