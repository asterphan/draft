package net.asterp.controller;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import net.asterp.dao.ShoppingCart;
import net.asterp.dao.UserDAO;
import net.asterp.model.User;

/**
 * Application Lifecycle Listener implementation class SessionListener
 *
 */
@WebListener
public class SessionListener implements HttpSessionBindingListener {

	/**
	 * Default constructor.
	 */
	public SessionListener() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpSessionBindingListener#valueBound(HttpSessionBindingEvent)
	 */
	public void valueBound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		System.out.println("-- HttpSessionBindingListener#valueBound() --");
		System.out.printf("added attribute name: %s, value:%s %n", event.getName(), event.getValue());
	}

	/**
	 * @see HttpSessionBindingListener#valueUnbound(HttpSessionBindingEvent)
	 */
	public void valueUnbound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		System.out.println("-- HttpSessionBindingEvent#valueUnbound() --");
		System.out.printf("removed attribute name: %s, value:%s %n", event.getName(), event.getValue());
		if (event.getName().equals("userCart")) {
			HttpSession session = event.getSession();
			String email = (String) session.getServletContext().getAttribute("email");
			/* System.out.println(email); */
			ShoppingCart cart = (ShoppingCart) session.getServletContext().getAttribute("cart");
			if (cart.countItem() != 0) {
				System.out.println(cart.storeCartInDb(email));
			} else {
				System.out.println("empty cart");
			}
			User u = new User();
			u.setEmail(session.getAttribute("email").toString());
			new UserDAO().setLastLogout(u);
			session.invalidate();
			System.out.println("logged out");
		}
	}

}
