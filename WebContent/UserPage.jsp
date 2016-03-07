<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="home.*, java.util.*" %>   
<% 
HashMap<String,User> users = (HashMap<String,User>) request.getSession().getAttribute("users");
String id = request.getParameter("id");
User usr = users.get(id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= usr.name %></title>
</head>
<body>


<p> <%= usr.name %> </p>
<br>
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
	String line = "<li>";
    line += "<a href=\"friend.jsp?id=";
    line += (curUsr.name + "\">" + curUsr.name + "</a></li>");
    out.println(line);
}
%>
</p>


</body>
</html>