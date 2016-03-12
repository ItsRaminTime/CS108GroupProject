<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ page import="home.*" %>
<%@ page import="java.util.*" %>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Home Page</title>
</head>

<body>
	<%@ include file="NavBar.jsp" %>

	<%
		// curUser declared in NavBar.js
		if (curUser == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} else {
			out.println("<h1>Welcome " + curUser.name + "</h1>");
		}
	%>
	<hr/>
		
	<section id="announcements">
		<%
			AnnouncementManager am = (AnnouncementManager) request.getServletContext().getAttribute("am");
			List<Announcement> anns = am.getAnns();
		
			if (anns == null || anns.size() == 0) {
				out.println("<h3>No Announcements</h3>");
			} else {				
				out.println("<h3>Announcements (" + anns.size() + ")</h3><hr/>");
				out.println("<p class=\"scroll-box\">");
				
				for (Announcement an: anns)
					out.println("Posted on: " + an.date + "<p>" + an.message + "</p><hr/>");
				
				out.println("All announcements are posted by admin accounts.</p>");
			}
		%>
	</section>

	<section id="popular-quizzes">		
		<%
			if (request.getServletContext().getAttribute("popularQuizzes") == null) {
				out.println("<h3>No Popular Quizzes</h3>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<Quiz> popularQuizzes = (ArrayList<Quiz>) request.getServletContext().getAttribute("popularQuizzes");
				
				out.println("<h3>Popular Quizzes (" + popularQuizzes.size() + ")</h3><hr/>");
				out.println("<ul class=\"scroll-box\">");
				
				for (Quiz q: popularQuizzes)	
					out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.id + "\">" + q.name + "</a> | Times Taken: " + q.numTaken + "</li>");
				
				out.println("</ul>");
			}
		%>
	</section>

	<section id="recently-created-quizzes">
		<%
			if (request.getServletContext().getAttribute("recentlyCreatedQuizzes") == null) {
				out.println("<h3>No Recently Created Quizzes</h3>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<Quiz> recentlyCreatedQuizzes = (ArrayList<Quiz>) request.getServletContext().getAttribute("recentlyCreatedQuizzes");
				out.println("<h3>Recently Created Quizzes (" + recentlyCreatedQuizzes.size() + ")</h3><hr/>");

				
				out.println("<ul class=\"scroll-box\">");
				
				for (Quiz q: recentlyCreatedQuizzes)	
					out.println("<li><a href=\"QuizWelcome.jsp?id=" + q.id + "\">" + q.name + "</a> | Date Created: " + q.getDate() + "</li>");
				
				out.println("</ul>");
			}
		%>
	</section>
	
	<section id="your-recently-created-quizzes">
		<%
			if (request.getServletContext().getAttribute("yourRecentlyCreatedQuizzes") == null) {
				out.println("<h3>No Recently Created Quizzes By You</h3>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<QuizCreated> yourRecentlyCreatedQuizzes = (ArrayList<QuizCreated>) request.getServletContext().getAttribute("yourRecentlyCreatedQuizzes");
				if (yourRecentlyCreatedQuizzes.size() == 0) {
					out.println("<h3>No Recently Created Quizzes By You</h3>");
				} else {	
					out.println("<h3>Recently Created Quizzes By You (" + yourRecentlyCreatedQuizzes.size() + ")</h3><hr/>");
					
					out.println("<ul class=\"scroll-box\">");
					
					for (QuizCreated qc: yourRecentlyCreatedQuizzes)	
						out.println("<li><a href=\"QuizWelcome.jsp?id=" + qc.quizId + "\">" + qc.quizName + "</a> | Date Created: " + qc.date + "</li>");
					
					out.println("</ul>");
				}
			}
		%>
	</section>
	
	<section id="your-recently-taken-quizzes">		
		<%
			if (request.getServletContext().getAttribute("yourRecentlyTakenQuizzes") == null) {
				out.println("<h3>No Recently Taken Quizzes By You</h3>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<QuizResult> yourRecentlyTakenQuizzes = (ArrayList<QuizResult>) request.getServletContext().getAttribute("yourRecentlyTakenQuizzes");
				if (yourRecentlyTakenQuizzes.size() == 0) {
					out.println("<h3>No Recently Taken Quizzes By You</h3>");
				} else {
					out.println("<h3>Recently Taken Quizzes By You (" + yourRecentlyTakenQuizzes.size() + ")</h3><hr/>");
					
					out.println("<ul class=\"scroll-box\">");
					
					for (QuizResult qr: yourRecentlyTakenQuizzes) {
						String line = "<li><a href=\"QuizResultServlet?id=" + qr.getQuizId() + "&date=" + qr.getDate() + "\">Results for " + qr.getQuizName();
						line += "</a> | Date Taken: " + qr.getDate() + " | Score: " + qr.getScore() + "/" + qr.getTotal() + "</li>";
						out.println(line);
					}
					
					out.println("</ul>");
				}
			}
		%>
	</section>
	
	<section id="achievements">
		<div class="scroll-box">
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
					
				if(amateur && prolific && prodigious && machine && greatest && practice) {
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
		</div>
	</section>
	
	<section id="messages">		
		<%
			if (curUser == null) {
				out.println("<h3>No Messages</h3>");
			} else {
				if (curUser.messages.size() == 0) {
					out.println("<h3>No Messages</h3>");
				} else {
					out.println("<h3>Messages (" + curUser.messages.size() + ")</h3><hr/>");
					
					out.println("<div class=\"scroll-box\">");
					
					for (Message m: curUser.messages) {
						out.println("<p><a href=\"UserPage?username=" + m.sender.name + "\">" + m.sender.name + "</a> sent you a message at: " + m.date + "</p>");
						out.println("<p>" + m.message + "</p><hr/>");
					}
					
					out.println("</div> Visit the Message Center to reply!");
				}
			}
		%>
	</section>
	
	<section id="challenges">		
		<%
			if (curUser == null) {
				out.println("<h3>No Challenges</h3>");
			} else {
				if (curUser.challenges.size() == 0) {
					out.println("<h3>No Challenges</h3>");
				} else {
					out.println("<h3>Challenges (" + curUser.challenges.size() + ")</h3><hr/>");
					
					out.println("<ul class=\"scroll-box\">");
					
					for (Message m: curUser.challenges) {
						out.println("<li><a href=\"" + m.url + "\">Try Challenge</a> - " + m.message + " (" + m.date + ")</li><br/>");
					}
					
					out.println("</ul>");
				}
			}
		%>
	</section>
	
		<section id="requests">		
		<%
			if (curUser == null) {
				out.println("<h3>No Requests</h3>");
			} else {
				if (curUser.requests.size() == 0) {
					out.println("<h3>No Friend Requests</h3>");
				} else {
					out.println("<h3>Friend Requests (" + curUser.requests.size() + ")</h3><hr/>");
					
					out.println("<ul class=\"scroll-box\">");
					
					for (Message m: curUser.requests) {
						out.println("<li><a href=\"" + m.url + "\">Accept Request</a> - " + m.message + " (" + m.date + ")</li><br/>");
					}
					out.println("</ul>");
				}
			}
		%>
	</section>
	
	<section id="friend-activity">
		<h3>Friend Activity</h3><hr/>
		
		<%
			if (request.getServletContext().getAttribute("friendActivity") == null) {
				out.println("<p>No Friend Activity</p>");
			} else {
				@SuppressWarnings("unchecked")
				ArrayList<String> friendActivity = (ArrayList<String>) request.getServletContext().getAttribute("friendActivity");
				
				out.println("<p>" + friendActivity.size() + " Friend Activity Item(s):</p>");
				out.println("<ul class=\"scroll-box\">");
				
				for (String s: friendActivity)	
					out.println("<li>" + s + "</li>");
				
				out.println("</ul>");
			}
		%>
	</section>
</body>

</html>