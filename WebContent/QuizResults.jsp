<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="home.Quiz" %>
<%@ page import ="home.Question" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<% Quiz quiz = (Quiz) request.getServletContext().getAttribute("quiz"); %>
<title><%= quiz.getName() %> Results</title>
</head>
<body>
<%@include file="NavBar.jsp" %>

<h1><%= quiz.getName() %> Results</h1>

<h3>Your Score: <%= quiz.checkQuiz() %><h3>
<% 
int i = 1;
for (Question q: quiz.getQuestions()) {
	out.println("<h3>Question " + i + ")</h3>");
	out.println("<p>Question: " + q.getDisplayStr() + "</p>");
	out.println("<p>Correct Answer: " + q.getCorrectAnswer() + "</p>");
	out.println("<p>Your Answer: " + q.getGivenAnswer() + "</p>");
	if (q.isCorrect())
		out.println("<p>CORRECT</p>");
	else
		out.println("<p>WRONG</p>");
}
%>

</body>
</html>