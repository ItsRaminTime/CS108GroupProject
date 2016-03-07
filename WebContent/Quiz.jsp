<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="home.Quiz" %>
<%@ page import ="home.Question" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<% Quiz quiz = (Quiz) request.getServletContext().getAttribute("quiz"); %>
<title><%= quiz.name %></title>

</head>
<body>

<%@include file="NavBar.jsp" %>

<h1><%= quiz.name %></h1>

<form action="QuizServlet?id=<%= quiz.id %>" method="post">
<% 
	int i = 0;
	for (Question q: quiz.getQuestions()) {
		int j = i+1;
		out.println("<h3>Question " + j + ")</h3>");
		out.println("<p>" + q.getDisplayStr() + "</p>");
		out.println("<input type=\"text\" name=\"answer" + i + "\"/>");
		i++;
	}
%>
<br/>
<input type="submit" value="Submit Answers">
</form>

</body>
</html>