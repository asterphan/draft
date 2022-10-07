<%@page import="net.asterp.model.Address"%>
<%@page import="net.asterp.dao.AddressDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String email = session.getAttribute("email").toString();
ArrayList<Address> addresses;

int recordsPerPage = 2;
int currentPage = Integer.parseInt(request.getParameter("p"));
int pagi = Integer.parseInt(request.getParameter("p"));
int records = new AddressDAO().countRows(email);
int numberOfPages;

if (records % 2 != 0) {
	numberOfPages = (records / 2) + 1;
} else {
	numberOfPages = records / 2;
}

if (records > 2) {
	if (pagi != 1) {
		pagi = pagi - 1;
		pagi = pagi * recordsPerPage + 1;
	}
}

addresses = new AddressDAO().getAddrPerPg(pagi, recordsPerPage, email);
%>
<div class="customer-address">
	<h3>
		My shipping address <span><button type="button"
				class="btn btn-dark" data-toggle="collapse"
				data-target="#collapseAddrForm" aria-expanded="false"
				aria-controls="collapseAddrForm">
				<i class="material-icons" style="vertical-align: middle;">playlist_add</i>
				New shipment address
			</button></span>
	</h3>
	<div class="collapse sep-sec" id="collapseAddrForm">
		<h5>Add new address</h5>
		<!-- NEW ADDRESS FORM -->
		<form name="addr-form">
			<div class="form-group row">
				<div class="col">
					<label for="newAddrFn">
						First name <span class="required-symb">*</span>
					</label>
					<input type="text" class="form-control" id="newAddrFn"
						name="newAddrFn" placeholder="Enter first name" required>
					<div class="err-msg">
						<span id="addr-fn-msg"></span>
					</div>
				</div>
				<div class="col">
					<label for="newAddrLn">
						Last name <span class="required-symb">*</span>
					</label>
					<input type="text" class="form-control" id="newAddrLn"
						name="newAddrLn" placeholder="Enter last name" required>
					<div class="err-msg">
						<span id="addr-ln-msg"></span>
					</div>
				</div>
				<div class="col">
					<label for="newAddrPhone">
						Phone number <span class="required-symb">*</span>
					</label>
					<input type="tel" class="form-control" id="newAddrPhone"
						name="newAddrPhone" placeholder="Enter phone number" required>
					<div class="err-msg">
						<span id="addr-phone-msg"></span>
					</div>
				</div>
			</div>
			<div class="form-group row">
				<div class="col">
					<label for="exampleInputEmail1">
						Country <span class="required-symb">*</span>
					</label>
					<input type="text" value="Việt Nam" readonly class="form-control"
						required>
				</div>
				<div class="col">
					<label for="sel-province">
						Province <span class="required-symb">*</span>
					</label>
					<select class="custom-select" name="sel-province" required>
						<option selected disabled>--Select Province--</option>
					</select>
					<div class="err-msg">
						<span id="addr-prov-msg"></span>
					</div>
				</div>
				<div class="col">
					<label for="sel-district">
						District <span class="required-symb">*</span>
					</label>
					<select class="custom-select" name="sel-district" required>
						<option selected disabled>--Select District--</option>
					</select>
					<div class="err-msg">
						<span id="addr-dist-msg"></span>
					</div>
				</div>
				<div class="col">
					<label for="sel-ward">
						Ward <span class="required-symb">*</span>
					</label>
					<select class="custom-select" name="sel-ward" required>
						<option selected disabled>--Select Ward--</option>
					</select>
					<div class="err-msg">
						<span id="addr-ward-msg"></span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label for="newAddrDetail">
					Address Detail <span class="required-symb">*</span>
				</label>
				<input type="text" class="form-control" name="newAddrDetail"
					id="newAddrDetail" placeholder="Street address" required>
				<div class="err-msg">
					<span id="addr-det-msg"></span>
				</div>
			</div>
			<button type="submit" class="btn btn-light">Add to Address
				Book</button>
			<button type="button" class="btn btn-danger">Close</button>
		</form>
		<!-- // end NEW ADDRESS FORM -->
	</div>
	<!-- Display Address cards -->
	<div class="address-cards sep-sec" id="address-cards">
		<h5>Address book</h5>
		<%
		if (addresses != null) {

			for (Address a : addresses) {
		%>
		<div class="card">
			<div class="card-body" id="addr<%=a.getAddrId()%>">
				<div class="cd-head">
					<input type="hidden" name="addrId" value="<%=a.getAddrId()%>" />
					<h5 class="card-title">
						<i class='far fa-address-card'></i>
						<%=a.getFullname()%></h5>
					<div class="dd-options">
						<button class="btn dropdown-toggle" type="button"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Options</button>
						<div class="dropdown-menu">
							<%
							if (a.isDefault()) {
							%>
							<a class="dropdown-item" href="javascript:void()"
								onclick="unsetDefaultAddr(<%=a.getAddrId()%>)"
								style="color: #e1b500">
								<i class='fas fa-star'></i> Unset
							</a>
							<%
							} else {
							%>
							<a class="dropdown-item" href="javascript:void()"
								onclick="setDefaultAddr(<%=a.getAddrId()%>)"
								style="color: #e1b500">
								<i class='far fa-star'></i> Default
							</a>
							<%
							}
							%>
							<a class="dropdown-item" data-toggle="collapse"
								href="#collapseEditAddr<%=a.getAddrId()%>" role="button"
								aria-expanded="false"
								aria-controls="collapseEditAddr<%=a.getAddrId()%>"
								style="color: #0080ff;" onclick="getAddrId(<%=a.getAddrId()%>)">
								<i class='fas fa-pencil-alt'></i> Edit
							</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="javascript:void()"
								onclick="deleteAddr(<%=a.getAddrId()%>)" style="color: red;">
								<i class='fas fa-trash-alt'></i> Delete
							</a>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-5">
						<h6 class="card-subtitle mb-2 text-muted">Contact Information</h6>
						<table>
							<tbody>
								<tr>
									<th>
										<i class='fas fa-user-astronaut'></i>
									</th>
									<td><%=a.getFullname()%></td>
								</tr>
								<tr>
									<th>
										<i class='fas fa-phone'></i>
									</th>
									<td><%=a.getPhone()%></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-5">
						<h6 class="card-subtitle mb-2 text-muted">Address</h6>
						<table>
							<tbody>
								<tr>
									<th>
										<i class="material-icons">location_on</i>
									</th>
									<td><%=a.getDetail()%>,
										<%=a.getWard()%>
										<br><%=a.getDistrict()%>,
										<%=a.getProvince()%>
										<br><%=a.getCountry()%>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<%
				if (a.isDefault()) {
				%>
				<div class="default-symb">
					<span>Default</span>
				</div>
				<%
				}
				%>
				<!-- EDIT ADDRESS FORM -->
				<div class="collapse" id="collapseEditAddr<%=a.getAddrId()%>"
					data-parent="#address-cards">
					<hr>
					<h6>Edit address</h6>
					<form name="edit-addr-form" id="<%=a.getAddrId()%>">
						<input type="hidden" name="addrId" value="<%=a.getAddrId()%>" />
						<input type="hidden" name="province" value="<%=a.getProvince()%>" />
						<input type="hidden" name="district" value="<%=a.getDistrict()%>" />
						<input type="hidden" name="ward" value="<%=a.getWard()%>" />
						<div class="form-group row">
							<div class="col">
								<label for="editAddrFn">
									First name <span class="required-symb">*</span>
								</label>
								<input type="text" class="form-control" name="editAddrFn"
									placeholder="Enter first name" value="<%=a.getFirstName()%>"
									required>
								<div class="err-msg">
									<span id="e-addr-fn-msg"></span>
								</div>
							</div>
							<div class="col">
								<label for="editAddrLn">
									Last name <span class="required-symb">*</span>
								</label>
								<input type="text" class="form-control" name="editAddrLn"
									placeholder="Enter last name" value="<%=a.getLastName()%>"
									required>
								<div class="err-msg">
									<span id="e-addr-ln-msg"></span>
								</div>
							</div>
							<div class="col">
								<label for="editAddrPhone">
									Phone number <span class="required-symb">*</span>
								</label>
								<input type="tel" class="form-control" name="editAddrPhone"
									placeholder="Enter phone number" value="<%=a.getPhone()%>"
									required>
								<div class="err-msg">
									<span id="e-addr-phone-msg"></span>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col">
								<label for="exampleInputEmail1">
									Country <span class="required-symb">*</span>
								</label>
								<input type="text" value="Việt Nam" readonly
									class="form-control" required>
							</div>
							<div class="col">
								<label for="sel-province">
									Province <span class="required-symb">*</span>
								</label>
								<select class="custom-select" name="edit-sel-province">
								</select>
							</div>
							<div class="col">
								<label for="sel-district">
									District <span class="required-symb">*</span>
								</label>
								<select class="custom-select" name="edit-sel-district">
								</select>
							</div>
							<div class="col">
								<label for="sel-ward">
									Ward <span class="required-symb">*</span>
								</label>
								<select class="custom-select" name="edit-sel-ward">
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="editAddrDetail">
								Address Detail <span class="required-symb">*</span>
							</label>
							<input type="text" class="form-control" name="editAddrDetail"
								placeholder="Street address" value="<%=a.getDetail()%>" required>
							<div class="err-msg">
								<span id="e-addr-det-msg"></span>
							</div>
						</div>
						<button type="submit" class="btn btn-light">Submit change</button>
						<button type="button" name="revertAddr" class="btn btn-light">Revert</button>
						<button type="button" name="close-collapse"
							class="btn btn-danger float-right close-collapse">Close</button>
					</form>
				</div>
				<!-- // end EDIT ADDRESS FORM -->
			</div>
		</div>
		<%
		}
		} else {
		%>
		<p>
			No available address.
			<a>Add an address</a>
		</p>
		<%
		}
		%>
		<%
		if (addresses != null) {
		%>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-end addr-ul">
				<li class="page-item">
					<a class="page-link"
						href="?page=account&sc=addr&p=<%=currentPage - 1%>"
						aria-label="Previous"
						<%if (currentPage == 1)
	out.print("hidden");%>>
						<span aria-hidden="true">&laquo;</span> <span class="sr-only">Previous</span>
					</a>
				</li>
				<%
				String url = "?page=account&sc=addr";

				for (int i = 1; i <= numberOfPages; i++) {
				%>
				<li
					class="page-item <%if (request.getParameterMap().containsKey("p") && Integer.parseInt(request.getParameter("p")) == i) {
	out.print("active");
}%>">
					<a class="page-link" href="<%=url%>&p=<%=i%>"><%=i%></a>
				</li>
				<%
				}
				%>
				<li class="page-item">
					<a class="page-link"
						href="?page=account&sc=addr&p=<%=currentPage + 1%>"
						aria-label="Next"
						<%if (currentPage == numberOfPages)
	out.print("hidden");%>>
						<span aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span>
					</a>
				</li>
			</ul>
		</nav>
		<%
		}
		%>
	</div>
</div>
