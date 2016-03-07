<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="home.*" %>
<%@ page import ="java.util.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>HomePage</title>
</head>
<body background="<%=request.getContextPath()%>/background-images/background.jpg">

<%@include file="NavBar.jsp" %>

<h1>Welcome <%=request.getSession().getAttribute("Username")%></h1>
<section id=Messages>
	<%
		if(request.getServletContext().getAttribute("MessageList") == null) {
			ArrayList<Message> messageList = new ArrayList<Message>();
			request.getServletContext().setAttribute("MessageList", messageList);
			out.println("<p>No Current Messages!");
		} else {
			ArrayList<Message> messageList = (ArrayList<Message>)request.getServletContext().getAttribute("MessageList");
			out.println("<p>You Have " + messageList.size() + " New Messages</p>");
			//Extra Info
		}
	%>
</section>
<section id=Achievements>
	<%
		if(request.getServletContext().getAttribute("Achievements") == null) {
			ArrayList<String> achievements = new ArrayList<String>();
			request.getServletContext().setAttribute("Achievements", achievements);
			out.println("<p>No Current Achievements :(</p>");
		} else {
			ArrayList<String> achievements = (ArrayList<String>)request.getServletContext().getAttribute("Achievements");
			out.println("<p>Current Achievements</p>");
			String name;
			for(int i= 0; i < achievements.size(); i++) {
				name = achievements.get(i);
				out.println("<img src=\"" + request.getContextPath() + "/achievement-images/" + name + "\">");
			}
		}
	%>
</section>
<section id=PopularQuizzes>
	<p>Popular Quizzes</p>
	<ul>
	<%
		List<Quiz> rankings = (ArrayList<Quiz>)request.getServletContext().getAttribute("QuizRankings");
		if(rankings == null || rankings.isEmpty()) {
			out.println("<li>No Current Popular Quizzes</li>");
		} else {
			for (Quiz q: rankings) {
				out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.getId() + "\">" + q.getName() + "</a></li>");
			}
		}
	%>
	</ul>
</section>
<section id=RecentlyCreatedQuizzes>
	<p>Recently Created Quizzes</p>
	<ul>
	<%
		if(rankings == null || rankings.isEmpty()) {
			out.println("<li>No Recently Created Quizzes</li>");
		} else {
			for (Quiz q: rankings) {
				out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.getId() + "\">" + q.getName() + "</a></li>");
			}
		}
	%>
	</ul>
</section>
<section id=YourRecentlyTakenQuizzes>
	<p>Your Recently Taken Quizzes</p>
	<ul>
	<%
		if(rankings == null || rankings.isEmpty()) {
			out.println("<li>You Have No Recently Taken Quizzes</li>");
		} else {
			for (Quiz q: rankings) {
				out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.getId() + "\">" + q.getName() + "</a></li>");
			}
		}
	%>
	</ul>
</section>
<section id=YourRecentlyCreatedQuizzes>
	<p>Your Recently Created Quizzes</p>
	<ul>
		<%
			if(rankings == null || rankings.isEmpty()) {
				out.println("<li>You Have No Recently Created Quizzes</li>");
			} else {
				for (Quiz q: rankings) {
					out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.getId() + "\">" + q.getName() + "</a></li>");
				}
			}
		%>
	</ul>
</section>
<div style="overflow:auto" id=Announcements>
	<p>Recent Announcements</p>
	<ui>
	<%
		if(request.getServletContext().getAttribute("Announcements") == null) {
			ArrayList<String> announcements = new ArrayList<String>();
			request.getServletContext().setAttribute("Announcements", announcements);
			out.println("No Recent Announcements");
		} else {
			ArrayList<String> announcements = (ArrayList<String>)request.getServletContext().getAttribute("Announcements");
			String content;
			for(int i= 0; i < announcements.size(); i++) {
				content = announcements.get(i);
				out.println("<li>" + content + "</li>");
			}
		}
	%>
	</ui>
</div>
<section id=Friends>
	<p>Friends & Activities</p>
	<ul>
	<%
		if(request.getServletContext().getAttribute("Users") == null) {
			HashMap<String, User> users = new HashMap<String, User>();
			out.println("<li>You Have No Friends Available :(</li>");
		} else {
			HashMap<String, User> users = (HashMap<String, User>)request.getServletContext().getAttribute("Users");
			ArrayList<User> friends = users.get(request.getSession().getAttribute("Username")).friends;
			if(friends.isEmpty()) {
				out.println("<li>You Have No Friends Available :(</li>");
			} else {
				String name;
				for(int i= 0; i < friends.size(); i++) {
					name = friends.get(i).name;
					out.println("<li><a href=\"UserPage.jsp?id=" + name + "\">" + name + "</a></li>");
				}
			}
		}
	%>
	</ul>
</section>
</body>
</html>