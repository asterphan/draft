<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!-- banner -->
<jsp:include page="shop/banner.jsp"></jsp:include>
<!--//banner -->
<!--/shop-->
<section class="banner-bottom-wthreelayouts py-lg-5 py-3">
	<div class="container-fluid">
		<div class="inner-sec-shop px-lg-4 px-3">
			<h3 class="tittle-w3layouts my-lg-4 mt-3">New Arrivals for you</h3>
			<div class="row">
				<!-- product left -->
				<jsp:include page="shop/sidebar.jsp"></jsp:include>
				<!-- //product left -->
				<!--/product right-->
				<jsp:include page="shop/new-arrivals.jsp"></jsp:include>
				<!--//product right-->
			</div>
			<!--/slide-->
			<div class="slider-img mid-sec mt-lg-5 mt-2">
				<!--//banner-sec-->
				<h3 class="tittle-w3layouts text-left my-lg-4 my-3">Featured
					Products</h3>
					<jsp:include page="shop/featured-products.jsp"></jsp:include>
			</div>
			<!--//slider-->
		</div>
	</div>
</section>