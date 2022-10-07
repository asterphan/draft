package net.asterp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import net.asterp.dao.ProductDAO;
import net.asterp.model.Product;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet("/ProductServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		maxFileSize = 1024 * 1024 * 10, // 10 MB
		maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductServlet() {
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
			if (action.equals("filterCategory")) {
				String url = "?page=shop&pagi=1";
				if (request.getParameterMap().containsKey("cate-filter")) {
					String[] ids = request.getParameterValues("cate-filter");

					for (int i = 0; i < ids.length; i++) {
						url += "&id=" + ids[i];
					}

				} else {
					url += "&id=all";
				}
				response.getWriter().print(url);
			} else if (action.equals("editProd")) {
				System.out.println("edit product");
				
				int id = Integer.parseInt(request.getParameter("prod-id"));
				String name = request.getParameter("prod-name");
				String desc = request.getParameter("prod-desc");
				int category = Integer.parseInt(request.getParameter("prod-category"));
				double price = Double.parseDouble(request.getParameter("prod-price"));
				Part filePart = request.getPart("prod-img-file");
				String fileName = filePart.getSubmittedFileName();
				System.out.println("Upload img: " + fileName);
				
				Product p = new Product();
				p.setProductId(id);
				p.setProductName(name);
				p.setDescription(desc);
				p.setCategoryId(category);
				p.setUnitPrice(price);

				response.getWriter().print(editProduct(p, filePart));
			} else if (action.equals("disableProd")) {
				int id = Integer.parseInt(request.getParameter("id"));
				
				response.getWriter().print(new ProductDAO().disableProduct(id));
			} else if (action.equals("addNewProd")) {
				System.out.println("add new product");
				String name = request.getParameter("prod-name");
				String desc = request.getParameter("prod-desc");
				int category = Integer.parseInt(request.getParameter("prod-category"));
				double price = Double.parseDouble(request.getParameter("prod-price"));
				Part filePart = request.getPart("prod-img-file");
				String fileName = filePart.getSubmittedFileName();
				System.out.println("Upload img: " + fileName);
				
				Product p = new Product();
				p.setProductName(name);
				p.setDescription(desc);
				p.setCategoryId(category);
				p.setUnitPrice(price);
				
				response.getWriter().print(new ProductDAO().insertProduct(p, filePart));
			}

		}
	}

	public boolean editProduct(Product p, Part filePart) {
		if (filePart.getSize() == 0) {
			return new ProductDAO().updateProduct(p);
		} else {
			return new ProductDAO().updateProdImg(filePart, p.getProductId());
		}
	}

}
