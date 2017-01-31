package negocio;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.User;
import daos.DAOFactory;
import daos.UserDAO;


public class LoginServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)  
			throws ServletException, IOException { 
		
        // Obtener DAOFactory.
        DAOFactory javabase = DAOFactory.getInstance("geoservicequality.jdbc");
        System.out.println("DAOFactory obtenido: " + javabase);

        // Obtener UserDAO.
        UserDAO userDAO = javabase.getUserDAO();
        System.out.println("UserDAO obtenido: " + userDAO);		
		
		try{
			System.out.println("LoginServlet doPost...");
			response.setContentType("text/html");  
			PrintWriter out = response.getWriter();  
			
			String userName =request.getParameter("username");  
			String userPassword =request.getParameter("userpass"); 
			
	        User foundUser = userDAO.find(userName, userPassword);
	        System.out.println("Se ha encontrado el usuario: " + foundUser);
			
	        if(foundUser!=null){
				HttpSession session = request.getSession(false);
					
				if(session!=null) {
					session.setAttribute("name", foundUser.getFirstName() + ' ' + foundUser.getLastName());
					
				}
	        	RequestDispatcher rd=request.getRequestDispatcher("welcome.jsp");
	        	response.sendRedirect(request.getContextPath() + "/welcome.jsp");
	        }
	        
	        
			//if(LoginDao.validate(n, p)){  
				//RequestDispatcher rd=request.getRequestDispatcher("welcome.jsp");  
				//rd.forward(request,response);
								
				//response.sendRedirect(request.getContextPath() + "/welcome.jsp");
				
			 else{  
				out.println("<div class=\"alert alert-danger\" role=\"alert\">"
						+ "<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\">"
						+ "</span><span class=\"sr-only\">Error:</span>"
						+ " Usuario o password incorrectos</div>");
				     
				RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
				rd.include(request,response);  
			}  

			out.close();  
		} catch(Exception e) {
			System.out.println("LoginServlet Exception:" + e);
		}

		
	}  
}  