<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<div class="col-3 left-menu">
	<ul class="nav nav-pills nav-justified flex-column">
		<li class="nav-item">
			<a
				class="nav-link 
			<%if ((request.getParameterMap().containsKey("sc") && request.getParameter("sc").equals("info"))
		|| !request.getParameterMap().containsKey("sc")) {
	out.print("active");
}%>"
				href="?page=account&sc=info">
				<span><i class="fas fa-user"></i></span> My Account
			</a>
		</li>
		<li class="nav-item">
			<a
				class="nav-link 
			<%if (request.getParameterMap().containsKey("sc") && request.getParameter("sc").equals("addr")) {
	out.print("active");
}%>"
				href="?page=account&sc=addr&p=1">
				<span><i class="fas fa-location-arrow"></i></span> My Address
			</a>
		</li>
		<li class="nav-item">
			<a
				class="nav-link 
			<%if (request.getParameterMap().containsKey("sc") && request.getParameter("sc").equals("orders")) {
	out.print("active");
}%>"
				href="?page=account&sc=orders">
				<span><i class="fas fa-shopping-basket"></i></span> My Orders
			</a>
		</li>
	</ul>
</div>