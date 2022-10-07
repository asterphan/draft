<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="net.asterp.dao.UserDAO"%>
<%@page import="net.asterp.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String email = request.getParameter("e");
User u = new UserDAO().getUser(email);
String gender = u.getGender();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
%>
<div class="ad-back mt-3 mb-3">
	<a href="?page=userMng&r=a">
		<i class="fa fa-angle-left"></i>Back
	</a>
</div>
<div class="row ad-det">
	<div class="col-7">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">
					Your Profile <span><a data-toggle="collapse"
							href="#editAdInf" role="button" aria-expanded="false"
							aria-controls="editAdInf">
							<i class="fa fa-pencil"></i>Edit
						</a></span>
				</h4>
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
				<form name="edit-ad-inf-form">
					<div class="form-group">
						<label for="ad-email-input" class="col-form-label">Email</label>
						<input class="form-control" type="email" readonly
							name="ad-email-input" id="ad-email-input"
							value="<%=u.getEmail()%>">
					</div>
					<div class="row">
						<div class="col">
							<div class="form-group">
								<label for="ad-fn-input" class="col-form-label">First
									name</label>
								<input class="form-control" type="text" readonly
									name="ad-fn-input" id="ad-fn-input" value="<%=u.getFname()%>">
								<div class="form-control-feedback"></div>
							</div>
						</div>
						<div class="col">
							<div class="form-group">
								<label for="ad-ln-input" class="col-form-label">Last
									name</label>
								<input class="form-control" type="text" readonly
									name="ad-ln-input" id="ad-ln-input" value="<%=u.getLname()%>">
								<div class="form-control-feedback"></div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="ad-phone-input" class="col-form-label">Phone
							number</label>
						<input class="form-control" type="text" readonly
							name="ad-phone-input" id="ad-phone-input"
							value="<%=u.getPhoneNo()%>">
						<div class="form-control-feedback"></div>
					</div>
					<div class="form-group">
						<label for="ad-gender" class="col-form-label">Gender</label>
						<br>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" disabled
								<%if (gender.equals("male"))
	out.print("checked");%>
								id="ad-gender-male" value="male" name="ad-gender"
								class="custom-control-input">
							<label class="custom-control-label" for="ad-gender-male">Male</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" disabled
								<%if (gender.equals("female"))
	out.print("checked");%>
								id="ad-gender-female" value="female" name="ad-gender"
								class="custom-control-input">
							<label class="custom-control-label" for="ad-gender-female">Female</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" disabled
								<%if (gender.equals("other"))
	out.print("checked");%>
								id="ad-gender-other" value="other" name="ad-gender"
								class="custom-control-input">
							<label class="custom-control-label" for="ad-gender-other">Other</label>
						</div>
					</div>
					<div class="collapse" id="editAdInf">
						<button type="reset" class="btn btn-secondary mb-3">Cancel</button>
						<button type="button" class="btn btn-dark mb-3">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="col-5">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">Last login</h4>
				<p><%=u.getLastLogin().format(formatter)%></p>
			</div>
		</div>
	</div>
</div>