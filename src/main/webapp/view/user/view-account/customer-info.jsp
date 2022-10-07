<%@page import="net.asterp.dao.UserDAO"%>
<%@page import="net.asterp.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String email = session.getAttribute("email").toString();
User user = new UserDAO().getUser(email);
%>
<div class="customer-info">
	<h3>My details</h3>
	<div class="sep-sec">
		<h5>
			Personal Information
			<a class="btn" id="edit-cus-info" data-toggle="collapse"
				href="#collapseCusInfo" role="button" aria-expanded="false"
				aria-controls="collapseCusInfo">
				Edit <i class='fas fa-edit'></i>
			</a>
		</h5>
		<form name="info-form" action="javascript:updateCusInfo()">
			<div class="form-group row">
				<input type="hidden" name="cus-email" value="<%=user.getEmail()%>">
				<label for="cus-fname" class="col-sm-2 col-form-label">
					First name <span class="required-symb">*</span>
				</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="cus-fname"
						name="cus-fname" required disabled placeholder="First name"
						value="<%=user.getFname()%>">
				</div>
				<label for="cus-lname" class="col-sm-2 col-form-label">
					Last name <span class="required-symb">*</span>
				</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="cus-lname"
						name="cus-lname" required disabled placeholder="Last name"
						value="<%=user.getLname()%>">
				</div>
			</div>
			<div class="row err-msg">
				<div class="col-sm-4 offset-sm-2">
					<span class="cus-fn-msg"></span>
				</div>
				<div class="col-sm-4 offset-sm-2">
					<span class="cus-ln-msg"></span>
				</div>
			</div>
			<div class="form-group row">
				<label for="cus-phone" class="col-sm-2 col-form-label">
					Phone number <span class="required-symb">*</span>
				</label>
				<div class="col-sm-4">
					<input type="tel" class="form-control" id="cus-phone"
						name="cus-phone" required disabled placeholder="Phone number"
						value="<%=user.getPhoneNo()%>">
				</div>
				<label for="cus-gender" class="col-sm-2 col-form-label">
					Gender <span class="required-symb">*</span>
				</label>
				<div class="col-sm-4 radiosbtn">
					<%
					String gender = user.getGender();
					%>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="cus-gender"
							id="gender_male" value="male"
							<%if (gender.equals("male"))
	out.print("checked");%>>
						<label class="form-check-label" for="gender_male">Male</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="cus-gender"
							id="gender_female" value="female"
							<%if (gender.equals("female"))
	out.print("checked");%>>
						<label class="form-check-label" for="gender_female">Female</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="cus-gender"
							id="gender_other" value="other"
							<%if (gender.equals("other"))
	out.print("checked");%>>
						<label class="form-check-label" for="gender_other">Other</label>
					</div>
				</div>
			</div>
			<div class="row err-msg">
				<div class="col-sm-4 offset-sm-2">
					<span class="cus-phone-msg"></span>
				</div>
			</div>
			<div class="collapse" id="collapseCusInfo">
				<div class="row">
					<div class="offset-sm-2 col-sm-2">
						<button type="submit" class="btn btn-primary"
							id="save-cus-info-btn">Save change</button>
					</div>
					<div class="col-sm-2">
						<button type="button" class="btn btn-primary revert-info-btn">Revert</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div class="sep-sec">
		<h5>
			Login Information
			<a class="btn" id="edit-cus-pw" data-toggle="collapse"
				href="#collapseCusPwForm" role="button" aria-expanded="false"
				aria-controls="collapseCusPwForm">
				Change password <i class='fas fa-unlock-alt'></i>
			</a>
		</h5>
		<form>
			<div class="form-group row">
				<label for="cus-email" class="col-sm-2 col-form-label">Email
					address</label>
				<div class="col-sm-10">
					<input type="email" class="form-control" id="cus-email"
						name="cus-email" readonly value="<%=user.getEmail()%>">
				</div>
			</div>
		</form>
		<form action="javascript:updateCusPassword()"
			name="cus-change-pw-form" class="collapse" id="collapseCusPwForm">
			<input type="hidden" name="cus-email"
				value="<%=session.getAttribute("email").toString()%>">
			<div class="form-group row">
				<label for="cus-cur-pw" class="col-sm-2 col-form-label">Current
					password</label>
				<div class="col-sm-4">
					<input type="password" class="form-control"
						placeholder="Enter current password" name="cus-cur-pw"
						id="cus-cur-pw" required pattern=".{6,}"
						title="6 characters minimum">
				</div>
				<div class="col-auto err-msg">
					<span id="cur-pw-msg"></span>
				</div>
			</div>
			<div class="form-group row">
				<label for="cus-new-pw" class="col-sm-2 col-form-label">New
					password</label>
				<div class="col-sm-4">
					<input type="password" class="form-control"
						placeholder="Enter new password" name="cus-new-pw" id="cus-new-pw"
						required pattern=".{6,}" title="6 characters minimum">
				</div>
				<div class="col-auto err-msg">
					<span id="new-pw-msg"></span>
				</div>
			</div>
			<div class="form-group row">
				<label for="cus-conf-pw" class="col-sm-2 col-form-label">Confirm
					password</label>
				<div class="col-sm-4">
					<input type="password" class="form-control"
						placeholder="Confirm new password" name="cus-conf-pw"
						id="cus-conf-pw" required pattern=".{6,}"
						title="6 characters minimum">
				</div>
				<div class="col-auto err-msg">
					<span id="conf-pw-msg"></span>
				</div>
			</div>
			<div class="row">
				<div class="offset-sm-2 col-sm-2">
					<button type="submit" class="btn btn-primary" id="save-cus-pw-btn">Submit</button>
				</div>
				<div class="col-sm-2">
					<button type="reset" class="btn btn-primary">Reset</button>
				</div>
			</div>
		</form>
	</div>
</div>
