<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="home.*" %>
<%@ page import ="java.util.*" %>

<%
UserManager usrManager = (UserManager) request.getServletContext().getAttribute("um");
HashMap<String, User> userMap = usrManager.getHash();
User acctUser = (User) request.getSession().getAttribute("curUser");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Page</title>
</head>
<body>
<%@include file="NavBar.jsp" %>
<%
for (User usr : userMap.values()) {
	out.println("<li>");
	out.println("<p>");
    out.println("<a href=\"UserPage.jsp?id=");
    out.println(usr.name + "\">" + usr.name + "</a>");
    out.println("  ");
    if (acctUser.friends.contains(usr)) {
    	out.println(" Already Friends!");
    } else if (usr.name.equals(acctUser.name)) {
    	out.println(" That's you!");
    }	
    else {
    	out.println("<form action=\"AddFriend\" method=\"post\">");
    	out.println("<input type=\"hidden\" name=\"page\" value=\"list\">");
    	out.println("<input type=\"hidden\" name=\"user\" value=\"" + usr.name + "\">");
    	out.println("<input type=\"submit\" value=\"Add to Friends\">");
    	out.println("</form>");	
    }
	out.println("</p>");
    out.println("</li>");
    
}

%>


</body>
</html>