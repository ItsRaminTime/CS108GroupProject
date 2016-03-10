<!-- Master style sheet -->
<link href="css/navbar.css" rel="stylesheet" type="text/css">

<%@ page import="home.*" %>

<ul id="navbar">
	<li><a class="navbar-link" href="HomePageServlet">Home</a></li>
	
	<%
		// Every page that includes NavBar.jsp will have access to curUser
		User curUser = (User)request.getSession().getAttribute("curUser");
	
		if (curUser == null) {
			out.println("<li><a class=\"navbar-link\" href=\"LoginServlet\">Login</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"CreateUserServlet\">Create User</a></li>");
		} else {
			out.println("<li><a class=\"navbar-link\" href=\"UserPage.jsp\">Your Profile</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"SetUpQuiz.jsp\">Create Quiz</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"LogoutServlet\">Logout</a></li>");
		}
	%>	
</ul>

<hr/>