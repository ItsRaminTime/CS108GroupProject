<link href="css/navbar.css" rel="stylesheet" type="text/css">

<%@ page import ="home.*" %>

<ul id="navbar">
	<li><a class="navbar-link" href="HomePageServlet">Home</a></li>
	<% 
		User curUser = (User)request.getSession().getAttribute("curUser");
		if (curUser == null) {
			out.println("<li><a class=\"navbar-link\" href=\"LoginServlet\">Login</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"CreateUserServlet\">Create Account</a></li>");
		} else {
			out.println("<li><a class=\"navbar-link\" href=\"LogoutServlet\">Logout</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"SetUpQuiz.jsp\">Create New Quiz</a></li>");
			out.println("<li><a class=\"navbar-link\" href=\"UserList.jsp\">Find Friends</a></li>");
			if(curUser.isAdmin) {
				out.println("<li><a class=\"navbar-link\" href=\"AdministratorPage.jsp\">Admin Page</a></li>");
			} else {
				out.println("<li><a class=\"navbar-link\" href=\"Achievements.jsp\">My Achievements</a></li>");

			}
		}
	%>
	
</ul>

<hr/>