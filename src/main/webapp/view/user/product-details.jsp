<%@page import="java.util.ArrayList"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.dao.ProductDAO"%>
<%@page import="net.asterp.model.Product"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
int pId = Integer.parseInt(request.getParameter("pId"));
Product p = new ProductDAO().getProductById(pId);
//Create a new Locale
Locale usa = new Locale("en", "US");
// Create a formatter given the Locale
NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);
%>
<!-- banner -->
<div class="banner_inner">
	<div class="services-breadcrumb">
		<div class="inner_breadcrumb">
			<ul class="short">
				<li>
					<a href="?page=home">Home</a>
					<i>|</i>
				</li>
				<li><%=p.getProductName()%></li>
			</ul>
		</div>
	</div>
</div>
<!--/shop-->
<section class="banner-bottom-wthreelayouts py-lg-5 py-3">
	<div class="container">
		<div class="inner-sec-shop pt-lg-4 pt-3">
			<div class="row">
				<div class="col-lg-4 single-right-left ">
					<div class="grid images_3_of_2">
						<div class="flexslider1">
							<ul class="slides">
								<li data-thumb="data:image/jpg;base64,<%=p.getImgBlob()%>">
									<div class="thumb-image">
										<img src="data:image/jpg;base64,<%=p.getImgBlob()%>" data-imagezoom="true"
											class="img-fluid" alt="<%=p.getProductName()%>">
									</div>
								</li>
							</ul>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
				<div class="col-lg-8 single-right-left simpleCart_shelfItem">
					<h3><%=p.getProductName()%></h3>
					<p>
						<span class="item_price"><%=dollarFormat.format(p.getUnitPrice())%></span>
					</p>
					<div class="description">
						<h5><%=p.getDescription()%></h5>
					</div>
					<div class="color-quality">
						<div class="color-quality-right">
							<h5>Quantity:</h5>
							<div class="input-group inline-group">
								<div class="input-group-prepend">
									<button class="btn btn-outline-secondary btn-minus">
										<i class="fa fa-minus"></i>
									</button>
								</div>
								<input class="form-control quantity" min="1" name="quantity"
									value="1" type="number">
								<div class="input-group-append">
									<button class="btn btn-outline-secondary btn-plus">
										<i class="fa fa-plus"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="occasion-cart">
						<div class="googles single-item singlepage">
							<form>
								<button type="button"
									onclick="addFromDetPage(this, <%=p.getProductId()%>)"
									class="googles-cart pgoogles-cart">Add to Cart</button>
							</form>
						</div>
					</div>
					<ul class="footer-social text-left mt-lg-4 mt-3">
						<li>Share On :</li>
						<li class="mx-2">
							<a href="#">
								<span class="fab fa-facebook-f"></span>
							</a>
						</li>
						<li class="mx-2">
							<a href="#">
								<span class="fab fa-twitter"></span>
							</a>
						</li>
						<li class="mx-2">
							<a href="#">
								<span class="fab fa-google-plus-g"></span>
							</a>
						</li>
						<li class="mx-2">
							<a href="#">
								<span class="fab fa-linkedin-in"></span>
							</a>
						</li>
						<li class="mx-2">
							<a href="#">
								<span class="fas fa-rss"></span>
							</a>
						</li>
					</ul>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<!--/slide-->
		<%
		ArrayList<Product> list = new ProductDAO().getRandomProducts(8);
		%>
		<div class="slider-img mid-sec mt-lg-5 mt-2 px-lg-5 px-3">
			<!--//banner-sec-->
			<h3 class="tittle-w3layouts text-left my-lg-4 my-3">Featured
				Products</h3>
			<div class="mid-slider">
				<div class="owl-carousel owl-theme row">
					<%
					for (Product prod : list) {
					%>
					<div class="item">
						<div class="gd-box-info text-center">
							<div class="product-men women_two bot-gd">
								<div class="product-googles-info slide-img googles">
									<div class="men-pro-item">
										<div class="men-thumb-item">
											<img src="data:image/jpg;base64,<%=prod.getImgBlob()%>" class="img-fluid"
												alt="<%=prod.getProductName()%>">
											<div class="men-cart-pro">
												<div class="inner-men-cart-pro">
													<a href="?page=productDetails&pId=<%=prod.getProductId()%>"
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
																<a href="?page=productDetails&pId=<%=prod.getProductId()%>"><%=prod.getProductName()%></a>
															</h4>
														</div>
														<div class="grid-price mt-2">
															<span class="money "><%=dollarFormat.format(prod.getUnitPrice())%></span>
														</div>
													</div>
												</div>
												<div class="googles single-item hvr-outline-out">
													<form
														action="javascript:addToCart(<%=prod.getProductId()%>, 1)"
														method="post">
														<button type="submit" class="googles-cart pgoogles-cart">
															<i class="fas fa-cart-plus"></i>
														</button>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</div>
		<!--//slider-->
	</div>
</section>