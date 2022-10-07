<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.dao.ProductDAO"%>
<%@page import="net.asterp.model.Product"%>
<%@page import="net.asterp.dao.CategoryDAO"%>
<%@page import="net.asterp.model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<div class="side-bar col-lg-3">
	<div class="search-hotel">
		<h3 class="agileits-sear-head">Search Here..</h3>
		<form action="#" method="post">
			<input class="form-control" type="search" name="search"
				placeholder="Search here...">
			<button class="btn1">
				<i class="fas fa-search"></i>
			</button>
			<div class="clearfix"></div>
		</form>
	</div>
	<!-- Category -->
	<div class="left-side">
		<h3 class="agileits-sear-head">Category</h3>
		<form name="category-checkbox-form">
			<ul>
				<%
				ArrayList<Integer> idList = new ArrayList<>();
				ArrayList<Category> list = new CategoryDAO().getAll();
				if (request.getParameterMap().containsKey("id") && !request.getParameter("id").equals("all")) {
					String[] ids = request.getParameterValues("id");
					if (!idList.isEmpty()) {
						idList.clear();
					}

					for (int i = 0; i < ids.length; i++) {
						idList.add(Integer.parseInt(ids[i]));
					}
				}

				if (!list.isEmpty()) {
					for (Category c : list) {
				%>
				<li>
					<div class="custom-control custom-checkbox">
						<input type="checkbox" name="cate-filter"
							class="custom-control-input cate-checkbox"
							<%if (!idList.isEmpty() && idList.contains(c.getCategoryId()))
	out.print("checked");%>
							value="<%=c.getCategoryId()%>" id="<%=c.getCategoryId()%>">
						<label for="<%=c.getCategoryId()%>" class="custom-control-label"><%=c.getCategoryName()%></label>
					</div>
				</li>
				<%
				}
				}
				%>
			</ul>
		</form>
	</div>
	<!-- deals -->
	<%
	ArrayList<Product> specialDeals = new ProductDAO().getRandomProducts(4);
	// Create a new Locale
	Locale usa = new Locale("en", "US");
	// Create a formatter given the Locale
	NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);
	%>
	<div class="deal-leftmk left-side">
		<h3 class="agileits-sear-head">Special Deals</h3>
		<%
		for (Product p : specialDeals) {
		%>
		<div class="special-sec1">
			<div class="col-xs-4 img-deals">
				<a href="?page=productDetails&pId=<%=p.getProductId()%>">
					<img src="data:image/jpg;base64,<%=p.getImgBlob()%>" alt="<%=p.getProductName()%>">
				</a>
			</div>
			<div class="col-xs-8 img-deal1">
				<h3>
					<a href="?page=productDetails&pId=<%=p.getProductId()%>"><%=p.getProductName()%></a>
				</h3>
				<a href="?page=productDetails&pId=<%=p.getProductId()%>"><%=dollarFormat.format(p.getUnitPrice())%></a>
			</div>
			<div class="clearfix"></div>
		</div>
		<%
		}
		%>
	</div>
	<!-- //deals -->
</div>
