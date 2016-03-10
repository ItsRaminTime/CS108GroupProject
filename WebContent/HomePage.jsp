<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="home.*" %>
<%@ page import ="java.util.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home Page</title>
</head>
<body background="<%=request.getContextPath()%>/background-images/background.jpg">

<%@ include file="NavBar.jsp" %>

<%
	if (curUser == null) {
		request.getSession().setAttribute("message", "To See Home Page, Please Login");
		response.sendRedirect("Login.jsp"); 
	} else {
		out.println("<h1>Welcome " + curUser.name + "!</h1>");
	}
%>

<section id="announcements">
	<h3>Announcements</h3>
	<%
		if (request.getServletContext().getAttribute("announcements") == null) {
			out.println("<p>No Announcements</p>");
		} else {
			ArrayList<String> announcements = (ArrayList<String>) request.getServletContext().getAttribute("announcements");
			out.println("<p>" + announcements.size() + " Announcements:</p>");
			// Extra Info
		}
	%>
	<hr/>
</section>

<section id="popular-quizzes">
	<h3>Popular Quizzes</h3>
	<%
		if (request.getServletContext().getAttribute("popularQuizzes") == null) {
			out.println("<p>No Popular Quizzes</p>");
		} else {
			ArrayList<Quiz> popularQuizzes = (ArrayList<Quiz>) request.getServletContext().getAttribute("popularQuizzes");
			out.println("<p>" + popularQuizzes.size() + " Popular Quizzes:</p>");
			out.println("<ul>");
			for (Quiz q: popularQuizzes)	
				out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.id + "\">" + q.name + "</a></li>");
				out.println("</ul>");
		}
	%>
	<hr/>
</section>

<section id="recently-created-quizzes">
	<h3>Recently Created Quizzes</h3>
	<%
		if (request.getServletContext().getAttribute("recentlyCreatedQuizzes") == null) {
			out.println("<p>No Recently Created Quizzes</p>");
		} else {
			ArrayList<String> recentlyCreatedQuizzes = (ArrayList<String>) request.getServletContext().getAttribute("recentlyCreatedQuizzes");
			out.println("<p>" + recentlyCreatedQuizzes.size() + " Recenlty Created Quizzes:</p>");
			// Extra Info
		}
	%>
	<hr/>
</section>

<section id="your-recently-created-quizzes">
	<h3>Your Recently Created Quizzes</h3>
	<%
		if (request.getServletContext().getAttribute("yourRecentlyCreatedQuizzes") == null) {
			out.println("<p>No Recently Created Quizzes By You</p>");
		} else {
			ArrayList<String> yourRecentlyCreatedQuizzes = (ArrayList<String>) request.getServletContext().getAttribute("yourRecentlyCreatedQuizzes");
			out.println("<p>" + yourRecentlyCreatedQuizzes.size() + " Recenlty Created Quizzes By You:</p>");
			// Extra Info
		}
	%>
	<hr/>
</section>

<section id="messages">
	<h3>Messages</h3>
	<%
		if (request.getServletContext().getAttribute("messages") == null) {
			out.println("<p>No Messages</p>");
		} else {
			ArrayList<String> messages = (ArrayList<String>) request.getServletContext().getAttribute("messages");
			out.println("<p>" + messages.size() + " Messages:</p>");
			// Extra Info
		}
	%>
	<hr/>
</section>

<section id="friend-activity">
	<h3>Friend Activity</h3>
	<%
		if (request.getServletContext().getAttribute("friendActivity") == null) {
			out.println("<p>No Friend Activity</p>");
		} else {
			ArrayList<String> friendActivity = (ArrayList<String>) request.getServletContext().getAttribute("friendActivity");
			out.println("<p>" + friendActivity.size() + " Messages:</p>");
			// Extra Info
		}
	%>
</section>

</body>
</html>