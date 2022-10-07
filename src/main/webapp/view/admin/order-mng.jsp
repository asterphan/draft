<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String type = request.getParameter("t");
if (type.equals("all")) {
	%>
	<jsp:include page="/view/admin/order-management/order.jsp"></jsp:include>
	<%
} else if (type.equals("stt")) {
	%>
	<jsp:include page="/view/admin/order-management/order-stt.jsp"></jsp:include>
	<%
}
%>