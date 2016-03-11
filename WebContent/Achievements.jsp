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
	// curUser declared in NavBar.js
	if (curUser == null) {
		out.println("<h1>Please Login, Redirecting...</h1>");
		request.getSession().setAttribute("message", "To See Home Page, Please Login");
		response.sendRedirect("Login.jsp"); 
	}
%>

<h1>Achievements Page</h1><hr/>

<section>
<%
	int num = 0;
	boolean amateur = false;
	boolean prolific = false;
	boolean prodigious = false;
	boolean machine = false;
	boolean greatest = false;
	boolean practice = false;
	
	if (curUser != null) {
		if (curUser.numQuizzesCreated > 0) {
			num++;
			amateur = true;
		}
			
		if (curUser.numQuizzesCreated >= 5) {
			num++;
			prolific = true;
		}
			
		if (curUser.numQuizzesCreated >= 10) {
			num++;
			prodigious = true;
		}
		
		if (curUser.numQuizzesTaken >= 10) {
			num++;
			machine = true;
		}
		
		if (curUser.achievedHighestScore) {
			num++;
			greatest = true;
		}
		
		if (curUser.practiceMode) {
			num++;
			practice = true;
		}
	}
		
	if (amateur && prolific && prodigious && machine && greatest && practice) {
		out.println("<h3>All Achievements Unlocked! You're Killing It!</h3><hr/>");
	} else if (!(amateur || prolific || prodigious || machine || greatest || practice)) {
		out.println("<h3>No Achievements</h3>");
	} else {
		out.println("<h3>Achievements (" + num + ")</h3><hr/>");
	}
	
	if(amateur) {
		num--;
		out.println("<p>You're an amateur! Go on like this and you'll be an expert in no time! (1 quiz created)</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-61-128.png\"><br>");
		
		if (num > 0) 
			out.println("<hr/>");
	}
	
	if(prolific) {
		num--;
		out.println("<p>Prolific! You're making great progress! (5 quiz created)</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-93-128.png\"><br>");
		
		if (num > 0) 
			out.println("<hr/>");
	}
	
	if(prodigious) {
		num--;
		out.println("<p>Prodigious! Wow, you're an expert! (10 quiz created)</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-81-128.png\"><br>");
		
		if (num > 0) 
			out.println("<hr/>");
	}
	
	if(machine) {
		num--;
		out.println("<p>Taking these quizzes like a machine! (10 quiz taken)</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-60-128.png\"><br>");
		
		if (num > 0) 
			out.println("<hr/>");
	}
	
	if (greatest) {
		num--;
		out.println("<p>Bow down. The greatest of them all! (You got a high score on a quiz)</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-82-128.png\"><br>");
		
		if (num > 0) 
			out.println("<hr/>");
	}
	
	if (practice) {
		num--;
		out.println("<p>Practice makes perfect, zen master! (You took a quiz in practice mode)</p><br>");
		out.println("<img src=\"https://cdn3.iconfinder.com/data/icons/ballicons-reloaded-free/512/icon-57-128.png\"><br>");
		
		if (num > 0) 
			out.println("<hr/>");
	}
%>
</section>

</body>
</html>