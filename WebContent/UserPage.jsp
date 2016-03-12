<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ page import ="home.*" %>
<%@ page import ="java.util.*" %>

<%
	UserManager um = (UserManager) request.getServletContext().getAttribute("um");
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Profile Page</title>
</head>

<body background="https://images5.alphacoders.com/381/381373.jpg">
	<%@include file="NavBar.jsp" %>
	
	<%
		int numTaken = 0;
		int numCreated = 0;
		List<QuizResult> yourRecentlyTakenQuizzes = null;
		List<QuizResult> topScores = null;
		List<QuizCreated> yourRecentlyCreatedQuizzes = null;
		User user = um.getUserByName(request.getParameter("username"));
	
		// curUser declared in NavBar.js
		if (curUser == null || user == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} else {
			out.println("<h1>" + user.name + "'s Profile</h1>");
			numTaken = user.numQuizzesTaken;
			numCreated = user.numQuizzesCreated;
			yourRecentlyTakenQuizzes = um.getRecentlyTakenQuizzes(user);
			yourRecentlyCreatedQuizzes = um.getRecentlyCreatedQuizzes(user);
			topScores = um.getTopScores(user);
		}
	%>
	<hr/>
	
		<%
			if (!curUser.name.equals(user.name)) {
				
				out.println("<section>");
				out.println("<h1>Reach Out to " + user.name + "</h1><hr/>");
				out.println("<form action=\"SendMessageServlet\" action=\"post\">");
				
				out.println("Message Body:<br/><br/><textarea cols=\"100\" rows=\"5\" name=\"text\"></textarea><br/><br/>");
				out.println("<input type=\"hidden\" name=\"user\" value=\"" + user.name + "\">");
				out.println("<input type=\"submit\" value=\"Send Message\">");
				
				out.println("</form>");
				
				if (!user.name.equals(curUser.name) && !curUser.pending.contains(user.name) && !curUser.isFriendsWith(user.name)) {
					out.println("<hr/>");
					out.println("<form action=\"SendRequestServlet\" action=\"post\">");
					out.println("<input type=\"hidden\" name=\"user\" value=\"" + user.name + "\">");
					out.println("<input type=\"submit\" value=\"Send Friend Request\">");
					
					out.println("</form>");
				}
				
				out.println("</section>");
			}
		%>

	
	<section id="your-recently-created-quizzes" class="scroll-box-wrapper">
		<h3>Recently Created Quizzes</h3><hr/>
		<p>Quizzes created: <%= numCreated %></p>
		
		<%
			if (um == null || yourRecentlyCreatedQuizzes == null) {
				out.println("<p>No Recently Created Quizzes By You</p>");
			} else {				
				out.println("<ul class=\"scroll-box\">");
				
				for (QuizCreated qc: yourRecentlyCreatedQuizzes)	
					out.println("<li><a href=\"QuizWelcome.jsp?id=" + qc.quizId + "\">" + qc.quizName + "</a> | Date Created: " + qc.date + "</li>");
				
				out.println("</ul>");
			}
		%>
	</section>
	
	<section id="your-recently-taken-quizzes" class="scroll-box-wrapper">
		<h3>Recently Taken Quizzes</h3><hr/>
		<p>Quizzes taken: <%= numTaken %></p>
		
		<%
			if (um == null || yourRecentlyTakenQuizzes == null) {
				out.println("<p>No Recently Taken Quizzes By You</p>");
			} else if (yourRecentlyTakenQuizzes.size() == 0) {
				out.println("<p>No Recently Taken Quizzes By You</p>");
			} else {
				out.println("<ul class=\"scroll-box\">");
				
				for (QuizResult qr: yourRecentlyTakenQuizzes) {
					String line = "<li><a href=\"QuizResultServlet?id=" + qr.getQuizId() + "&date=" + qr.getDate() + "\">Results for: " + qr.getQuizName();
					line += "</a> | Date Taken: " + qr.getDate() + " | Score: " + qr.getScore() + "/" + qr.getTotal() + "</li>";
					out.println(line);
				}
				
				out.println("</ul>");
			}
		%>
	</section>
	
	<section id="top-quizzes" class="scroll-box-wrapper">
		<h3>Top Scores</h3><hr/>
				
		<%
			if (um == null || topScores == null) {
				out.println("<p>No Top Scores</p>");	
			} else if (topScores.size() == 0) {
				out.println("<p>No Top Scores</p>");
			} else {				
				out.println("<ul class=\"scroll-box\">");				
				for (QuizResult qr: topScores)	
					out.println("<li><a href=\"QuizWelcome.jsp?id=" + qr.getQuizId() + "\">Results for " + qr.getQuizName() + "</a> | Score: " + qr.getScore() + "/" + qr.getTotal() + "</li>");
				out.println("</ul>");
			}
		%>
	</section>
	
	<section id="achievements" class="scroll-box-wrapper">
		<div class="scroll-box">
			<%
				int num = 0;
				boolean amateur = false;
				boolean prolific = false;
				boolean prodigious = false;
				boolean machine = false;
				boolean greatest = false;
				boolean practice = false;
				
				if (user != null) {
					if (user.numQuizzesCreated > 0) {
						num++;
						amateur = true;
					}
						
					if (user.numQuizzesCreated >= 5) {
						num++;
						prolific = true;
					}
						
					if (user.numQuizzesCreated >= 10) {
						num++;
						prodigious = true;
					}
					
					if (user.numQuizzesTaken >= 10) {
						num++;
						machine = true;
					}
					
					if (user.achievedHighestScore) {
						num++;
						greatest = true;
					}
					
					if (user.practiceMode) {
						num++;
						practice = true;
					}
				}
					
				if(amateur && prolific && prodigious && machine && greatest && practice) {
					out.println("<h3>All 6 Achievements Unlocked! You're Killing It!</h3><hr/>");
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
		</div>
	</section>
	
	<section id="friends">		
		<%
			if (user == null) {
				out.println("<h3>No Friends</h3>");
			} else {
				if (user.friends.size() == 0) {
					out.println("<h3>No Friends</h3>");
				} else {
					out.println("<h3>Friends (" + user.friends.size() + ")</h3><hr/>");
					
					out.println("<ul class=\"scroll-box\">");
					
					for (User u: user.friends) {
						out.println("<li><a href=\"UserPage.jsp?username=" + u.name + "\">" + u.name + "</a></li><br/>");
					}
					
					out.println("</ul>");
				}
			}
		%>
	</section>
</body>

</html>