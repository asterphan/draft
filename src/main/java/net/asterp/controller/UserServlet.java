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
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserServlet() {
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
		if (request.getParameterMap().containsKey("action")) {
			String action = request.getParameter("action");

			if (action.equals("checkSession")) {
				if (request.getSession().getAttribute("email") != null) {
					response.getWriter().print("already created");
				} else {
					response.getWriter().print("not created");
				}
			} else if (action.equals("changePw")) {
				String curPw = request.getParameter("cus-cur-pw");
				String newPw = request.getParameter("cus-new-pw");
				String email = request.getParameter("cus-email");

				String stt = updatePassword(curPw, newPw, email);
				response.getWriter().print(stt);
			} else if (action.equals("updateInfo")) {
				String email = request.getParameter("cus-email");
				String fn = request.getParameter("cus-fname");
				String ln = request.getParameter("cus-lname");
				String phone = request.getParameter("cus-phone");
				String gender = request.getParameter("cus-gender");

				String stt = updateInfo(email, fn, ln, phone, gender);
				if (stt.equals("success")) {
					User u = new UserDAO().getUser(email);
					HttpSession session = request.getSession();
					session.setAttribute("fullname", u.getFname() + " " + u.getLname());
				}

				response.getWriter().print(stt);

			} else if (action.equals("editAdInf")) {
				String email = request.getParameter("ad-email-input");
				String fn = request.getParameter("ad-fn-input");
				String ln = request.getParameter("ad-ln-input");
				String phone = request.getParameter("ad-phone-input");
				String gender = request.getParameter("ad-gender");
				
				String stt = updateInfo(email, fn, ln, phone, gender);
				if (stt.equals("success")) {
					User u = new UserDAO().getUser(email);
					HttpSession session = request.getSession();
					session.setAttribute("fullname", u.getFname() + " " + u.getLname());
				}

				response.getWriter().print(stt);
			}
		}
	}

	public String updatePassword(String curPw, String newPw, String email) {
		User u = new UserDAO().getUser(email);

		if (!u.getPassword().equals(curPw)) {
			return "wrong";
		}
		if (new UserDAO().update("Password", newPw, email)) {
			return "success";
		}
		return "fail";
	}

	public String updateInfo(String email, String fn, String ln, String phone, String gender) {
		User u = new UserDAO().getUser(email);

		if (u.getFname().equals(fn) && u.getLname().equals(ln) && u.getPhoneNo().equals(phone)
				&& u.getGender().equals(gender)) {
			return "nothing change";
		} else {
			UserDAO dao = new UserDAO();
			if (dao.update("FirstName", fn, email) && dao.update("LastName", ln, email)
					&& dao.update("PhoneNo", phone, email) && dao.update("Gender", gender, email)) {
				return "success";
			}
		}
		return "fail";
	}

}
