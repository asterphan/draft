<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<jsp:include page="view-account/banner.jsp"></jsp:include>
<%
System.out.println(session.getId());
if (session.getAttribute("email") == null) {
%>
<div class="account-warning">
	<img src="assets/user/images/astronaut1.png" alt="astronaut1"
		class="mx-auto d-block rounded-circle" />
	<div class="message">
		<h3>You're not logged in yet</h3>
		<p>Please login to view this page</p>
		<div class="btns">
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#signinModal">Login</button>
			<br> or <br>
			<a href="?page=shop&pagi=1&id=all">
				Continue shopping <i class="fas fa-arrow-right"></i>
			</a>
		</div>
		<p>
			Don't have an account?<span><a style="cursor: pointer;"
					data-toggle="modal" data-target="#signupModal"> Register</a></span>
		</p>
	</div>
</div>
<%
} else {
%>
<section class="customer-account">
	<div class="container-fluid">
		<h2>My Account</h2>
		<div class="row container-row">
			<jsp:include page="view-account/left-menu.jsp"></jsp:include>
			<jsp:include page="view-account/right-view.jsp"></jsp:include>
		</div>
	</div>
</section>
<%
}
%>