<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="home.*, java.util.*" %>   
<% 
UserManager usrMan = (UserManager) request.getServletContext().getAttribute("um");
QuizManager quizMan = (QuizManager) request.getServletContext().getAttribute("qm");
ArrayList<Quiz> quizList = (ArrayList<Quiz>) quizMan.getPopularQuizzes();
HashMap<String, User> userMap = usrMan.getHash();
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

<section id="add-as-friend">
	<%
	if (acctUser.friends.contains(usr)) {
		out.println("You are friends with " + usr.name);
	} else if (usr.name.equals(acctUser.name)) {
		out.println(" That's you!");
	} else {
		/*out.println("<form action=\"AddFriend\" method=\"post\">");
		out.println("<input type=\"hidden\" name=\"page\" value=\"userpage\">");
		out.println("<input type=\"hidden\" name=\"user\" value=\"" + usr.name + "\">");
		out.println("<input type=\"submit\" value=\"Add to Friends\">");
		out.println("</form>");	*/
		out.println("<form action=\"SendMessageServlet\" method=\"post\">");
		out.println("<input type=\"hidden\" name=\"page\" value=\"userpage\">");
		out.println("<input type=\"hidden\" name=\"recipient\" value=\"" + usr.name + "\">");
		out.println("<input type=\"hidden\" name=\"type\" value=\"friend\">");
		out.println("<input type=\"submit\" value=\"Add to Friends\">");
		out.println("</form>");
	}
	%>
</section>
	
<section id="quiz-list">
	<p>Quizzes taken
	<br>
		<%
		for (int i=0; i<usr.quizzesTaken.size(); i++) {
			out.println(usr.quizzesTaken.get(i));
			out.println("<br>");
		}
		%>
	</p>
</section>

<section id="friend-list">	
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
</section>
<br>
<br>
<section id="send-message">
	<form action="SendMessageServlet" method="post">
		Send <%= usr.name %> a message: <br>
		<input type="textarea" name="message"><br>
		<input type="hidden" name="type" value="message">
		<input type="hidden" name="recipient" value="<%= usr.name %>">
		<input type="submit" value="Send Message">
	</form>
</section>
<br>
<br>
<section id="quiz-challenge">
	<form action="SendMessageServlet" method="post">
		<select name="quiz-id">
  			<% 
  				for (int i = 0; i < quizList.size(); i++) {
  					Quiz curQuiz = quizList.get(i);
					out.println("<option value=\"" + curQuiz.id + "\">"+curQuiz.name+"</option");  			 			
  				}  			 			
 			%>
		</select>
		<input type="hidden" name="type" value="challenge">
		<input type="hidden" name="recipient" value="<%= usr.name %>">
		<input type="submit" value="Send Challenge">
	</form>


</section>


</body>
</html>