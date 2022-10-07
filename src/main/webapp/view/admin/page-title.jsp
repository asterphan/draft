<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<div class="page-title-area">
	<div class="row align-items-center">
		<div class="col-sm-6">
			<div class="breadcrumbs-area clearfix">
				<h4 class="page-title pull-left">
					<%
					if (request.getParameterMap().containsKey("page")) {
						String p = request.getParameter("page");
						if (p.equals("userMng")) {
							String r = request.getParameter("r");
							if (r.equals("c")){
								out.print("Customers");
							} else if (r.equals("a")) {
								out.print("Administrators");
							}
						} else if (p.equals("cusDetail")) {
							out.print("Customer Details");
						} else if (p.equals("ordD")) {
							out.print("Order Details");
						} else if (p.equals("adDetail")) {
							out.print("Your Profile");
						} else if (p.equals("dashboard")) {
							out.print("Dashboard");
						} else if (p.equals("prodMng")) {
							String t = request.getParameter("t");
							if (t.equals("pl")) {
								out.print("Product List");
							} else if (t.equals("pd")) {
								out.print("Product Details");
							} else if (t.equals("add")) {
								out.print("Add New Product");
							} else if (t.equals("c")) {
								out.print("Categories");
							}
						} else if (p.equals("ordMng")) {
							String t = request.getParameter("t");
							if (t.equals("all")) {
								out.print("All Orders");
							} else if (t.equals("stt")) {
								out.print("Order Status");
							}
						}
					} else {
						out.print("Dashboard");
					}
					%>
				</h4>
				<ul class="breadcrumbs pull-left">
					<li>
						<a href="?page=dashboard">Home</a>
					</li>
					<%
					if (request.getParameterMap().containsKey("page")) {
						String p = request.getParameter("page");
						if (p.equals("userMng")) {
							String r = request.getParameter("r");
							if (r.equals("c")) {
								%>
								<li>
									<span>Customers</span>
								</li>
								<%
							} else if (r.equals("a")) {
								%>
								<li>
									<span>Administrators</span>
								</li>
								<%
							}
						} else if (p.equals("cusDetail")) {
							%>
							<li>
								<a href="?page=userMng&r=c">Customers</a>
							</li>
							<li>
								<span>Details</span>
							</li>
							<%
						} else if (p.equals("ordD")) {
							String prevUrl = request.getParameter("prev");
							String email = request.getParameter("e");
							if (prevUrl.equals("cd")) {
								%>
								<li>
									<a href="?page=userMng&r=c">Customers</a>
								</li>
								<li>
									<a href="?page=cusDetail&e=<%=email%>">Details</a>
								</li>
								<li>
									<span>Order details</span>
								</li>
								<%
							} else if (prevUrl.equals("ol")) {
								%>
								<li>
									<a href="?page=ordMng&t=all">All orders</a>
								</li>
								<li>
									<span>Order details</span>
								</li>
								<%
							}
						} else if (p.equals("adDetail")) {
							String email = request.getParameter("e");
							%>
							<li>
								<a href="?page=userMng&r=a">Administrators</a>
							</li>
							<li>
								<span>Your profile</span>
							</li>
							<%
						} else if (p.equals("dashboard")) {
							%>
							<li>
								<span>Dashboard</span>
							</li>
							<%
						} else if (p.equals("prodMng")) {
							String t = request.getParameter("t");
							if (t.equals("pl")) {
								%>
								<li>
									<span>Product List</span>
								</li>
								<%
							} else if (t.equals("pd")) {
								%>
								<li>
									<a href="?page=prodMng&t=pl">Product List</a>
								</li>
								<li>
									<span>Details</span>
								</li>
								<%
							} else if (t.equals("add")) {
								%>
								<li>
									<span>Add new product</span>
								</li>
								<%
							} else if (t.equals("c")) {
								%>
								<li>
									<span>Categories</span>
								</li>
								<%
							}
						} else if (p.equals("ordMng")) {
							String t = request.getParameter("t");
							if (t.equals("all")) {
								%>
								<li>
									<span>All orders</span>
								</li>
								<%
							} else if (t.equals("stt")) {
								%>
								<li>
									<span>Order status</span>
								</li>
								<%
							}
						}
					} else {
						%>
						<li>
							<span>Dashboard</span>
						</li>
						<%
					}
					%>
				</ul>
			</div>
		</div>
		<div class="col-sm-6 clearfix">
			<div class="user-profile pull-right">
				<img class="avatar user-thumb"
					src="assets/admin/images/author/avatar.png" alt="avatar">
				<h4 class="user-name dropdown-toggle" data-toggle="dropdown">
					<%=session.getAttribute("fullname").toString() %>
					<i class="fa fa-angle-down"></i>
				</h4>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="#">Message</a>
					<a class="dropdown-item" href="#">Settings</a>
					<a class="dropdown-item" href="javascript:adLogout()">Log Out</a>
				</div>
			</div>
		</div>
	</div>
</div>