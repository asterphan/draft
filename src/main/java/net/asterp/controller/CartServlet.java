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
import net.asterp.model.CartItem;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartServlet() {
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
		String action = request.getParameter("action");

		HttpSession session = request.getSession();
		if (session.getAttribute("email") == null) {
			response.getWriter().print("please login");
		} else {
			ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
			if (action.equals("addToCart")) {
				int id = Integer.parseInt(request.getParameter("id"));
				int qty = Integer.parseInt(request.getParameter("qty"));
				cart.addToCart(id, qty);
				session.setAttribute("countCart", cart.countItem());
				session.setAttribute("cart", cart);
				session.getServletContext().setAttribute("cart", cart);

				response.getWriter().print(cart.countItem());
			} else if (action.equals("viewCart")) {
				session.setAttribute("countCart", cart.countItem());
				response.getWriter().print(viewCart(cart));
			} else if (action.equals("changeQty")) {
				int id = Integer.parseInt(request.getParameter("id"));
				int qty = Integer.parseInt(request.getParameter("qty"));
				cart.changeQty(id, qty);
				session.setAttribute("cart", cart);
				session.getServletContext().setAttribute("cart", cart);
				session.setAttribute("countCart", cart.countItem());
			} else if (action.equals("remove")) {
				int id = Integer.parseInt(request.getParameter("id"));
				cart.removeItem(id);
				session.setAttribute("cart", cart);
				session.getServletContext().setAttribute("cart", cart);
				session.setAttribute("countCart", cart.countItem());
				response.getWriter().print(cart.countItem());
			}
		}
	}

	public String viewCart(ShoppingCart cart) {
		ArrayList<CartItem> cartList = cart.getCartList();
		String json = null;

		if (cartList.size() != 0) {
			json = "[";
			for (int i = 0; i < cartList.size(); i++) {
				json += "{\"id\": " + cartList.get(i).getProductId() + ",\"name\":\"" + cartList.get(i).getProductName()
						+ "\",\"img\":\"" + cartList.get(i).getImgBlob() + "\",\"price\":"
						+ cartList.get(i).getUnitPrice() + ",\"qty\":" + cartList.get(i).getQuantity() + "}";
				if (i != cartList.size() - 1) {
					json += ",";
				}
			}
			json += "]";
		} else {
			json = "empty";
		}

		return json;
	}

}
