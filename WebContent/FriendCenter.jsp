<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Friend Center</title>
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
			out.println("<h1>Friends, Requests, and Activity</h1>");
		}
	%>
	<hr/>
	
	<section id="send">
		<h3>Send a Friend Request</h3><hr/>	
			
		<%
			UserManager um = (UserManager) request.getServletContext().getAttribute("um");
			List<User> users = um.getUsers();
		
			if (users == null || users.size() <= 1) {
				out.println("<p>No Other Users</p>");
			} else {
				out.println("<form action=\"SendRequestServlet\" action=\"post\">");
								
				out.println("Send Request To: <select name=\"user\" required>");
				for (User u: users) {	
					if (!u.name.equals(curUser.name) && !curUser.pending.contains(u.name) && !curUser.isFriendsWith(u.name))
						out.println("<option value=\"" + u.name + "\">" + u.name +"</option>");
				}
				out.println("</select>");
				
				out.println("<br/><br/><input type=\"submit\" value=\"Send\">");
				
				out.println("</form>");
			}
		%>
	</section>
	
		<section id="revoke">
		<h3>End Friendship</h3><hr/>	
			
		<%
			if (users == null || users.size() <= 1) {
				out.println("<p>No Other Users</p>");
			} else {
				out.println("<form action=\"SendRequestServlet\" action=\"post\">");
								
				out.println("End Friendship With: <select name=\"user\" required>");
				for (User u: users) {	
					if (!u.name.equals(curUser.name) && curUser.isFriendsWith(u.name))
						out.println("<option value=\"" + u.name + "\">" + u.name +"</option>");
				}
				out.println("</select>");
				
				out.println("<br/><br/><input type=\"submit\" value=\"Send\">");
				
				out.println("</form>");
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
	
		<section id="pending">		
		<%
			if (curUser == null) {
				out.println("<h3>No Pending Outbound Friend Requests</h3>");
			} else {
				if (curUser.pending.size() == 0) {
					out.println("<h3>No Pending Outbound Friend Requests</h3>");
				} else {
					out.println("<h3>Pending Outbound Friend Requests (" + curUser.pending.size() + ")</h3><hr/>");
					
					out.println("<ul class=\"scroll-box\">");
					
					for (String s: curUser.pending) {
						out.println("<li><a href=\"UserPage.jsp?username=" + s + "\">You sent a request to " + s + "</a>");
					}
					out.println("</ul>");
				}
			}
		%>
	</section>
	
	<section id="friends">		
		<%
			if (curUser == null) {
				out.println("<h3>No Friends</h3>");
			} else {
				if (curUser.friends.size() == 0) {
					out.println("<h3>No Friends</h3>");
				} else {
					out.println("<h3>Friends (" + curUser.friends.size() + ")</h3><hr/>");
					
					out.println("<ul class=\"scroll-box\">");
					
					for (User u: curUser.friends) {
						out.println("<li><a href=\"UserPage.jsp?username=" + u.name + "\">" + u.name + "</a></li><br/>");
					}
					
					out.println("</ul>");
				}
			}
		%>
	</section>

</body>
</html>