package net.asterp.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.asterp.dao.ShoppingCart;
import net.asterp.dao.UserDAO;
import net.asterp.model.CartItem;
import net.asterp.model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("signinEmail");
		String password = request.getParameter("signinPassword");
		String role = request.getParameter("signinRole");

		String resp = login(email, password, role);

		String json = null;

		if (resp == null) {
			json = "{\"message\": \"does not exist\"}";
		} else if (resp.equals("wrong password")) {
			json = "{\"message\": \"wrong password\"}";
		} else if (resp.equals("disabled")) {
			json = "{\"message\": \"disabled\"}";
		} else if (resp.equals("wrong role")) {
			json = "{\"message\": \"wrong role\"}";
		} else {
			HttpSession session = request.getSession();

			session.getServletContext().setAttribute("email", email);
			session.setAttribute("email", email);
			session.setAttribute("fullname", resp);
			if (role.equals("Admin")) {
				
			} else {
				ShoppingCart cart = new ShoppingCart();
				ArrayList<CartItem> cartList = cart.loadCartFromDb(email);
				cart.setCartList(cartList);
				session.getServletContext().setAttribute("cart", cart);
				session.setAttribute("cart", cart);
				session.setAttribute("countCart", cart.countItem());
				SessionListener userCart = new SessionListener();
				session.setAttribute("userCart", userCart);
			}
			
			json = "{\"email\": \"" + email + "\", \"fullname\": \"" + resp + "\", \"role\": \"" + role
					+ "\", \"message\": \"success\"}";
		}

		response.getWriter().println(json);
	}
	
	public String login(String email, String password, String role) {
		User u = new UserDAO().getUser(email);

		if (u == null) {
			return null;
		} else {
			if (!u.getPassword().equals(password)) {
				return "wrong password";
			} else if (u.getRole().equals("N/A")) {
				return "disabled";
			} else if (!u.getRole().equals(role)) {
				return "wrong role";
			}
		}
		new UserDAO().setLastLogin(u);
		return u.getFname() + " " + u.getLname();
	}

}
