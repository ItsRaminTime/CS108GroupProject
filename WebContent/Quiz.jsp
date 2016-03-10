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
<body background="<%=request.getContextPath()%>/background-images/background.jpg">

<%@include file="NavBar.jsp" %>

<h1><%= quiz.name %></h1>

<form action="QuizServlet?id=<%= quiz.id %>" method="post">
<% 
	int i = 0;
	for (Question q: quiz.getQuestions()) {
		int j = i+1;
		out.println("<h3>Question " + j + ")</h3>");
		out.println("<p>" + q.getDisplayStr() + "</p>");
		if(q.getType().equals("Response")) {
			out.println("<input type=\"text\" name=\"answer" + i + "\"/>");
		} else if(q.getType().equals("Multiple")) {
			out.println("<input type=\"radio\" name=\"answer" + i + "\" value=\"1\">" + q.getOption1() + "/>");
			out.println("<input type=\"radio\" name=\"answer" + i + "\" value=\"2\">" + q.getOption2() + "/>");
			out.println("<input type=\"radio\" name=\"answer" + i + "\" value=\"3\">" + q.getOption3() + "/>");
			out.println("<input type=\"radio\" name=\"answer" + i + "\" value=\"4\">" + q.getOption4() + "/>");
		} else if(q.getType().equals("Checkbox")) {
			out.println("<input type=\"checkbox\" name=\"answer" + i + "\" value=\"check1\">" + q.getOption1() + "/>");
			out.println("<input type=\"checkbox\" name=\"answer" + i + "\" value=\"check2\">" + q.getOption2() + "/>");
			out.println("<input type=\"checkbox\" name=\"answer" + i + "\" value=\"check3\">" + q.getOption3() + "/>");
			out.println("<input type=\"checkbox\" name=\"answer" + i + "\" value=\"check4\">" + q.getOption4() + "/>");
		} else if(q.getType().equals("Picture")) {
			out.println("<input type=\"text\" name=\"answer" + i + "\" value=\"check1\">" + q.getOption1() + "/>");
			out.println("<img src=\"" + q.getURL() + "\">");
		} else if(q.getType().equals("MultiAnswer")) {
			for(int k = 0; k < q.getNumAnswers(); k++) {
				out.println("<input type=\"text\" name=\"answer" + i + k + "\"/>");
			}
		}
		i++;
	}
%>
<br/>
<input type="submit" value="Submit Answers">
</form>

</body>
</html>