package home;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Application Lifecycle Listener implementation class Listener
 *
 */
@WebListener
public class Listener implements HttpSessionListener, ServletContextListener  {

    /**
     * Default constructor. 
     */
    public Listener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  {
    	ServletContext context = arg0.getServletContext();
    	Database db = new Database();
        context.setAttribute("db", db);
        context.setAttribute("um", new UserManager(db));
        context.setAttribute("qm", new QuizManager(db));
        context.setAttribute("am", new AnnouncementManager(db));
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0)  { 
    	ServletContext context = arg0.getServletContext();
        Database db = (Database) context.getAttribute("db");
        db.close();
    }
    
	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
    	HttpSession session = arg0.getSession();
    	session.setAttribute("curUser", null);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
    	arg0.getSession().invalidate();
	}
	
}
