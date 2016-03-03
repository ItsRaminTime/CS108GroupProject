<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="home.*" %>
<%@ page import ="java.util.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quiz Welcome Page</title>
</head>
<body>
<%@include file="NavBar.jsp" %>
	
<%
	Quiz quiz = ((QuizManager)request.getServletContext().getAttribute("Quiz Manager")).getQuizById(Integer.parseInt(request.getParameter("id")));
%>

<h1>Welcome to <%=quiz.getName()%></h1>
<p>This quiz has <%=quiz.getQuestions().size()%></p>

</body>
</html>