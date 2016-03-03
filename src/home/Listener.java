package home;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Application Lifecycle Listener implementation class Listener
 *
 */
@WebListener
public class Listener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public Listener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  {
    	ServletContext context = arg0.getServletContext();
    	
    //	Database db = new Database();
    	
        AccountManager accMan = new AccountManager(); 
     //   accMan.accounts = db.users;
        context.setAttribute("Account Manager", accMan);
         
        QuizManager quizMan = new QuizManager(); 
   //     quizMan.allQuizzes = db.quizzes;
        context.setAttribute("Quiz Manager", quizMan);
    }
	
}
