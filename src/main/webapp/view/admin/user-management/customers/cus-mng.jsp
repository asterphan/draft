<%@page import="net.asterp.dao.UserDAO"%>
<%@page import="net.asterp.model.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%
ArrayList<User> customers = new UserDAO().getAllByRole("Customer");
%>
<div class="row">
	<!-- Dark table start -->
	<div class="col-12 mt-5">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">Customer accounts</h4>
				<div class="data-tables datatable-dark">
					<table id="dataTable-customers" class="text-center table-hover">
						<thead class="text-capitalize">
							<tr>
								<th>Email</th>
								<th>Full name</th>
								<th>Phone</th>
								<th>Status</th>
								<th>View Detail</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (customers != null) {
								for (User u : customers) {
							%>
							<tr>
								<td><%=u.getEmail()%></td>
								<td><%=u.getFullName()%></td>
								<td><%=u.getPhoneNo()%></td>
								<td>
									<span
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
								</td>
								<td>
									<a href="?page=cusDetail&e=<%=u.getEmail()%>"
										class="view-cus-link">
										<i class="fa fa-info-circle"></i>
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
	<!-- Dark table end -->
</div>