<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String p = "";
if (request.getParameterMap().containsKey("page")) {
	p = request.getParameter("page");
}
%>
<div class="sidebar-menu">
	<div class="sidebar-header">
		<div class="logo">
			<a href="#">
				<img src="assets/admin/images/icon/logo.png" alt="logo">
			</a>
		</div>
	</div>
	<div class="main-menu">
		<div class="menu-inner">
			<nav>
				<ul class="metismenu" id="menu">
					<li
						<%if (!request.getParameterMap().containsKey("page"))
	out.print("class=\"active\"");%>>
						<a href="?page=dashboard" aria-expanded="false">
							<i class="ti-dashboard"></i><span>Dashboard</span>
						</a>
					</li>
					<li
						<%if (request.getParameterMap().containsKey("page") && ((request.getParameter("page").equals("userMng")
		|| request.getParameter("page").equals("cusDetail") || request.getParameter("page").equals("adDetail"))
		|| (request.getParameterMap().containsKey("prev") && request.getParameter("prev").equals("cd"))))
	out.print("class=\"active\"");%>>
						<a href="javascript:void(0)" aria-expanded="true">
							<i class="ti-user"></i><span>Users</span>
						</a>
						<ul class="collapse">
							<li
								<%if (request.getParameterMap().containsKey("page")
		&& ((request.getParameter("page").equals("userMng") && request.getParameter("r").equals("c"))
				|| request.getParameter("page").equals("cusDetail") || (request.getParameterMap().containsKey("prev") && request.getParameter("prev").equals("cd"))))
	out.print("class=\"active\"");%>>
								<a href="?page=userMng&r=c">Customers</a>
							</li>
							<li
								<%if (request.getParameterMap().containsKey("page")
		&& ((request.getParameter("page").equals("userMng") && request.getParameter("r").equals("a"))
				|| request.getParameter("page").equals("adDetail")))
	out.print("class=\"active\"");%>>
								<a href="?page=userMng&r=a">Administrators</a>
							</li>
						</ul>
					</li>
					<li
						<%if (request.getParameterMap().containsKey("page") && request.getParameter("page").equals("prodMng"))
	out.print("class=\"active\"");%>>
						<a href="javascript:void(0)" aria-expanded="false">
							<i class="ti-layout-list-large-image"></i><span>Products</span>
						</a>
						<ul class="collapse">
							<li
								<%if (request.getParameterMap().containsKey("page") && request.getParameter("page").equals("prodMng")
		&& (request.getParameter("t").equals("pl") || request.getParameter("t").equals("add")))
	out.print("class=\"active\"");%>>
								<a href="javascript:void(0)" aria-expanded="false">Product
									list</a>
								<ul class="collapse">
									<li
										<%if (request.getParameterMap().containsKey("page") && request.getParameter("page").equals("prodMng")
		&& (request.getParameter("t").equals("pl") || request.getParameter("t").equals("pd")))
	out.print("class=\"active\"");%>>
										<a href="?page=prodMng&t=pl">Product list</a>
									</li>
									<li
										<%if (request.getParameterMap().containsKey("page") && request.getParameter("page").equals("prodMng")
		&& request.getParameter("t").equals("add"))
	out.print("class=\"active\"");%>>
										<a href="?page=prodMng&t=add">Add new product</a>
									</li>
								</ul>
							</li>
							<li
								<%if (request.getParameterMap().containsKey("page") && request.getParameter("page").equals("prodMng")
		&& request.getParameter("t").equals("c"))
	out.print("class=\"active\"");%>>
								<a href="?page=prodMng&t=c">Categories</a>
							</li>
						</ul>
					</li>
					<li
						<%if (request.getParameterMap().containsKey("page") && (request.getParameter("page").equals("ordMng") || request.getParameter("prev").equals("ol")))
	out.print("class=\"active\"");%>>
						<a href="javascript:void(0)" aria-expanded="false">
							<i class="ti-shopping-cart-full"></i> <span>Orders</span>
						</a>
						<ul class="collapse">
							<li
								<%if (request.getParameterMap().containsKey("page") && (request.getParameter("page").equals("ordMng")
		&& request.getParameter("t").equals("all") || (request.getParameter("page").equals("ordMng") || request.getParameter("prev").equals("ol"))))
	out.print("class=\"active\"");%>>
								<a href="?page=ordMng&t=all">All orders</a>
							</li>
							<li
								<%if (request.getParameterMap().containsKey("page") && request.getParameter("page").equals("ordMng")
		&& request.getParameter("t").equals("stt"))
	out.print("class=\"active\"");%>>
								<a href="?page=ordMng&t=stt">Order status</a>
							</li>
						</ul>
					</li>
				</ul>
			</nav>
		</div>
	</div>
</div>