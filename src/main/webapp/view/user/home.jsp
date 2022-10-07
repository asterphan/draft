<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<div class="banner-top container-fluid" id="home">

	<!-- banner -->
	<jsp:include page="home/banner.jsp"></jsp:include>

</div>
<!--//banner-sec-->
<section class="banner-bottom-wthreelayouts py-lg-5 py-3">
	<div class="container-fluid">
		<div class="inner-sec-shop px-lg-4 px-3">

			<jsp:include page="home/new-arrivals.jsp"></jsp:include>
			<!--//row-->

			<!--/meddle-->
			<jsp:include page="home/summer-flashsale.jsp"></jsp:include>
			<!--//meddle-->

			<!--/slide-->
			<jsp:include page="home/product-slide.jsp"></jsp:include>

			<!-- /testimonials -->
			<jsp:include page="home/testimonials.jsp"></jsp:include>
			<!-- //testimonials -->

			<jsp:include page="home/editor-pick.jsp"></jsp:include>

			<!-- /grids -->
			<jsp:include page="home/grids.jsp"></jsp:include>
			<!-- //grids -->

			<!-- /clients-sec -->
			<jsp:include page="home/clients-sec.jsp"></jsp:include>
			<!-- //clients-sec -->

		</div>
	</div>
</section>
<!-- about -->