<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Achievements</title>
</head>
<body background="<%=request.getContextPath()%>/background-images/background.jpg">

<%@include file="NavBar.jsp" %>

<% 
	boolean amateur = false;
	boolean prolific = false;
	boolean prodigious = false;
	boolean machine = false;
	boolean greatest = false;
	boolean practice = false;
	
	if (curUser.numQuizzesCreated > 0) {
		amateur = true;
	}
	if (curUser.numQuizzesCreated >= 5) {
		prolific = true;
	}
	if (curUser.numQuizzesCreated >= 10) {
		prodigious = true;
	}
	if (curUser.numQuizzesTaken >= 10) {
		machine = true;
	}
	if (curUser.achievedHighestScore) {
		greatest = true;
	}
	if (curUser.practiceMode) {
		practice = true;
	}
	if(amateur || prolific || prodigious || machine || greatest || practice) {
		out.println("<h1>Congratulations! You're Killing It!</h1><br>");
	} else {
		out.println("<h1>No Achievements Yet</h1>");
	}
	if(amateur) {
		out.println("<p>You're an amateur! Go on like this and you'll be an expert in no time!</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-61-128.png\"><br>");
	}
	if(prolific) {
		out.println("<p>Prolific! You're making great progress!</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-93-128.png\"><br>");
	}
	if(prodigious) {
		out.println("<p>Prodigious! Wow, you're an expert!</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-81-128.png\"><br>");
	}
	if(machine) {
		out.println("<p>Taking these quizzes like a machine!</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-60-128.png\"><br>");
	}
	if(greatest) {
		out.println("<p>Bow down. The greates of them all!</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-82-128.png\"><br>");
	}
	if(practice) {
		out.println("<p>Practice makes perfect, zen master!</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-57-128.png\"><br>");
	}
%>

</body>
</html>