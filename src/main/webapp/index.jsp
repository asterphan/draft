<%@page import="java.sql.Connection"%>
<%@page import="net.asterp.dbconnection.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>NASA Space - Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta charset="UTF-8" />
<script>
	addEventListener("load", function() {
		setTimeout(hideURLbar, 0);
	}, false);

	function hideURLbar() {
		window.scrollTo(0, 1);
	}
</script>
<link href="assets/user/css/bootstrap.css" rel="stylesheet"
	type="text/css" />
<link href="assets/user/css/login_overlay.css" rel="stylesheet"
	type="text/css" />
<link href="assets/user/css/style6.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="assets/user/css/shop.css" type="text/css" />
<link rel="stylesheet" href="assets/user/css/owl.carousel.css"
	type="text/css" media="all" />
<link rel="stylesheet" href="assets/user/css/owl.theme.css"
	type="text/css" media="all" />
<link rel="stylesheet" type="text/css"
	href="assets/user/css/jquery-ui1.css">
<link href="assets/user/css/easy-responsive-tabs.css" rel='stylesheet'
	type='text/css' />
<link rel="stylesheet" href="assets/user/css/flexslider.css"
	type="text/css" media="screen" />
<link href="assets/user/css/style.css" rel="stylesheet" type="text/css" />
<link href="assets/user/css/fontawesome-all.css" rel="stylesheet" />
<link href="//fonts.googleapis.com/css?family=Inconsolata:400,700"
	rel="stylesheet" />
<link
	href="//fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link
	href="lib/bootstrap-datepicker-master/dist/css/bootstrap-datepicker.min.css"
	rel="stylesheet">
<link
	href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css"
	rel="stylesheet">
<link href="assets/user/css/simplyCountdown.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="assets/user/css/modal.css">
<link rel="stylesheet" href="assets/user/css/customer-account.css">
<link rel="stylesheet" href="assets/user/css/checkout.css">
</head>
<body>
	<%
	Connection conn = DBConnection.createConnection();
	%>
	<div class="banner-top container-fluid" id="home">
		<!-- header -->
		<jsp:include page="view/user/header.jsp"></jsp:include>
		<!-- //header -->
	</div>
	<%
	if (request.getParameterMap().containsKey("page")) {
		String pg = request.getParameter("page");

		if (pg.equals("home")) {
	%>
	<jsp:include page="view/user/home.jsp"></jsp:include>
	<%
	} else if (pg.equals("about")) {
	%>
	<jsp:include page="view/user/about.jsp"></jsp:include>
	<%
	} else if (pg.equals("shop")) {
	%>
	<jsp:include page="view/user/shop.jsp"></jsp:include>
	<%
	} else if (pg.equals("productDetails")) {
	%>
	<jsp:include page="view/user/product-details.jsp"></jsp:include>
	<%
	} else if (pg.equals("account")) {
	%>
	<jsp:include page="view/user/customer-account.jsp"></jsp:include>
	<%
	} else if (pg.equals("cart")) {
	if (session.getAttribute("email") != null) {
	%>
	<jsp:include page="view/user/checkout.jsp"></jsp:include>
	<%
	} else {

	}
	} else if (pg.equals("checkout")) {

	}
	} else {
	%>
	<jsp:include page="view/user/home.jsp"></jsp:include>
	<%
	}
	%>
	<!--footer -->
	<jsp:include page="view/user/footer.jsp"></jsp:include>
	<!-- //footer -->
	<!--jQuery-->
	<script src="assets/user/js/jquery-2.2.3.min.js"></script>
	<!--search jQuery-->
	<script src="assets/user/js/modernizr-2.6.2.min.js"></script>
	<script src="assets/user/js/classie-search.js"></script>
	<script src="assets/user/js/demo1-search.js"></script>
	<!--//search jQuery-->
	<!-- cart-js -->
	<script src="assets/user/js/minicart.js"></script>
	<script>
		googles.render();

		googles.cart.on('googles_checkout', function(evt) {
			var items, len, i;

			if (this.subtotal() > 0) {
				items = this.items();

				for (i = 0, len = items.length; i < len; i++) {
				}
			}
		});
	</script>
	<!-- //cart-js -->
	<script>
		$(document).ready(function() {
			$(".button-log a").click(function() {
				$(".overlay-login").fadeToggle(200);
				$(this).toggleClass('btn-open').toggleClass('btn-close');
			});
		});
		$('.overlay-close1').on(
				'click',
				function() {
					$(".overlay-login").fadeToggle(200);
					$(".button-log a").toggleClass('btn-open').toggleClass(
							'btn-close');
					open = false;
				});
	</script>
	<!-- carousel -->
	<!-- price range (top products) -->
	<script src="assets/user/js/jquery-ui.js"></script>
	<script>
		//<![CDATA[ 
		$(window).load(
				function() {
					$("#slider-range").slider(
							{
								range : true,
								min : 0,
								max : 9000,
								values : [ 50, 6000 ],
								slide : function(event, ui) {
									$("#amount").val(
											"$" + ui.values[0] + " - $"
													+ ui.values[1]);
								}
							});
					$("#amount").val(
							"$" + $("#slider-range").slider("values", 0)
									+ " - $"
									+ $("#slider-range").slider("values", 1));

				}); //]]>
	</script>
	<!-- //price range (top products) -->
	<!--open and hide Signin and Signup Modal-->
	<script>
		$(document).ready(function() {
			$('#signupBtn').on("click", function() {
				$('#signinModal').modal('hide');
				$('#signupModal').modal('show');
			});
			$('#signinBtn').on("click", function() {
				$('#signupModal').modal('hide');
				$('#signinModal').modal('show');
			})
		});
	</script>
	<!-- cart-js -->
	<script src="assets/user/js/minicart.js"></script>
	<script>
		googles.render();

		googles.cart.on("googles_checkout", function(evt) {
			var items, len, i;

			if (this.subtotal() > 0) {
				items = this.items();

				for (i = 0, len = items.length; i < len; i++) {
				}
			}
		});
	</script>
	<!-- //cart-js -->
	<script>
		$(document).ready(function() {
			$(".button-log a").click(function() {
			});
		});
	</script>
	<!-- carousel -->
	<!-- Count-down -->
	<script src="assets/user/js/simplyCountdown.js"></script>
	<script>
		var d = new Date();
		simplyCountdown("simply-countdown-custom", {
			year : d.getFullYear(),
			month : d.getMonth() + 2,
			day : 25,
		});
	</script>
	<!--// Count-down -->
	<script src="assets/user/js/owl.carousel.js"></script>
	<script>
		$(document).ready(function() {
			$(".owl-carousel").owlCarousel({
				loop : true,
				margin : 10,
				responsiveClass : true,
				responsive : {
					0 : {
						items : 1,
						nav : true,
					},
					600 : {
						items : 2,
						nav : false,
					},
					900 : {
						items : 3,
						nav : false,
					},
					1000 : {
						items : 4,
						nav : true,
						loop : false,
						margin : 20,
					},
				},
			});
		});
	</script>
	<!-- //end-smooth-scrolling -->
	<!-- single -->
	<script src="assets/user/js/imagezoom.js"></script>
	<!-- single -->
	<!-- script for responsive tabs -->
	<script src="assets/user/js/easy-responsive-tabs.js"></script>
	<script>
		$(document).ready(function() {
			$('#horizontalTab').easyResponsiveTabs({
				type : 'default', //Types: default, vertical, accordion           
				width : 'auto', //auto or any width like 600px
				fit : true, // 100% fit in a container
				closed : 'accordion', // Start closed if in accordion view
				activate : function(event) { // Callback function if tab is switched
					var $tab = $(this);
					var $info = $('#tabInfo');
					var $name = $('span', $info);
					$name.text($tab.text());
					$info.show();
				}
			});
			$('#verticalTab').easyResponsiveTabs({
				type : 'vertical',
				width : 'auto',
				fit : true
			});
		});
	</script>
	<!-- FlexSlider -->
	<script src="assets/user/js/jquery.flexslider.js"></script>
	<script>
		// Can also be used with $(document).ready()
		$(window).load(function() {
			$('.flexslider1').flexslider({
				animation : "slide",
				controlNav : "thumbnails"
			});
		});
	</script>
	<!-- //FlexSlider-->
	<!-- dropdown nav -->
	<script>
		$(document).ready(function() {
			$(".dropdown").click(function() {
				$(".dropdown-menu", this).stop(true, true).slideDown("fast");
				$(this).toggleClass("open");
			}, function() {
				$(".dropdown-menu", this).stop(true, true).slideUp("fast");
				$(this).toggleClass("open");
			});
		});
	</script>
	<!-- //dropdown nav -->
	<script src="assets/user/js/move-top.js"></script>
	<script src="assets/user/js/easing.js"></script>
	<script>
		jQuery(document).ready(function($) {
			$(".scroll").click(function(event) {
				event.preventDefault();
				$("html,body").animate({
					scrollTop : $(this.hash).offset().top,
				}, 900);
			});
		});
	</script>
	<script>
		$(document).ready(function() {
			/*
			              var defaults = {
			                  containerID: 'toTop', // fading element id
			                containerHoverID: 'toTopHover', // fading element hover id
			                scrollSpeed: 1200,
			                easingType: 'linear' 
			               };
			 */

			$().UItoTop({
				easingType : "easeOutQuart",
			});
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.datepicker').datepicker({
				"format" : "M yyyy",
				"startDate" : "+1m",
				"minViewMode" : 1,
				"autoclose" : true,
				"keyboardNavigation" : false
			});
		});
	</script>
	<!--// end-smoth-scrolling -->
	<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
		integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
		crossorigin="anonymous"></script>
	<script src="https://unpkg.com/xregexp/xregexp-all.js"></script>
	<script src="assets/user/js/bootstrap.js"></script>
	<script
		src="lib/bootstrap-datepicker-master/dist/js/bootstrap-datepicker.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/cleave.js/1.6.0/cleave.min.js"
		integrity="sha512-KaIyHb30iXTXfGyI9cyKFUIRSSuekJt6/vqXtyQKhQP6ozZEGY8nOtRS6fExqE4+RbYHus2yGyYg1BrqxzV6YA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
	<script src="assets/user/js/sweetalert.min.js"></script>
	<script type="text/javascript" charset="UTF-8" src="assets/user/js/cart.js"></script>
	<script type="text/javascript" charset="UTF-8" src="assets/user/js/shop.js"></script>
	<script type="text/javascript" charset="UTF-8" src="assets/user/js/modal.js"></script>
	<script type="text/javascript" charset="UTF-8" src="assets/user/js/customer-account.js"></script>
	<script type="text/javascript" charset="UTF-8" src="assets/user/js/checkout.js"></script>
	<!-- js file -->
</body>
</html>