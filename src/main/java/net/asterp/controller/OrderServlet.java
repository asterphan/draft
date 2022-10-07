package net.asterp.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.asterp.dao.OrderDAO;
import net.asterp.dao.OrderDetailDAO;
import net.asterp.dao.OrderViewDAO;
import net.asterp.dao.ProductDAO;
import net.asterp.dao.ShoppingCart;
import net.asterp.model.CartItem;
import net.asterp.model.Order;
import net.asterp.model.OrderDetail;
import net.asterp.model.OrderView;
import net.asterp.model.Product;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if (session != null) {
			
		}
		String email = session.getAttribute("email").toString();
		if (email != null) {
			if (request.getParameterMap().containsKey("action")) {
				String action = request.getParameter("action");

				switch (action) {
				case "getOrderDetail": {
					int id = Integer.parseInt(request.getParameter("id"));
					response.getWriter().print(getJsonOrder(id));
					break;
				}
				case "cancelOrder": {
					int id = Integer.parseInt(request.getParameter("id"));
					response.getWriter().print(new OrderDAO().cancel(id));
					break;
				}
				case "createOrder": {
					int addrId = Integer.parseInt(request.getParameter("addrId"));
					int paymentId = Integer.parseInt(request.getParameter("paymentId"));
					ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
					Order o = new Order();
					o.setEmail(email);
					o.setAddressId(addrId);
					o.setPaymentType(paymentId);
					o.setNote("");
					boolean stt = createOrder(o, cart);
					if (stt) {
						cart.clearCart();
					}
					response.getWriter().print(stt);
					break;
				}
				case "updateOrdStt": {
					int orderId = Integer.parseInt(request.getParameter("ordId"));
					int sttId = Integer.parseInt(request.getParameter("selectOrdStt"));
					response.getWriter().print(new OrderDAO().updateStatus(orderId, sttId));
					break;
				}
				default:
					throw new IllegalArgumentException("Unexpected value: " + action);
				}
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
	
	public String getJsonOrder(int id) {
		ArrayList<OrderView> list = new OrderViewDAO().getAllById(id);
		String json = "";
		if (!list.isEmpty()) {
			json += "[";
			for (int i = 0; i < list.size(); i++) {
				Product p = new ProductDAO().getProductById(list.get(i).getProductId());
				json += "{\"orderId\":" + list.get(i).getOrderId() + ",\"addressId\":" + list.get(i).getAddressId()
						+ ",\"orderDate\":\"" + list.get(i).getOrderDate() + "\",\"payment\":"
						+ list.get(i).getPaymentType() + ",\"status\":" + list.get(i).getStatusId() + ",\"note\":\""
						+ list.get(i).getNote() + "\",\"product\":\"" + p.getProductName() + "\", \"price\":"
						+ list.get(i).getUnitPrice() + ",\"img\":\"" + p.getImgBlob() + "\",\"qty\":"
						+ list.get(i).getQty() + "}";
				if (i != list.size() - 1) {
					json += ",";
				}
			}
			json += "]";
			return json;
		}
		return null;
	}

	public boolean createOrder(Order o, ShoppingCart cart) {
		ArrayList<CartItem> items = cart.getCartList();

		OrderDAO dao = new OrderDAO();

		if (dao.insert(o)) {
			int orderId = dao.getLastId();
			ArrayList<OrderDetail> list = new ArrayList<OrderDetail>();
			for (CartItem item : items) {
				OrderDetail od = new OrderDetail();
				od.setOrderId(orderId);
				od.setProductId(item.getProductId());
				od.setUnitPrice(item.getUnitPrice());
				od.setQuantity(item.getQuantity());

				list.add(od);
			}

			return new OrderDetailDAO().insert(list);
		}

		return false;
	}

}
