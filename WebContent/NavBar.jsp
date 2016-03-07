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
		}
	%>
	
</ul>

<hr/>