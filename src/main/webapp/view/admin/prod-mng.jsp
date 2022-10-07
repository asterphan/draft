<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String type = request.getParameter("t");
if (type.equals("pl")) {
	%>
	<jsp:include page="/view/admin/product-management/prod-list.jsp"></jsp:include>
	<%
} else if (type.equals("pd")) {
	%>
	<jsp:include page="/view/admin/product-management/prod-det.jsp"></jsp:include>
	<%
} else if (type.equals("add")) {
	%>
	<jsp:include page="/view/admin/product-management/add-prod.jsp"></jsp:include>
	<%
} else if (type.equals("c")) {
	%>
	<jsp:include page="/view/admin/product-management/categories.jsp"></jsp:include>
	<%
}
%>