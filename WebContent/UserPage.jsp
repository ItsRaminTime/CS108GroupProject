<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="home.*, java.util.*" %>   
<% 
AccountManager accMan = (AccountManager) request.getServletContext().getAttribute("Account Manager");
HashMap<String, User> userMap = accMan.accounts;
String name = request.getParameter("id");
User usr = userMap.get(name);
User acctUser = (User) request.getSession().getAttribute("curUser");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= usr.name %></title>
</head>
<body>
<%@include file="NavBar.jsp" %>
<p> <%= usr.name %> </p>
<br>

<%
if (acctUser.friends.contains(usr)) {
	out.println("You are friends with " + usr.name);
} else if (usr.name.equals(acctUser.name)) {
	out.println(" That's you!");
} else {
	out.println("<form action=\"AddFriend\" method=\"post\">");
	out.println("<input type=\"hidden\" name=\"page\" value=\"userpage\">");
	out.println("<input type=\"hidden\" name=\"user\" value=\"" + usr.name + "\">");
	out.println("<input type=\"submit\" value=\"Add to Friends\">");
	out.println("</form>");	
}
%>

<p>Quizzes taken
<br>
<%
for (int i=0; i<usr.quizzesTaken.size(); i++) {
	out.println(usr.quizzesTaken.get(i));
	out.println("<br>");
}
%>
</p>
<p> Friends of <%= usr.name %>
<br>

<%
for (int i=0; i<usr.friends.size(); i++) {
	User curUsr = usr.friends.get(i);
	out.println("<li>");
    out.println("<a href=\"UserPage.jsp?id=");
    out.println(curUsr.name + "\">" + curUsr.name + "</a>");  
}
%>
</p>


</body>
</html>