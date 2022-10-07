<%@page import="net.asterp.dao.UserDAO"%>
<%@page import="net.asterp.model.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String email = session.getAttribute("email").toString();
ArrayList<User> admins = new UserDAO().getAllByRole("Admin");
%>
<div class="row ad-p">
	<!-- Dark table start -->
	<div class="col-12 mt-5">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">Administrator accounts</h4>
				<div class="data-tables datatable-dark">
					<table id="dataTable-admin" class="text-center table-hover">
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
							if (admins != null) {
								for (User u : admins) {
							%>
							<tr <% if (u.getEmail().equals(email)) out.print("class=\"highlight-acc\""); %>>
								<td>
									<%
									if (u.getEmail().equals(email))
										out.print(u.getEmail() + " (ME)");
									else
										out.print(u.getEmail());
									%>
								</td>
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
									<a
										href="<%if (u.getEmail().equals(email))
	out.print("?page=adDetail&e=" + email);
else
	out.print("javascript:alertAd()");%>"
										class="view-ad-link">
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