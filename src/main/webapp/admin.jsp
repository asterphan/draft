<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!doctype html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>NasaSpace Store - Administrator</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" type="image/png"
	href="assets/admin/images/icon/favicon.ico">
<link rel="stylesheet" href="assets/admin/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/admin/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/admin/css/themify-icons.css">
<link rel="stylesheet" href="assets/admin/css/metisMenu.css">
<link rel="stylesheet" href="assets/admin/css/owl.carousel.min.css">
<link rel="stylesheet" href="assets/admin/css/slicknav.min.css">
<!-- amchart css -->
<link rel="stylesheet"
	href="https://www.amcharts.com/lib/3/plugins/export/export.css"
	type="text/css" media="all" />
<!-- Start datatable css -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.18/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.jqueryui.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
	integrity="sha512-wJgJNTBBkLit7ymC6vvzM1EcSWeM9mmOu+1USHaRBbHkm6W9EgM0HY27+UtUaprntaYQJF75rc8gjxllKs5OIQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!--Plugin CSS file with desired skin-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.1/css/ion.rangeSlider.min.css" />
<!-- others css -->
<link rel="stylesheet" href="assets/admin/css/typography.css">
<link rel="stylesheet" href="assets/admin/css/default-css.css">
<link rel="stylesheet" href="assets/admin/css/styles.css">
<link rel="stylesheet" href="assets/admin/css/responsive.css">
<link
	href="lib/bootstrap-datepicker-master/dist/css/bootstrap-datepicker.css"
	rel="stylesheet">
<!-- modernizr css -->
<script src="assets/admin/js/vendor/modernizr-2.8.3.min.js"></script>
</head>
<body>
	<%
	if (session.getAttribute("email") == null) {
		response.sendRedirect(request.getContextPath() + "/view/admin/login.jsp");
	} else {
	%>
	<!-- preloader area start -->
	<div id="preloader">
		<div class="loader"></div>
	</div>
	<!-- preloader area end -->
	<!-- page container area start -->
	<div class="page-container">
		<!-- sidebar menu area start -->
		<jsp:include page="view/admin/side-menu.jsp"></jsp:include>
		<!-- sidebar menu area end -->
		<!-- main content area start -->
		<div class="main-content">
			<!-- header area start -->
			<jsp:include page="view/admin/header.jsp"></jsp:include>
			<!-- header area end -->
			<!-- page title area start -->
			<jsp:include page="view/admin/page-title.jsp"></jsp:include>
			<!-- page title area end -->
			<div class="main-content-inner">
				<!-- MAIN CONTENT GOES HERE -->
				<%
				if (request.getParameterMap().containsKey("page")) {
					String pg = request.getParameter("page");
					switch (pg) {
						case "userMng" :
				%>
				<jsp:include page="view/admin/user-mng.jsp"></jsp:include>
				<%
				break;
				case "cusDetail" :
				%>
				<jsp:include
					page="view/admin/user-management/customers/cus-detail.jsp"></jsp:include>
				<%
				break;
				case "ordD" :
				%>
				<jsp:include page="view/admin/ord-detail.jsp"></jsp:include>
				<%
				break;
				case "adDetail" :
				%>
				<jsp:include page="view/admin/user-management/admin/ad-detail.jsp"></jsp:include>
				<%
				break;
				case "prodMng" :
				%>
				<jsp:include page="view/admin/prod-mng.jsp"></jsp:include>
				<%
				break;
				case "ordMng" :
				%>
				<jsp:include page="view/admin/order-mng.jsp"></jsp:include>
				<%
				break;
				}
				} else {
				%>
				<jsp:include page="view/admin/dashboard.jsp"></jsp:include>
				<%
				}
				%>
			</div>
		</div>
		<!-- main content area end -->
		<!-- footer area start-->
		<jsp:include page="view/admin/footer.jsp"></jsp:include>
		<!-- footer area end-->
	</div>
	<!-- page container area end -->
	<!-- offset area start -->
	<div class="offset-area">
		<div class="offset-close">
			<i class="ti-close"></i>
		</div>
		<ul class="nav offset-menu-tab">
			<li>
				<a class="active" data-toggle="tab" href="#activity">Activity</a>
			</li>
			<li>
				<a data-toggle="tab" href="#settings">Settings</a>
			</li>
		</ul>
		<div class="offset-content tab-content">
			<div id="activity" class="tab-pane fade in show active">
				<div class="recent-activity">
					<div class="timeline-task">
						<div class="icon bg1">
							<i class="fa fa-envelope"></i>
						</div>
						<div class="tm-title">
							<h4>Rashed sent you an email</h4>
							<span class="time"><i class="ti-time"></i>09:35</span>
						</div>
						<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
							Esse distinctio itaque at.</p>
					</div>
					<div class="timeline-task">
						<div class="icon bg2">
							<i class="fa fa-check"></i>
						</div>
						<div class="tm-title">
							<h4>Added</h4>
							<span class="time"><i class="ti-time"></i>7 Minutes Ago</span>
						</div>
						<p>Lorem ipsum dolor sit amet consectetur.</p>
					</div>
					<div class="timeline-task">
						<div class="icon bg2">
							<i class="fa fa-exclamation-triangle"></i>
						</div>
						<div class="tm-title">
							<h4>You missed you Password!</h4>
							<span class="time"><i class="ti-time"></i>09:20 Am</span>
						</div>
					</div>
					<div class="timeline-task">
						<div class="icon bg3">
							<i class="fa fa-bomb"></i>
						</div>
						<div class="tm-title">
							<h4>Member waiting for you Attention</h4>
							<span class="time"><i class="ti-time"></i>09:35</span>
						</div>
						<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
							Esse distinctio itaque at.</p>
					</div>
				</div>
			</div>
			<div id="settings" class="tab-pane fade">
				<div class="offset-settings">
					<h4>General Settings</h4>
					<div class="settings-list">
						<div class="s-settings">
							<div class="s-sw-title">
								<h5>Notifications</h5>
								<div class="s-swtich">
									<input type="checkbox" id="switch1" />
									<label for="switch1">Toggle</label>
								</div>
							</div>
							<p>Keep it 'On' When you want to get all the notification.</p>
						</div>
						<div class="s-settings">
							<div class="s-sw-title">
								<h5>Show recent activity</h5>
								<div class="s-swtich">
									<input type="checkbox" id="switch2" />
									<label for="switch2">Toggle</label>
								</div>
							</div>
							<p>The for attribute is necessary to bind our custom checkbox
								with the input.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- offset area end -->
	<%
}
%>
	<!-- jquery latest version -->
	<!--jQuery-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://malsup.github.io/jquery.form.js"></script>
	<script
		src="lib/bootstrap-datepicker-master/dist/js/bootstrap-datepicker.min.js"></script>
	<!--Plugin JavaScript file-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.1/js/ion.rangeSlider.min.js"></script>
	<!-- bootstrap 4 js -->
	<script src="assets/admin/js/popper.min.js"></script>
	<script src="assets/admin/js/bootstrap.min.js"></script>
	<script src="assets/admin/js/owl.carousel.min.js"></script>
	<script src="assets/admin/js/metisMenu.min.js"></script>
	<script src="assets/admin/js/jquery.slimscroll.min.js"></script>
	<script src="assets/admin/js/jquery.slicknav.min.js"></script>
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
	<!-- others plugins -->
	<!-- start chart js -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
	<!-- start highcharts js -->
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<!-- start zingchart js -->
	<script src="https://cdn.zingchart.com/zingchart.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"
		integrity="sha512-zlWWyZq71UMApAjih4WkaRpikgY9Bz1oXIW5G0fED4vk14JjGlQ1UmkGM392jEULP8jbNMiwLWdM8Z87Hu88Fw=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
		zingchart.MODULESDIR = "https://cdn.zingchart.com/modules/";
		ZC.LICENSE = [ "569d52cefae586f634c54f86dc99e6a9",
				"ee6b7db5b51705a13dc2339db3edaf6d" ];
	</script>
	<!-- all line chart activation -->
	<script src="assets/admin/js/line-chart.js"></script>
	<!-- all pie chart -->
	<script src="assets/admin/js/pie-chart.js"></script>
	<!-- others plugins -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="https://unpkg.com/xregexp/xregexp-all.js"></script>
	<script src="assets/admin/js/plugins.js"></script>
	<script src="assets/admin/js/scripts.js"></script>
</body>
</html>
