<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Messages and Challenges</title>
</head>
<body background="https://images5.alphacoders.com/381/381373.jpg">

	<%@ page import ="home.*" %>
	<%@ page import ="java.util.*" %>
	<%@include file="NavBar.jsp" %>

	<%
		// curUser declared in NavBar.js
		if (curUser == null) {
			out.println("<h1>Please Login, Redirecting...</h1>");
			request.getSession().setAttribute("message", "To See Home Page, Please Login");
			response.sendRedirect("Login.jsp"); 
		} else {
			out.println("<h1>Send Messages, Read Messages, and Accept Challenges</h1>");
		}
	%>
	<hr/>
	
	<section id="send">
		<h3>Send a Message</h3><hr/>	
			
		<%
			UserManager um = (UserManager) request.getServletContext().getAttribute("um");
			List<User> users = um.getUsers();
		
			if (users == null || users.size() <= 1) {
				out.println("<p>No Other Users</p>");
			} else {
				out.println("<form action=\"SendMessageServlet\" action=\"post\">");
				
				out.println("Message Body:<br/><br/><textarea cols=\"100\" rows=\"5\" name=\"text\"></textarea><br/><br/>");
				
				out.println("Recipient: <select name=\"user\">");
				for (User u: users) {	
					if (!u.name.equals(curUser.name))
						out.println("<option value=\"" + u.name + "\">" + u.name +"</option>");
				}
				out.println("</select>");
				out.println("<br/><br/><input type=\"submit\" value=\"Send\">");
				
				out.println("</form>");
			}
		%>
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

</body>
</html>