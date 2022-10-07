<%@page import="net.asterp.dao.PaymentTypeDAO"%>
<%@page import="net.asterp.model.PaymentType"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="net.asterp.dao.OrderStatusDAO"%>
<%@page import="net.asterp.model.OrderStatus"%>
<%@page import="net.asterp.dao.OrderDAO"%>
<%@page import="net.asterp.model.Order"%>
<%@page import="net.asterp.dao.AddressDAO"%>
<%@page import="net.asterp.model.Address"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.dao.ProductDAO"%>
<%@page import="net.asterp.model.Product"%>
<%@page import="net.asterp.model.OrderView"%>
<%@page import="net.asterp.dao.OrderViewDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%
String email = request.getParameter("e");
String prevUrl = request.getParameter("prev");
int orderId = Integer.parseInt(request.getParameter("id"));

ArrayList<OrderView> list = new OrderViewDAO().getAllById(orderId);
Order o = new OrderDAO().getById(orderId);
Address a = new AddressDAO().getAddrById(o.getAddressId());
double subtotal = new OrderViewDAO().getTotalPriceById(orderId);
OrderStatus status = new OrderStatusDAO().getById(o.getStatusId());
ArrayList<OrderStatus> sttList = new OrderStatusDAO().getAll();
PaymentType type = new PaymentTypeDAO().getById(o.getPaymentType());

String badgeClass = "";
switch (status.getStatusId()) {
case 1:
	badgeClass = "badge-danger";
	break;
case 2:
	badgeClass = "badge-info";
	break;
case 3:
	badgeClass = "badge-warning";
	break;
case 4:
	badgeClass = "badge-success";
	break;
case 5:
	badgeClass = "badge-dark";
	break;
}

//Create a new Locale
Locale usa = new Locale("en", "US");
//Create a formatter given the Locale
NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
%>
<div class="cd-back mt-3 mb-3">
	<a href="<% if (prevUrl.equals("cd")) out.print("?page=cusDetail&e=" + email); else out.print("?page=ordMng&t=all"); %>">
		<i class="fa fa-angle-left"></i>Back
	</a>
</div>
<div class="row ord-d">
	<div class="col-8">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">General information</h4>
				<table id="ord-d-g">
					<tr>
						<th>Order ID</th>
						<td><%=o.getOrderId()%></td>
						<th>Payment type</th>
						<td><%=type.getTypeName()%></td>
					</tr>
					<tr>
						<th>Order date</th>
						<td><%=formatter.format(o.getOrderDate())%></td>
						<th>Note</th>
						<td><% if (o.getNote().isBlank()) out.print("N/A"); else out.print(o.getNote()); %></td>
					</tr>
				</table>
				<h4 class="header-title">Order items</h4>
				<div class="data-tables datatable-dark">
					<table id="dataTable-ordD-ord" class="text-center table-hover">
						<thead>
							<tr>
								<th>No.</th>
								<th>Image</th>
								<th>Item name</th>
								<th>Price</th>
								<th>Quantity</th>
								<th>Total</th>
							</tr>
						</thead>
						<tbody>
							<%
							int no = 1;
							for (OrderView item : list) {
								double totalPrice = item.getUnitPrice() * item.getQty();
								Product p = new ProductDAO().getProductById(item.getProductId());
							%>
							<tr>
								<td><%=no++%></td>
								<td>
									<img alt="<%=p.getProductName()%>"
										src="data:image/jpg;base64,<%=p.getImgBlob()%>" width="80">
								</td>
								<td class="text-left"><%=p.getProductName()%></td>
								<td><%=dollarFormat.format(item.getUnitPrice())%></td>
								<td><%=item.getQty()%></td>
								<td><%=dollarFormat.format(totalPrice)%></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="col-4">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">Shipping &amp; Billing information</h4>
				<table>
					<tr>
						<th>Email</th>
						<td><%=email%></td>
					</tr>
					<tr>
						<th>Full name</th>
						<td><%=a.getFullname()%></td>
					</tr>
					<tr>
						<th>Phone</th>
						<td><%=a.getPhone()%></td>
					</tr>
					<tr>
						<th>Address</th>
						<td><%=a.getDetail() + ",<br>" + a.getDistrict() + ",<br>" + a.getProvince()%></td>
					</tr>
					<tr>
						<th>Country</th>
						<td><%=a.getCountry()%></td>
					</tr>
				</table>
				<hr>
				<h4 class="header-title">Order summary</h4>
				<table>
					<tr>
						<th>Sub total</th>
						<td><%=dollarFormat.format(subtotal)%></td>
					</tr>
					<tr>
						<th>Shipping</th>
						<td><%=dollarFormat.format(0)%></td>
					</tr>
					<tr>
						<th>Total</th>
						<td style="color: #ff4e00; font-size: 1.2em; font-weight: bold;"><%=dollarFormat.format(subtotal)%></td>
					</tr>
				</table>
				<hr>
				<h4 class="header-title">
					Order status <span><a href="#updateOrdStt"
							data-toggle="collapse">
							<i class="fa fa-pencil"></i>Update
						</a></span>
				</h4>
				<p>
					Current status <span class="badge <%=badgeClass%>"><%=status.getDesc()%></span>
				</p>
				<div id="updateOrdStt" class="collapse">
					<form name="udOrdSttForm" action="">
						<input type="hidden" name="ordId" value="<%=o.getOrderId()%>">
						<div class="form-group">
							<label class="col-form-label">Select status:</label>
							<select class="custom-select" name="selectOrdStt">
								<%
								for (OrderStatus os : sttList) {
								%>
								<option value="<%=os.getStatusId()%>"
									<%if (o.getStatusId() == os.getStatusId())
	out.print("selected disabled");%>><%=os.getDesc()%></option>
								<%
								}
								%>
							</select>
						</div>
						<button type="reset" class="btn btn-secondary"
							data-toggle="collapse" data-target="#updateOrdStt">Cancel</button>
						<button type="button" class="btn btn-dark" name="update-btn">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>