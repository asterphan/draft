package net.asterp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.asterp.dao.AddressDAO;
import net.asterp.model.Address;

/**
 * Servlet implementation class AddressServlet
 */
@WebServlet("/AddressServlet")
public class AddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddressServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if (session.getAttribute("email") != null) {
			if (request.getParameterMap().containsKey("action")) {
				String action = request.getParameter("action");
				String email = session.getAttribute("email").toString();
				if (action.equals("unsetDefault")) {
					int id = Integer.parseInt(request.getParameter("id"));
					Address a = new Address();
					a.setAddrId(id);
					a.setDefault(false);
					response.getWriter().print(new AddressDAO().updateDefault(a));
				} else if (action.equals("setDefault")) {
					int id = Integer.parseInt(request.getParameter("id"));
					Address a = new AddressDAO().searchDefault(email);
					if (a != null) {
						response.getWriter().print("have one");
					} else {
						a = new Address();
						a.setAddrId(id);
						a.setDefault(true);
						response.getWriter().print(new AddressDAO().updateDefault(a));
					}
				} else if (action.equals("changeDefault")) {
					int id = Integer.parseInt(request.getParameter("id"));
					Address a = new Address();
					a.setAddrId(id);
					a.setDefault(true);
					response.getWriter().print(new AddressDAO().changeDefault(email, a));
				} else if (action.equals("checkDefault")) {
					int id = Integer.parseInt(request.getParameter("id"));
					Address a = new Address();
					a.setAddrId(id);
					response.getWriter().print(new AddressDAO().isDefault(a));
				} else if (action.equals("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					Address a = new Address();
					a.setAddrId(id);
					a.setStatus("Disabled");
					response.getWriter().print(new AddressDAO().updateStatus(a));
				} else if (action.equals("getAddr")) {
					int id = Integer.parseInt(request.getParameter("id"));
					response.setCharacterEncoding("UTF-8");
					response.getWriter().print(getAddrById(id));
				}
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if (session.getAttribute("email") != null) {
			if (request.getParameterMap().containsKey("action")) {
				String action = request.getParameter("action");

				if (action.equals("add")) {
					String email = session.getAttribute("email").toString();
					String fn = request.getParameter("fn").trim();
					String ln = request.getParameter("ln").trim();
					String phone = request.getParameter("phone").trim();
					String prov = request.getParameter("prov").trim();
					String dist = request.getParameter("dist").trim();
					String ward = request.getParameter("ward").trim();
					String detail = request.getParameter("detail").trim();

					Address a = new Address();
					a.setEmail(email);
					a.setFirstName(fn);
					a.setLastName(ln);
					a.setPhone(phone);
					a.setProvince(prov);
					a.setDistrict(dist);
					a.setWard(ward);
					a.setDetail(detail);

					AddressDAO dao = new AddressDAO();

					response.getWriter().print(dao.insert(a));
				} else if (action.equals("edit")) {
					int id = Integer.parseInt(request.getParameter("id"));
					String fn = request.getParameter("fn").trim();
					String ln = request.getParameter("ln").trim();
					String phone = request.getParameter("phone").trim();
					String prov = request.getParameter("prov").trim();
					String dist = request.getParameter("dist").trim();
					String ward = request.getParameter("ward").trim();
					String detail = request.getParameter("detail").trim();

					Address a = new Address();
					a.setAddrId(id);
					a.setFirstName(fn);
					a.setLastName(ln);
					a.setPhone(phone);
					a.setProvince(prov);
					a.setDistrict(dist);
					a.setWard(ward);
					a.setDetail(detail);

					AddressDAO dao = new AddressDAO();

					response.getWriter().print(dao.update(a));
				}
			}
		}
		
	}
	
	public String getAddrById(int id) {
		String json = "";
		Address a = new AddressDAO().getAddrById(id);
		if (a != null) {
			json = "{\"id\":" + a.getAddrId() + ",\"fn\":\"" + a.getFirstName() + "\",\"ln\":\"" + a.getLastName()
					+ "\",\"fullname\":\"" + a.getFullname() + "\",\"phone\":\"" + a.getPhone() + "\",\"country\":\""
					+ a.getCountry() + "\",\"prov\":\"" + a.getProvince() + "\",\"dist\":\"" + a.getDistrict()
					+ "\",\"ward\":\"" + a.getWard() + "\",\"detail\":\"" + a.getDetail() + "\"}";
			System.out.println(a.getDetail());
			return json;
		}
		return null;
	}

}
