<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String role = request.getParameter("r");
if (role.equals("c")) {
	%>
	<jsp:include page="user-management/customers/cus-mng.jsp"></jsp:include>
	<%
} else {
	%>
	<jsp:include page="user-management/admin/ad-mng.jsp"></jsp:include>
	<%
}
%>