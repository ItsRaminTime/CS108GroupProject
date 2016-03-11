<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body background="<%=request.getContextPath()%>/background-images/background.jpg">

<%@include file="NavBar.jsp" %>

<link href="css/intro.css" rel="stylesheet" type="text/css">

<%
	if (curUser == null) {
		request.getSession().setAttribute("message", "To See Home Page, Please Login");
	}
%>

<h1><%=request.getSession().getAttribute("message") %></h1>
<p>Please log in.</p>
<form action="LoginServlet" method="post" class="input">
	User Name: <input type="text" name="username"><br>
	Password: <input type="password" name="password"><br><br>
	<button type="submit" value="Login">Login</button>
</form>

</body>
</html>