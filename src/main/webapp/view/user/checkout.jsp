<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="checkout/banner.jsp"></jsp:include>
<div class="container checkout-pg">
	<%
	if (session.getAttribute("email") != null) {
	%>
	<jsp:include page="checkout/menu.jsp"></jsp:include>
	<%
	} else {
	response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/"));
	}
	%>
</div>
