<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.dao.OrderViewDAO"%>
<%@page import="net.asterp.model.OrderView"%>
<%@page import="net.asterp.dao.OrderStatusDAO"%>
<%@page import="net.asterp.model.OrderStatus"%>
<%@page import="net.asterp.dao.OrderDAO"%>
<%@page import="net.asterp.model.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="net.asterp.dao.UserDAO"%>
<%@page import="net.asterp.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%
String email = request.getParameter("e");
User u = new UserDAO().getUser(email);
String gender = u.getGender();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

ArrayList<Order> orders = new OrderDAO().getAllByEmail(email);

//Create a new Locale
Locale usa = new Locale("en", "US");
//Create a formatter given the Locale
NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);
%>
<div class="cd-back mt-3 mb-3">
	<a href="?page=userMng&r=c">
		<i class="fa fa-angle-left"></i>Back
	</a>
</div>
<div class="row cus-det">
	<div class="col-5">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">Customer details</h4>
				<p>
					Status<span
						class="badge <%if (!u.getRole().equals("N/A"))
	out.print("badge-success");
else
	out.print("badge-secondary");%>">
						<%
						if (!u.getRole().equals("N/A"))
							out.print("Active");
						else
							out.print("Inactive");
						%>
					</span>
				</p>
				<form>
					<div class="form-group">
						<label for="cus-email-input" class="col-form-label">Email</label>
						<input class="form-control" type="email" readonly
							name="cus-email-input" id="cus-email-input"
							value="<%=u.getEmail()%>">
					</div>
					<div class="row">
						<div class="col">
							<div class="form-group">
								<label for="cus-fn-input" class="col-form-label">First
									name</label>
								<input class="form-control" type="text" readonly
									name="cus-fn-input" id="cus-fn-input" value="<%=u.getFname()%>">
							</div>
						</div>
						<div class="col">
							<div class="form-group">
								<label for="cus-ln-input" class="col-form-label">Last
									name</label>
								<input class="form-control" type="text" readonly
									name="cus-ln-input" id="cus-ln-input" value="<%=u.getLname()%>">
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="cus-phone-input" class="col-form-label">Phone
							number</label>
						<input class="form-control" type="text" readonly
							name="cus-phone-input" id="cus-phone-input"
							value="<%=u.getPhoneNo()%>">
					</div>
					<div class="form-group">
						<label for="cus-gender" class="col-form-label">Gender</label>
						<br>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" disabled
								<%if (gender.equals("male"))
	out.print("checked");%>
								id="cus-gender" name="cus-gender" class="custom-control-input">
							<label class="custom-control-label" for="cus-gender">Male</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" disabled
								<%if (gender.equals("female"))
	out.print("checked");%>
								id="cus-gender" name="cus-gender" class="custom-control-input">
							<label class="custom-control-label" for="cus-gender">Female</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" disabled
								<%if (gender.equals("other"))
	out.print("checked");%>
								id="cus-gender" name="cus-gender" class="custom-control-input">
							<label class="custom-control-label" for="cus-gender">Other</label>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="col-7">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">Last login</h4>
				<p><%=u.getLastLogin().format(formatter)%></p>
				<h4 class="header-title">Orders</h4>
				<%
				if (orders != null) {
				%>
				<div class="data-tables datatable-dark">
					<table id="dataTable-cd-ord" class="text-center table-hover">
						<thead>
							<tr>
								<th>ID</th>
								<th>Date</th>
								<th>Total</th>
								<th>Status</th>
								<th>View</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Order o : orders) {
								double totalPrice = new OrderViewDAO().getTotalPriceById(o.getOrderId());
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
								<td><%=o.getOrderDate().format(formatter)%></td>
								<td><%=dollarFormat.format(totalPrice)%></td>
								<td>
									<span class="badge <%=badgeClass%>"><%=status.getDesc()%></span>
								</td>
								<td>
									<a href="?page=ordD&e=<%=email%>&id=<%=o.getOrderId()%>&prev=cd"
										class="view-od-link">
										<i class="fa fa-eye"></i>
									</a>
								</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
</div>