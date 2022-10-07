<%@page import="net.asterp.dao.PaymentTypeDAO"%>
<%@page import="net.asterp.model.PaymentType"%>
<%@page import="net.asterp.dao.OrderStatusDAO"%>
<%@page import="net.asterp.model.OrderStatus"%>
<%@page import="net.asterp.dao.OrderViewDAO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="net.asterp.dao.OrderDAO"%>
<%@page import="net.asterp.model.Order"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
ArrayList<Order> list = new OrderDAO().getAll();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

ArrayList<PaymentType> pt = new PaymentTypeDAO().getAll();
ArrayList<OrderStatus> stt = new OrderStatusDAO().getAll();

//Create a new Locale
Locale usa = new Locale("en", "US");
//Create a formatter given the Locale
NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);
%>
<div class="row all-ord-p">
	<div class="col-12 mt-5">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">
					All orders <span><button type="button"
							class="btn btn-info mb-3" data-toggle="collapse"
							data-target="#filter-ord">
							<i class="fa fa-filter"></i>Filter
						</button></span>
				</h4>
				<div id="filter-ord" class="collapse">
					<form>
						<div class="row">
							<div class="col">
								<div class="form-group">
									<label>By order date</label>
									<div class="input-group input-daterange">
										<input type="text" class="form-control" name="startDate">
										<div class="input-group-addon">to</div>
										<input type="text" class="form-control" name="endDate">
									</div>
								</div>
							</div>
							<div class="col">
								<div class="form-group">
									<label>By payment type</label>
									<select name="filter-ord-pt" class="custom-select">
										<option value="">All</option>
										<%
										for (PaymentType p : pt) {
										%>
										<option value="<%=p.getTypeName()%>"><%=p.getTypeName()%></option>
										<%
										}
										%>
									</select>
								</div>
							</div>
							<div class="col">
								<div class="form-group">
									<label>By status</label>
									<select name="filter-ord-stt" class="custom-select">
										<option value="">All</option>
										<%
										for (OrderStatus ot : stt) {
										%>
										<option value="<%=ot.getDesc()%>"><%=ot.getDesc()%></option>
										<%
										}
										%>
									</select>
								</div>
							</div>
							<div class="col-12">
								<button type="reset" class="btn btn-dark">Reset all
									filter</button>
							</div>
						</div>
					</form>
				</div>
				<div class="data-tables datatable-dark">
					<table id="dataTable-ord-list" class="text-center table-hover">
						<thead class="text-capitalize">
							<tr>
								<th>ID</th>
								<th>Email</th>
								<th>Date</th>
								<th>Payment</th>
								<th>Total</th>
								<th>Status</th>
								<th>View</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (list.size() != 0) {
								for (Order o : list) {
									PaymentType type = new PaymentTypeDAO().getById(o.getPaymentType());
									OrderStatus status = new OrderStatusDAO().getById(o.getStatusId());
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
								<td><%=o.getEmail()%></td>
								<td><%=formatter.format(o.getOrderDate())%></td>
								<td><%=type.getTypeName()%></td>
								<td><%=dollarFormat.format(new OrderViewDAO().getTotalPriceById(o.getOrderId()))%></td>
								<td>
									<span class="badge <%=badgeClass%>"><%=status.getDesc()%></span>
								</td>
								<td>
									<a
										href="?page=ordD&e=<%=o.getEmail()%>&id=<%=o.getOrderId()%>&prev=ol"
										class="view-od-link">
										<i class="fa fa-eye"></i>
									</a>
								</td>
							</tr>
							<%
							}
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>