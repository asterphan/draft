package net.asterp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.asterp.dao.UserDAO;
import net.asterp.model.User;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getParameterMap().containsKey("role")) {
			String role = request.getParameter("role");

			if (role.equals("customer")) {
				User u = new User();
				
				HttpSession session = request.getSession();
				u.setEmail(session.getAttribute("email").toString());
				new UserDAO().setLastLogout(u);
				session.invalidate();
				response.getWriter().print("logged out");
			} else if (role.equals("admin")) {
				User u = new User();
				
				HttpSession session = request.getSession();
				u.setEmail(session.getAttribute("email").toString());
				new UserDAO().setLastLogout(u);
				session.invalidate();
				response.getWriter().print("logged out");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
