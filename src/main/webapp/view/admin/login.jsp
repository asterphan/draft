<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Login - NasaSpace Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" type="image/png"
	href="../../assets/admin/images/icon/favicon.ico">
<link rel="stylesheet" href="../../assets/admin/css/bootstrap.min.css">
<link rel="stylesheet"
	href="../../assets/admin/css/font-awesome.min.css">
<link rel="stylesheet" href="../../assets/admin/css/themify-icons.css">
<link rel="stylesheet" href="../../assets/admin/css/metisMenu.css">
<link rel="stylesheet"
	href="../../assets/admin/css/owl.carousel.min.css">
<link rel="stylesheet" href="../../assets/admin/css/slicknav.min.css">
<!-- amchart css -->
<link rel="stylesheet"
	href="https://www.amcharts.com/lib/3/plugins/export/export.css"
	type="text/css" media="all" />
<!-- others css -->
<!-- Start datatable css -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.18/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.jqueryui.min.css">
<link rel="stylesheet" href="../../assets/admin/css/typography.css">
<link rel="stylesheet" href="../../assets/admin/css/default-css.css">
<link rel="stylesheet" href="../../assets/admin/css/styles.css">
<link rel="stylesheet" href="../../assets/admin/css/responsive.css">
<!-- modernizr css -->
<script src="../../assets/admin/js/vendor/modernizr-2.8.3.min.js"></script>
</head>
<body>
	<!-- preloader area start -->
	<div id="preloader">
		<div class="loader"></div>
	</div>
	<!-- preloader area end -->
	<!-- login area start -->
	<div class="login-area login-s2">
		<div class="container">
			<div class="login-box ptb--100">
				<form name="ad-login-form" method="post">
					<div class="login-form-head">
						<h4>Sign In</h4>
						<p>
							Hello there, Sign in and start managing your <span>NasaSpace</span>
						</p>
					</div>
					<div class="login-form-body">
						<input type="hidden" name="signinRole" value="Admin">
						<div class="form-gp">
							<label for="signinEmail">Email address</label>
							<input type="email" name="signinEmail" id="signinEmail" required>
							<i class="ti-email"></i>
						</div>
						<div class="form-gp">
							<label for="signinPassword">Password</label>
							<input type="password" name="signinPassword" id="signinPassword"
								required>
							<i class="ti-lock"></i>
						</div>
						<div class="row mb-4 rmber-area">
							<div class="col-12 text-right">
								<a href="#">Forgot Password?</a>
							</div>
						</div>
						<div class="submit-btn-area">
							<button id="ad_login_submit" type="button">
								Submit <i class="ti-arrow-right"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- login area end -->
	<!--jQuery-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- Start datatable js -->
	<script
		src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/plug-ins/1.12.1/api/fnFilterClear.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.18/js/dataTables.bootstrap4.min.js"></script>
	<script
		src="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js"></script>
	<script
		src="https://cdn.datatables.net/responsive/2.2.3/js/responsive.bootstrap.min.js"></script>
	<!--Plugin JavaScript file-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.1/js/ion.rangeSlider.min.js"></script>
	<!-- bootstrap 4 js -->
	<script src="../../assets/admin/js/popper.min.js"></script>
	<script src="../../assets/admin/js/bootstrap.min.js"></script>
	<script src="../../assets/admin/js/owl.carousel.min.js"></script>
	<script src="../../assets/admin/js/metisMenu.min.js"></script>
	<script src="../../assets/admin/js/jquery.slimscroll.min.js"></script>
	<script src="../../assets/admin/js/jquery.slicknav.min.js"></script>
	<!-- others plugins -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="https://unpkg.com/xregexp/xregexp-all.js"></script>
	<script src="../../assets/admin/js/plugins.js"></script>
	<script src="../../assets/admin/js/scripts.js"></script>
</body>
</html>