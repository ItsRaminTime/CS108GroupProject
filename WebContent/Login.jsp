<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
<%@include file="NavBar.jsp" %>
<h1>Welcome to the Quiz Page</h1>
<p>Please log in.</p>
<form action="LoginServlet" method="post">
	User Name: <input type="text" name="Name"><br>
	Password: <input type="text" name="Password"><br>
	<input type="submit" value="Login">
</form>
<a href="CreateNew.jsp">Create New Account</a>
<a href="AdministratorPage.jsp">Login as Administrator</a>
</body>
</html>