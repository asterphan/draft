<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.dao.ProductDAO"%>
<%@page import="net.asterp.model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
ArrayList<Product> list = new ArrayList<>();
ArrayList<Integer> categoryIds = new ArrayList<>();

int records = 0;
final int recordsPerPage = 16;
int numberOfPages = 0;

if (request.getParameterMap().containsKey("id")) {
	int pagi = Integer.parseInt(request.getParameter("pagi"));

	boolean isSpecificIds = false;

	if (request.getParameter("id").equals("all")) {
		isSpecificIds = false;
		records = new ProductDAO().countAllProducts();
		numberOfPages = (records / 16) + 1;
	} else {
		isSpecificIds = true;
		String[] cList = request.getParameterValues("id");
		categoryIds = new ArrayList<Integer>();

		for (int i = 0; i < cList.length; i++) {
	categoryIds.add(Integer.parseInt(cList[i]));
		}

		for (Integer id : categoryIds) {
	records += new ProductDAO().countProductsByCategoryId(id);
		}
	}

	numberOfPages = (records / 16) + 1;

	if (records > 16) {

		if (pagi != 1) {
	pagi = pagi - 1;
	pagi = pagi * recordsPerPage + 1;
		}

	}

	if (isSpecificIds) {
		list = new ProductDAO().getRecordsPerPageByIds(pagi, recordsPerPage, categoryIds);
	} else {
		list = new ProductDAO().getRecordsPerPage(pagi, recordsPerPage);
	}
}
%>
<div class="left-ads-display col-lg-9">
	<div class="wrapper_top_shop">
		<div class="row">
			<%
			// Create a new Locale
			Locale usa = new Locale("en", "US");
			// Create a formatter given the Locale
			NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);

			for (Product p : list) {
			%>
			<div class="col-md-3 product-men women_two shop-gd">
				<div class="product-googles-info googles">
					<div class="men-pro-item">
						<div class="men-thumb-item">
							<img src="data:image/jpg;base64,<%=p.getImgBlob()%>" class="img-fluid" alt="">
							<div class="men-cart-pro">
								<div class="inner-men-cart-pro">
									<a href="?page=productDetails&pId=<%=p.getProductId()%>"
										class="link-product-add-cart">Quick View</a>
								</div>
							</div>
							<span class="product-new-top">New</span>
						</div>
						<div class="item-info-product">
							<div class="info-product-price">
								<div class="grid_meta">
									<div class="product_price">
										<div class="product_desc">
											<h4>
												<a href="?page=productDetails&pId=<%=p.getProductId()%>"><%=p.getProductName()%></a>
											</h4>
										</div>
										<div class="grid-price mt-2">
											<span class="money "><%=dollarFormat.format(p.getUnitPrice())%></span>
										</div>
									</div>
								</div>
								<div class="googles single-item hvr-outline-out">
									<form action="javascript:addToCart(<%=p.getProductId()%>, 1)"
										method="post">
										<button type="submit" class="googles-cart pgoogles-cart">
											<i class="fas fa-cart-plus"></i>
										</button>
									</form>
								</div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<%
		String url = "?page=shop";

		if (request.getParameter("id").equals("all")) {
			url += "&id=all";
		} else {
			for (Integer id : categoryIds) {
				url += "&id=" + id;
			}
		}
		%>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-end">
				<li class="page-item">
					<a class="page-link" href="<%=url + "&pagi=" + (Integer.parseInt(request.getParameter("pagi")) - 1)%>" aria-label="Previous"
						<%if (Integer.parseInt(request.getParameter("pagi")) == 1)
	out.print("hidden");%>>
						<span aria-hidden="true">&laquo;</span> <span class="sr-only">Previous</span>
					</a>
				</li>
				<%
				for (int i = 1; i <= numberOfPages; i++) {
				%>
				<li
					class="page-item <%if (request.getParameterMap().containsKey("pagi") && Integer.parseInt(request.getParameter("pagi")) == i) {
	out.print("active");
}%>">
					<a class="page-link" href="<%=url%>&pagi=<%=i%>"><%=i%></a>
				</li>
				<%
				}
				%>
				<li class="page-item">
					<a class="page-link" href="<%=url + "&pagi=" + (Integer.parseInt(request.getParameter("pagi")) + 1)%>" aria-label="Next"
						<%if (Integer.parseInt(request.getParameter("pagi")) == numberOfPages)
	out.print("hidden");%>>
						<span aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span>
					</a>
				</li>
			</ul>
		</nav>
	</div>
</div>
