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
 * Servlet implementation class SignupServlet
 */
@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SignupServlet() {
		super(); 
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("signupEmail");
		String pw = request.getParameter("signupPw");
		String fn = request.getParameter("signupFn");
		String ln = request.getParameter("signupLn");
		String phone = request.getParameter("signupPhone");
		String gender = request.getParameter("signupGender");
		String role = request.getParameter("role");

		if (isExisted(email)) {
			response.getWriter().print("exist");
		} else {
			User u = new User(email, pw, fn, ln, phone, gender, role, null, null);
			String stt = signup(u);

			if (stt.equals("success")) {
				HttpSession session = request.getSession();
				session.setAttribute("email", email);
			}
			response.getWriter().print(stt);
		}
	}

	public boolean isExisted(String email) {
		User u = new UserDAO().getUser(email);

		if (u.getEmail() != null) {
			return true;
		}

		return false;
	}

	public String signup(User u) {
		UserDAO dao = new UserDAO();
		if (dao.insert(u)) {
			dao.setLastLogin(u);
			return "success";
		}

		return "fail";
	}

}
