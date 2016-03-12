<!-- Master style sheet -->
<link href="css/navbar.css" rel="stylesheet" type="text/css">

<%@ page import="home.*" %>

<ul id="navbar">
	<li><a class="navbar-link" href="HomePageServlet">Home</a></li>
	
	<%
		// Every page that includes NavBar.jsp will have access to curUser
		User curUser = (User)request.getSession().getAttribute("curUser");
		request.getSession().setAttribute("curUser", curUser);
	
		if (curUser == null) {
			out.println("<li><a class=\"navbar-link\" href=\"LoginServlet\">Login</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"CreateUserServlet\">Create User</a></li>");
		} else {
			if (curUser.isAdmin()) 
				out.println("<li><a class=\"navbar-link\" href=\"AdminPage.jsp\">Admin Portal</a></li>");	
			
			out.println("<li><a class=\"navbar-link\" href=\"UserPage.jsp?username=" + curUser.name + "\">Your Profile</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"Achievements.jsp\">Achievements</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"QuizLibrary.jsp\">Quiz Library</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"SetUpQuiz.jsp\">Create Quiz</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"MessageCenter.jsp\">Messages & Challenges</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"FriendCenter.jsp\">Friend Center</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"LogoutServlet\">Logout</a></li>");
		}
	%>	
</ul>

<hr/>