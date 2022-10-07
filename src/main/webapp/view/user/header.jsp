<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.model.CartItem"%>
<%@page import="net.asterp.dao.ShoppingCart"%>
<%@page import="net.asterp.dao.ProductDAO"%>
<%@page import="net.asterp.model.Product"%>
<%@page import="net.asterp.dao.CategoryDAO"%>
<%@page import="net.asterp.model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<header>
	<div class="row">
		<div class="col-md-3 top-info text-left mt-lg-4">
			<h6>Need Help</h6>
			<ul>
				<li>
					<i class="fas fa-phone"></i> Call
				</li>
				<li class="number-phone mt-3">12345678099</li>
			</ul>
		</div>
		<div class="col-md-6 logo-w3layouts text-center">
			<h1 class="logo-w3layouts">
				<a class="navbar-brand" href="?page=home">
					<img src="assets/user/images/icons8-planet-80.png" alt="" />
					NASA SPACE
				</a>
			</h1>
		</div>
		<div class="col-md-3 top-info-cart text-right mt-lg-4">
			<ul class="cart-inner-info">
				<li class="button-log" style="cursor: pointer;">
					<div class="dropdown show">
						<a class="btn btn-open customer-account dropdown-toggle"
							role="button" id="dropdownMenuLink" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false">
							<span id="fullname"> <%
 if (session.getAttribute("fullname") != null)
 	out.print(session.getAttribute("fullname"));
 %>
							</span> <span class="fa fa-user" aria-hidden="true"></span>
						</a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="dropdownMenuLink">
							<%
							if (session.getAttribute("email") != null) {
							%>
							<a class="dropdown-item" href="?page=account">My Account</a>
							<a class="dropdown-item" href="?page=account&sc=orders">My
								Orders</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="javascript:logout()">Logout</a>
							<%
							} else {
							%>
							<a class="dropdown-item" data-toggle="modal"
								data-target="#signinModal">Login</a>
							<a class="dropdown-item" data-toggle="modal"
								data-target="#signupModal">Register</a>
							<%
							}
							%>
						</div>
					</div>
				</li>
				<li class="galssescart galssescart2 cart cart box_1">
					<div class="dropdown">
						<button type="button" class="btn btn-dark top_googles_cart"
							data-toggle="dropdown" id="dropdownCart">
							<i class="fas fa-cart-arrow-down"></i> <span
								class="badge badge-pill badge-dark"> <%
 if (session.getAttribute("countCart") != null)
 	out.print(session.getAttribute("countCart"));
 else
 	out.print(0);
 %>
							</span>
						</button>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="dropdownCart" id="ddcart-content">
							<div class="card">
								<%
								if (session.getAttribute("email") == null) {
								%>
								<div class="card-body" id="ddcart-content-body">Login to
									see your cart</div>
								<%
								} else {
								if (session.getAttribute("countCart") == null) {
								%>
								<div class="card-body" id="ddcart-content-body">Your cart
									is empty</div>
								<%
								} else {
								ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
								if (cart != null) {
									ArrayList<CartItem> cartList = cart.getCartList();
									// Create a new Locale
									Locale usa = new Locale("en", "US");
									// Create a formatter given the Locale
									NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);
								%>
								<div class="card-body" id="ddcart-content-body">
									<%
									for (CartItem item : cartList) {
									%>
									<div class="row">
										<div class="col-2">
											<a href="?page=productDetails&pId=<%=item.getProductId()%>">
												<img alt="<%=item.getProductName()%>"
													src="data:image/jpg;base64,<%=item.getImgBlob()%>">
											</a>
										</div>
										<div class="col-6">
											<a href="?page=productDetails&pId=<%=item.getProductId()%>"><%=item.getProductName()%></a>
											<div>
												<%=dollarFormat.format(item.getUnitPrice())%>
											</div>
										</div>
										<div class="col-3 ddcart-qty">
											<div class="number-input">
												<button class="btn-minus minus"></button>
												<input type="hidden" value="<%=item.getProductId()%>"
													name="qty-prod-id" />
												<input class="quantity" min="1" name="quantity"
													value="<%=item.getQuantity()%>" type="number" readonly>
												<button class="btn-plus plus"></button>
											</div>
										</div>
										<div class="col-1">
											<button class="btn btn-light ddcart-remove">
												<i class="material-icons">close</i>
											</button>
										</div>
									</div>
									<%
									}
									%>
								</div>
								<div class="card-footer">
									<p id="estimate-total-price">
										Sub total: <span id="total-price"><%=dollarFormat.format(cart.totalPrice())%></span>
									</p>
									<div class="row">
										<div class="col">
											<a href="?page=cart#cart" class="btn btn-dark viewCart">View
												cart</a>
										</div>
										<div class="col">
											<a href="?page=cart#checkout" class="btn btn-dark checkout">Checkout</a>
										</div>
									</div>
								</div>
								<%
								}

								}
								}
								%>
							</div>
						</div>
					</div>
				</li>
			</ul>
			<!---->
			<!------------------------------- SIGN IN MODAL --------------------------------------->
			<!-- The Modal -->
			<div class="modal fade" id="signinModal">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">
								<img src="assets/user/images/hello.png" alt="astronaut hello">
								Let's Login
							</h4>
							<button type="button" class="close" data-dismiss="modal">
								&times;</button>
						</div>
						<!-- Modal body -->
						<div class="modal-body text-left">
							<form action="javascript:onSubmitLogin()" method="post"
								name="signinModal">
								<input type="hidden" name="signinRole" value="Customer" />
								<div class="form-group">
									<label for="signinEmail">Email address</label>
									<input type="email" name="signinEmail" id="signinEmail"
										class="form-control" placeholder="Email address"
										autofocus="autofocus" required />
								</div>
								<div class="form-group">
									<label for="signinPassword">Password</label>
									<input type="password" name="signinPassword"
										id="signinPassword" class="form-control"
										placeholder="Password" pattern=".{6,}"
										title="6 characters minimum" required />
								</div>
								<div class="form-group custom-control custom-checkbox">
									<input type="checkbox" class="custom-control-input" id="showPw"
										name="showPw" onclick="showPassword()">
									<label class="custom-control-label" for="showPw">Show
										password</label>
									<span class="forgot-pw"><a href="#">Forgot password?</a></span>
								</div>
								<div class="text-center">
									<input type="submit" value="Login" class="btn btn-default"
										id="submitLogin" />
								</div>
							</form>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<div>
								<p>
									Don't have an account?
									<a href="#signupModal" data-toggle="modal"
										data-target="#signupModal" id="signupBtn">&nbsp;Register</a>
								</p>
							</div>
							<div class="admin-login-option">
								<a href="view/admin/login.jsp" id="loginAsAdmin">Login as
									Administrator</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!---->
			<!------------------------------- SIGN UP MODAL --------------------------------------->
			<!-- The Modal -->
			<div class="modal fade" id="signupModal">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">
								<img src="assets/user/images/hello.png" alt="astronaut hello">
								Register
							</h4>
							<button type="button" class="close" data-dismiss="modal">
								&times;</button>
						</div>
						<!-- Modal body -->
						<div class="modal-body text-left">
							<form action="javascript:onSubmitRegister()" name="register-form">
								<div class="form-group">
									<label for="signupEmail">Email address</label>
									<input type="email" name="signupEmail" id="signupEmail"
										class="form-control" placeholder="Email address" required />
									<div class="err-msg">
										<span id="signup-email-msg"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="signupPw">Password</label>
									<input type="password" name="signupPw" id="signupPw"
										class="form-control" placeholder="Password" required
										pattern=".{6,}" title="6 characters minimum" />
								</div>
								<div class="form-group row">
									<div class="col">
										<label for="signupFn">First name</label>
										<input type="text" name="signupFn" id="signupFn"
											class="form-control" placeholder="First name" required />
										<div class="err-msg">
											<span id="signup-fn-msg"></span>
										</div>
									</div>
									<div class="col">
										<label for="signupLn">Last name</label>
										<input type="text" name="signupLn" id="signupLn"
											class="form-control" placeholder="Last name" required />
										<div class="err-msg">
											<span id="signup-ln-msg"></span>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="signupPhone">Phone number</label>
									<input type="tel" name="signupPhone" id="signupPhone"
										class="form-control" placeholder="Phone number" required />
									<div class="err-msg">
										<span id="signup-phone-msg"></span>
									</div>
								</div>
								<div class="form-group" style="margin-bottom: 0;">
									<label for="signupGender">Gender:</label>
								</div>
								<div class="form-group">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio"
											name="signupGender" id="signUpGd_male" value="male" checked>
										<label class="form-check-label" for="signUpGd_male">Male</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio"
											name="signupGender" id="signUpGd_female" value="female">
										<label class="form-check-label" for="signUpGd_male">Female</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio"
											name="signupGender" id="signUpGd_other" value="other">
										<label class="form-check-label" for="signUpGd_male">Other</label>
									</div>
								</div>
								<div class="text-center">
									<input type="submit" value="Submit" class="btn btn-default" />
								</div>
							</form>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<div>
								<p>
									Already have an account?
									<a href="#signinModal" data-toggle="modal"
										data-target="#signinModal" id="signinBtn">&nbsp;Login</a>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!---->
		</div>
	</div>
	<div class="search">
		<div class="mobile-nav-button">
			<button id="trigger-overlay" type="button">
				<i class="fas fa-search"></i>
			</button>
		</div>
		<!-- open/close -->
		<div class="overlay overlay-door">
			<button type="button" class="overlay-close">
				<i class="fa fa-times" aria-hidden="true"></i>
			</button>
			<form action="#" method="post" class="d-flex">
				<input class="form-control" type="search"
					placeholder="Search here..." required />
				<button type="submit" class="btn btn-primary submit">
					<i class="fas fa-search"></i>
				</button>
			</form>
		</div>
		<!-- open/close -->
	</div>
	<label class="top-log mx-auto"></label>
	<nav
		class="navbar navbar-expand-lg navbar-light bg-light top-header mb-2">
		<button class="navbar-toggler mx-auto" type="button"
			data-toggle="collapse" data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"> </span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav nav-mega mx-auto">
				<li class="nav-item button-log" style="cursor: pointer;">
					<div class="dropdown show">
						<a class="nav-link btn btn-open customer-account dropdown-toggle"
							href="#" role="button" id="dropdownMenuLink"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
							style="color: #000;">
							<span class="fa fa-user" aria-hidden="true"></span> <span
								id="fullname"> <%
 if (session.getAttribute("fullname") != null)
 	out.print(session.getAttribute("fullname"));
 %>
							</span>
						</a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="dropdownMenuLink">
							<%
							if (session.getAttribute("email") != null) {
							%>
							<a class="dropdown-item" href="?page=account">My Account</a>
							<a class="dropdown-item" href="?page=account&sc=orders">My
								Orders</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="javascript:logout()">Logout</a>
							<%
							} else {
							%>
							<a class="dropdown-item" data-toggle="modal"
								data-target="#signinModal">Login</a>
							<a class="dropdown-item" data-toggle="modal"
								data-target="#signupModal">Register</a>
							<%
							}
							%>
						</div>
					</div>
				</li>
				<li
					class="nav-item <%if ((request.getParameterMap().containsKey("page") && request.getParameter("page").equals("home"))
		|| !request.getParameterMap().containsKey("page")) {
	out.print("active");
}%>">
					<a class="nav-link ml-lg-0" href="?page=home">
						Home <span class="sr-only">(current)</span>
					</a>
				</li>
				<li
					class="nav-item <%if (request.getParameterMap().containsKey("page") && request.getParameter("page").equals("about")) {
	out.print("active");
}%>">
					<a class="nav-link" href="?page=about">About</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> Features </a>
					<ul class="dropdown-menu mega-menu">
						<li>
							<div class="row">
								<div class="col-md-4 media-list span4 text-left">
									<h5 class="tittle-w3layouts-sub">Product Type</h5>
									<ul>
										<li class="media-mini mt-3">
											<a href="?page=shop&pagi=1&id=all">All products</a>
										</li>
										<%
										ArrayList<Category> list = new CategoryDAO().getAll();

										if (!list.isEmpty()) {
											for (Category c : list) {
										%>
										<li>
											<a href="?page=shop&pagi=1&id=<%=c.getCategoryId()%>"><%=c.getCategoryName()%></a>
										</li>
										<%
										}
										}
										%>
										<li class="mt-3">
											<h5>View more pages</h5>
										</li>
										<li class="mt-2">
											<a href="?page=about">About</a>
										</li>
										<li>
											<a href="?page=account">My Account</a>
										</li>
									</ul>
								</div>
								<%
								ArrayList<Product> rndList = new ProductDAO().getRandomProducts(2);
								if (!rndList.isEmpty()) {
									for (Product p : rndList) {
								%>
								<div class="col-md-4 media-list span4 text-left">
									<h5 class="tittle-w3layouts-sub">Special Item</h5>
									<div class="media-mini mt-3">
										<a href="?page=productDetails&pId=<%=p.getProductId()%>">
											<img src="data:image/jpg;base64,<%=p.getImgBlob()%>"
												class="img-fluid" alt="<%=p.getProductName()%>" />
										</a>
									</div>
								</div>
								<%
								}
								}
								%>
							</div>
							<hr />
						</li>
					</ul>
				</li>
				<li
					class="nav-item dropdown <%if (request.getParameterMap().containsKey("page") && request.getParameter("page").equals("shop")) {
	out.print("active");
}%>">
					<a class="nav-link dropdown-toggle" href="?page=shop"
						id="navbarDropdown1" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> Shop </a>
					<ul class="dropdown-menu mega-menu">
						<li>
							<div class="row">
								<div class="col-md-4 media-list span4 text-left">
									<h5 class="tittle-w3layouts-sub">Accessories</h5>
									<ul>
										<li class="media-mini mt-3">
											<a href="?page=shop&pagi=1&id=all">All Products</a>
										</li>
										<%
										if (!list.isEmpty()) {
											for (Category c : list) {
										%>
										<li>
											<a href="?page=shop&pagi=1&id=<%=c.getCategoryId()%>"><%=c.getCategoryName()%></a>
										</li>
										<%
										}
										}
										%>
									</ul>
								</div>
								<%
								ArrayList<Product> rnd2List = new ProductDAO().getRandomProducts(2);
								if (!rnd2List.isEmpty()) {
									for (Product p : rnd2List) {
								%>
								<div class="col-md-4 media-list span4 text-left">
									<h5 class="tittle-w3layouts-sub-nav">Special Product</h5>
									<div class="media-mini mt-3">
										<a href="?page=productDetails&pId=<%=p.getProductId()%>">
											<img src="data:image/jpg;base64,<%=p.getImgBlob()%>"
												class="img-fluid" alt="<%=p.getProductName()%>">
										</a>
									</div>
								</div>
								<%
								}
								}
								%>
							</div>
							<hr />
						</li>
					</ul>
				</li>
				<li
					class="nav-item <%if (request.getParameterMap().containsKey("page") && request.getParameter("page").equals("account")) {
	out.print("active");
}%>">
					<a class="nav-link" href="?page=account">My account</a>
				</li>
			</ul>
		</div>
	</nav>
</header>