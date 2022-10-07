<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<div class="col-9 right-view">
	<%
	if (request.getParameterMap().containsKey("sc")) {
		String sc = request.getParameter("sc");

		if (sc.equals("info")) {
	%>
	<jsp:include page="customer-info.jsp"></jsp:include>
	<%
	} else if (sc.equals("addr")) {
	%>
	<jsp:include page="shipment.jsp"></jsp:include>
	<%
	} else if (sc.equals("orders")) {
	%>
	<jsp:include page="order.jsp"></jsp:include>
	<%
	}
	} else {
	%>
	<jsp:include page="customer-info.jsp"></jsp:include>
	<%
	}
	%>
</div>