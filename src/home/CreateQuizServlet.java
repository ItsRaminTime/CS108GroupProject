package home;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class CreateQuizServlet
 */
@WebServlet("/CreateQuizServlet")
public class CreateQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateQuizServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = (String) request.getSession().getAttribute("name");
		HttpSession session = request.getSession();
        User curUser = (User) session.getAttribute("curUser");
		Quiz quiz = new Quiz(name, curUser.name);
		request.getSession().setAttribute("quiz", quiz);
		
		int numQuestions = (Integer) request.getSession().getAttribute("numQuestions");
		request.getSession().setAttribute("numQuestions", numQuestions);
		
		List<String> types = new ArrayList<String>();
		
		for (int i = 0; i < numQuestions; i++) {
			String curType = request.getParameter("questionType" + i);
			types.add(curType);
		}
		
		request.getSession().setAttribute("types", types);
		RequestDispatcher dispatcher = request.getRequestDispatcher("CreateQuiz.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		QuizManager qm = (QuizManager) this.getServletContext().getAttribute("qm");
		UserManager um = (UserManager) this.getServletContext().getAttribute("um");
		HttpSession session = request.getSession();
        User curUser = (User) session.getAttribute("curUser");
		
		Quiz quiz = (Quiz) request.getSession().getAttribute("quiz");
		int numQuestions = (Integer) request.getSession().getAttribute("numQuestions");
		List<String> types = (ArrayList<String>) request.getSession().getAttribute("types");
		
		for (int i = 0; i < numQuestions; i++) {
			if (types.get(i).equals("response")) {
				String curQuestion = request.getParameter("question" + i);
				String curAnswer = request.getParameter("answer" + i);
				quiz.addQuestion(new ResponseQuestion(curQuestion, curAnswer));
			} else if (types.get(i).equals("fillblank")) {
				String curQuestion = request.getParameter("question" + i);
				String curAnswer = request.getParameter("answer" + i);
				quiz.addQuestion(new FillBlankQuestion(curQuestion, curAnswer));
			} else if (types.get(i).equals("truefalse")) {
				String curQuestion = request.getParameter("question" + i);
				String curAnswer = request.getParameter("answer" + i);
				quiz.addQuestion(new TrueFalseQuestion(curQuestion, curAnswer));
			} else if (types.get(i).equals("multchoice")) {
				String curQuestion = request.getParameter("question" + i);
				String curAnswer = request.getParameter("answer" + i);
				List<String> options = new ArrayList<String>();
				
				options.add(request.getParameter("optiona" + i));
				options.add(request.getParameter("optionb" + i));
				options.add(request.getParameter("optionc" + i));
				options.add(request.getParameter("optiond" + i));
			
				if (!options.contains(curAnswer))
					curAnswer = options.get(0);
				
				quiz.addQuestion(new MultipleChoiceQuestion(curQuestion, curAnswer, options));
			} else if (types.get(i).equals("pic")) {
				String curQuestion = request.getParameter("question" + i);              
			                 String root = request.getContextPath() + "/uploads";            
			                File uploadedFile = new File(root + "/" + curQuestion);         
				        String curAnswer = request.getParameter("answer" + i);                  
				         curQuestion = "<img src=\"" + curQuestion + "\">";                      
				   quiz.addQuestion(new PictureQuestion(curQuestion, curAnswer)); 
			}
		}
		
		qm.addQuizToDb(quiz);
		curUser.numQuizzesCreated++;
		curUser.quizzesCreated.add(new QuizCreated(quiz));
		um.updateUserInDb(curUser);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("QuizWelcome.jsp?id=" + quiz.id);
		dispatcher.forward(request, response);
	}

}
