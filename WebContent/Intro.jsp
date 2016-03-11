<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body background="<%=request.getContextPath()%>/background-images/background.jpg">

<link href="css/intro.css" rel="stylesheet" type="text/css">

<h1>Quizz In Yo Pants</h1>
<p>The New Chic For Quizzing All You want ...</p>
<form action="Login.jsp" method="get" class="inline">
	<button type="submit" class="inline" value="Login" id="Login">Login</button>
</form>
<form action="CreateUser.jsp" method="get" class="inline">
	<button type="submit" class="inline" value="Register" id="Register">Register</button>
</form>
<form action="AdministratorPage.jsp" method="get" class="inline">
	<button type="submit" class="inline" value="Admin" id="Admin">Admin</button>
</form>
</body>
</html>