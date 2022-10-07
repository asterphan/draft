<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.dao.ProductDAO"%>
<%@page import="net.asterp.model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
ArrayList<Product> newArrivals = new ProductDAO().getLatestProducts(8);
//Create a new Locale
Locale usa = new Locale("en", "US");
// Create a formatter given the Locale
NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);
%>
<h3 class="tittle-w3layouts my-lg-4 my-4">New Arrivals for you</h3>
<div class="row">
	<!-- /womens -->
	<%
	for (Product p : newArrivals) {
	%>
	<div class="col-md-3 product-men women_two">
		<div class="product-googles-info googles">
			<div class="men-pro-item">
				<div class="men-thumb-item">
					<img src="data:image/jpg;base64,<%=p.getImgBlob()%>" class="img-fluid"
						alt="<%=p.getProductName()%>" />
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
									<span class="money"><%=dollarFormat.format(p.getUnitPrice())%></span>
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
<!-- //womens -->
