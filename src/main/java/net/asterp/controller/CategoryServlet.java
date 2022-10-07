package net.asterp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.asterp.dao.CategoryDAO;
import net.asterp.model.Category;

/**
 * Servlet implementation class CategoryServlet
 */
@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryServlet() {
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
		String action = request.getParameter("action");
		if (action.equals("add")) {
			String name = request.getParameter("category-name");
			response.getWriter().print(new CategoryDAO().insert(name));
		} else if (action.equals("edit")) {
			int id = Integer.parseInt(request.getParameter("c-id"));
			String name = request.getParameter("new-c-name");
			Category c = new Category();
			c.setCategoryId(id);
			c.setCategoryName(name);
			response.getWriter().print(new CategoryDAO().update(c));
		}
	}

}
