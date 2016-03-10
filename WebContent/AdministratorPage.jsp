<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="home.*" %>
<%@ page import ="java.util.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
</head>

<body background="<%=request.getContextPath()%>/background-images/background.jpg">
<%@ include file="NavBar.jsp" %>
<h1>Administrator Page</h1>
<section id="Users">

</section>
<section id="Quizzes">

</section>
<section id="Announcements">
<form action="AnnounceServlet" method="post">
	<p>Please enter your announcement below to queue it.</p>
	<textarea name="announcetext" cols="40" rows="5" width="200px" height="50px"></textarea><br>
	<input type="submit" value="Enqueue"><br>
</form>
</section>
</body>
</html>