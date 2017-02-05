package negocio;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.User;
import daos.DAOFactory;
import daos.UserBeanRemote;


public class UserServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

    @EJB
    private UserBeanRemote userBean; 
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)  
			throws ServletException, IOException { 	
        
		try{
			System.out.println("UserServlet doPost...");
			response.setContentType("text/html");  
			PrintWriter out = response.getWriter();  
						
			List<User> userList = userBean.list();
	        System.out.println("La lista de usuarios es la siguiente: " + userList);
	        
	        if(userList!=null){
				HttpSession session = request.getSession(false);
					
				if(session!=null) {
					session.setAttribute("name", userList.get(2).getFirstName() + ' ' + userList.get(2).getLastName());
				}
	        	RequestDispatcher rd = request.getRequestDispatcher("users.jsp");
	        	response.sendRedirect(request.getContextPath() + "/users.jsp");
	        }
	        				
			 else{  
				out.println("<div class=\"alert alert-danger\" role=\"alert\">"
						+ "<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\">"
						+ "</span><span class=\"sr-only\">Error:</span>"
						+ " Lista de usuarios vacía</div>");
				     
				RequestDispatcher rd = request.getRequestDispatcher("users.jsp");  
				rd.include(request,response);  
			}  

			out.close();  
		} catch(Exception e) {
			System.out.println("UserServlet Exception:" + e);
		}

		
	}  
}  