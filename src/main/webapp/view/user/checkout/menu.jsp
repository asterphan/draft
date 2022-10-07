<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<ul class="nav nav-pills nav-fill" id="pills-tab" role="tablist">
	<li class="nav-item">
		<a class="nav-link" id="pills-cart-tab" data-toggle="pill"
			href="#pills-cart" role="tab" aria-controls="pills-cart"
			style="pointer-events: none;">Cart</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" id="pills-checkout-tab" data-toggle="pill"
			href="#pills-checkout" role="tab" aria-controls="pills-checkout"
			aria-selected="true" style="pointer-events: none;">Checkout</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" id="pills-summary-tab" data-toggle="pill"
			href="#pills-summary" role="tab" aria-controls="pills-summary"
			aria-selected="false" style="pointer-events: none;">Summary</a>
	</li>
</ul>
<div class="tab-content" id="pills-tabContent">
	<div class="tab-pane fade" id="pills-cart" role="tabpanel"
		aria-labelledby="pills-cart-tab">
		<jsp:include page="cart-sec.jsp"></jsp:include>
	</div>
	<div class="tab-pane fade" id="pills-checkout" role="tabpanel"
		aria-labelledby="pills-checkout-tab"><jsp:include
			page="checkout-sec.jsp"></jsp:include></div>
	<div class="tab-pane fade" id="pills-summary" role="tabpanel"
		aria-labelledby="pills-summary-tab">
		<jsp:include page="summary-sec.jsp"></jsp:include>
	</div>
</div>