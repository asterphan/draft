<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.dao.OrderStatusDAO"%>
<%@page import="net.asterp.model.OrderStatus"%>
<%@page import="net.asterp.dao.OrderViewDAO"%>
<%@page import="net.asterp.model.OrderView"%>
<%@page import="net.asterp.dao.OrderDAO"%>
<%@page import="net.asterp.model.Order"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String email = session.getAttribute("email").toString();
ArrayList<Order> orders = new OrderDAO().getAllByEmail(email);
ArrayList<OrderStatus> sttList = new OrderStatusDAO().getAll();

//Create a new Locale
Locale usa = new Locale("en", "US");
// Create a formatter given the Locale
NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

double total;
OrderStatus status;
String paymentType = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta charset="UTF-8" />
</head>
<body>
	<div class="customer-order">
		<h3>My orders</h3>
		<div class="display-orders">
			<%
			if (!orders.isEmpty()) {
			%>
			<table class="table table-hover">
				<thead class="thead-dark">
					<tr>
						<th>Order no</th>
						<th>Order date</th>
						<th>Total price</th>
						<th>Status</th>
						<th>Details</th>
						<th style="display: none;">Hidden</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Order o : orders) {
						if (o.getPaymentType() == 1) {
							paymentType = "Cash";
						} else {
							paymentType = "Credit card";
						}
						total = new OrderViewDAO().getTotalPriceById(o.getOrderId());
						status = new OrderStatusDAO().getById(o.getStatusId());
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
					%>
					<tr>
						<td><%=o.getOrderId()%></td>
						<td><%=o.getOrderDate().format(formatter)%></td>
						<td><%=dollarFormat.format(total)%></td>
						<td>
							<span class="badge <%=badgeClass%>"><%=status.getDesc()%></span>
						</td>
						<td>
							<button type="button"
								onclick="showOrderDetails(<%=o.getOrderId()%>, <%=o.getAddressId()%>)"
								class="btn btn-det" data-toggle="modal"
								data-target="#orderDetails">
								<i class='fas fa-list'></i>
							</button>
						</td>
						<td class="stt" style="display: none;"><%=status.getStatusId()%></td>
						<td>
							<button type="button" class="btn btn-del"
								onclick="cancelOrder(<%=o.getOrderId()%>, this)"
								<%if (o.getStatusId() != 1)
	out.print("disabled");%>>
								<i class='fas fa-trash-alt'></i>
							</button>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
			} else {
			%>
			<p>Currently there is no order.</p>
			<%
			}
			%>
		</div>
		<!-- The Modal -->
		<div class="modal fade" id="orderDetails">
			<div
				class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">Order details</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						<form>
							<input type="hidden" name="orderId" />
						</form>
						<!-- Nav pills -->
						<ul class="nav nav-pills nav-justified">
							<li class="nav-item">
								<a class="nav-link active" data-toggle="pill"
									href="#order-items">Order items</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" data-toggle="pill" href="#shipping-info">Shipment
									&amp; Payment information</a>
							</li>
						</ul>
						<!-- Tab panes -->
						<div class="tab-content">
							<div class="tab-pane container active" id="order-items">
								<div>
									<p>
										Number of items: <span class="noOfItem"></span>
									</p>
									<p>
										Sub Total: <span class="subtotal"></span>
									</p>
								</div>
								<div class="orders-body"></div>
							</div>
							<div class="tab-pane container fade" id="shipping-info">
								<div class="row">
									<div class="col">
										<h6>Shipping information</h6>
										<table>
											<tbody>
												<tr>
													<th>Full name</th>
												</tr>
												<tr>
													<td></td>
												</tr>
												<tr>
													<th>Phone</th>
												</tr>
												<tr>
													<td></td>
												</tr>
												<tr>
													<th>Address detail</th>
												</tr>
												<tr>
													<td></td>
												</tr>
												<tr>
													<td></td>
												</tr>
												<tr>
													<td></td>
												</tr>
												<tr>
													<td></td>
												</tr>
												<tr>
													<th>Country</th>
												</tr>
												<tr>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="col">
										<h6>Payment method</h6>
										<table class="table">
											<tbody>
												<tr>
													<th>Payment type</th>
												</tr>
												<tr>
													<td><%=paymentType%></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-dark" onclick="viewInvoice()">Invoice</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
