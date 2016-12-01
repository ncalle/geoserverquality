package negocio;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexionDatos.RegistroDao;


public class RegistroServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)  
			throws ServletException, IOException { 
		try{
			System.out.println("RegistroServlet doPost...");
			response.setContentType("text/html");  
			PrintWriter out = response.getWriter();  
			
			String n=request.getParameter("username");  
			String p=request.getParameter("userpass"); 
			
			HttpSession session = request.getSession(false);
			if(session!=null)
			session.setAttribute("name", n);

			if(RegistroDao.validate(n, p)){  
				RequestDispatcher rd=request.getRequestDispatcher("welcome.jsp");  
				rd.forward(request,response);  
			} else{  
				
				out.println("<div class=\"alert alert-danger\" role=\"alert\">"
						+ "<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\">"
						+ "</span><span class=\"sr-only\">Error:</span>"
						+ " Error al registrar al usuario</div>");
				
				RequestDispatcher rd=request.getRequestDispatcher("registro.jsp");  
				rd.include(request,response);  
			}  

			out.close();  
		} catch(Exception e) {
			System.out.println("RegistroServlet Exception:" + e);
			//e.printStackTrace();
		}

		
	}  
}  