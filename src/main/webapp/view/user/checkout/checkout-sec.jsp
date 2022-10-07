<%@page import="net.asterp.dao.AddressDAO"%>
<%@page import="net.asterp.model.Address"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.model.CartItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.asterp.dao.ShoppingCart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String email = (String) session.getAttribute("email");
ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
ArrayList<CartItem> cartList = cart.getCartList();
//Create a new Locale
Locale usa = new Locale("en", "US");
// Create a formatter given the Locale
NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);

Address a = new Address();
AddressDAO dao = new AddressDAO();
ArrayList<Address> addrList = dao.getEnabledAddrByEmail(email);

if (dao.searchDefault(email) != null) {
	a = dao.searchDefault(email);
} else {
	a = dao.getLastAddress(email);
}
%>
<section class="checkout-sec" id="checkout-sec">
	<h3>Billing details</h3>
	<div class="row">
		<div class="col-8">
			<div class="checkout-shipment">
				<div
					class="ch-header d-flex justify-content-between align-items-center">
					<h5>Shipment Information</h5>
					<!-- Basic dropdown -->
					<button class="btn dropdown-toggle float-right" type="button"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Options</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#" data-toggle="modal"
							data-target="#showAddress">Change</a>
						<a class="dropdown-item" href="#editCheckoutAddr"
							data-toggle="collapse" onclick="getCheckoutAddrId()">Edit</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item add-new" href="javascript:void()">Add
							new</a>
					</div>
				</div>
				<div class="checkout-addr-detail">
					<div class="row">
						<%
						if (a != null) {
						%>
						<form>
							<input type="hidden" name="addr-id" value="<%=a.getAddrId()%>" />
						</form>
						<div class="col">
							<h6>Contact information</h6>
							<table class="display-addr-inf">
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
						<div class="col">
							<h6>Address</h6>
							<table class="display-addr">
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
						<%
						} else {

						}
						%>
					</div>
				</div>
				<div id="editCheckoutAddr" class="collapse">
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
			</div>
			<div class="checkout-payment">
				<h5>Payment method</h5>
				<div class="payment-sec">
					<p>Choose a payment method</p>
					<div class="sel-payment row">
						<div class="payment-type col">
							<label for="cash">
								<input type="radio" name="payment" value="cash" checked />
								Pay with Cash
							</label>
						</div>
						<div class="payment-type col">
							<label for="credit">
								<input type="radio" name="payment" value="credit" />
								Pay with Credit Card
							</label>
						</div>
					</div>
				</div>
				<div class="collapse sep-sec" id="collapsePaymentForm">
					<!-- NEW CARD FORM -->
					<form name="card-form">
						<label for="card-type">
							Choose your card type <span class="required-symb">*</span>
						</label>
						<div class="card-select row">
							<div class="col">
								<label>
									<input type="radio" name="card-type" value="1" />
									<div class="card-img">
										<img alt="" src="images/card-type-1.png" />
									</div>
								</label>
							</div>
							<div class="col">
								<label>
									<input type="radio" name="card-type" value="2" />
									<div class="card-img">
										<img alt="" src="images/card-type-2.png" />
									</div>
								</label>
							</div>
							<div class="col">
								<label>
									<input type="radio" name="card-type" value="3" />
									<div class="card-img">
										<img alt="" src="images/card-type-3.png" />
									</div>
								</label>
							</div>
							<div class="col">
								<label>
									<input type="radio" name="card-type" value="4" />
									<div class="card-img">
										<img alt="" src="images/card-type-4.png" />
									</div>
								</label>
							</div>
						</div>
						<div class="err-msg">
							<span class="card-type-msg"></span>
						</div>
						<div class="form-group">
							<label for="cardNo">
								Card number <span class="required-symb">*</span>
							</label>
							<div class="input-group card-no">
								<div class="input-group-addon">
									<i class='far fa-credit-card'></i>
								</div>
								<input type="text" name="cardNo" placeholder="Card number"
									class="form-control" required />
							</div>
							<div class="err-msg">
								<span class="card-no-msg"></span>
							</div>
						</div>
						<div class="form-group row">
							<div class="col">
								<label for="secCode">
									Security code <span class="required-symb">*</span>
								</label>
								<div class="input-group card-sec-code">
									<div class="input-group-addon">
										<i class='fas fa-lock'></i>
									</div>
									<input type="text" name="secCode" placeholder="###"
										class="form-control" minlength="3" maxlength="3" required />
								</div>
								<div class="err-msg">
									<span class="card-sec-msg"></span>
								</div>
							</div>
							<div class="col">
								<label for="expDate">
									Expiration date <span class="required-symb">*</span>
								</label>
								<div class="input-group date">
									<div class="input-group-addon">
										<i class='fas fa-calendar'></i>
									</div>
									<input type="text" name="expDate" placeholder="M yyyy"
										class="form-control datepicker" required />
								</div>
								<div class="err-msg">
									<span class="card-date-msg"></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label>
								Card holder name <span class="required-symb">*</span>
							</label>
							<input type="text" name="holderName"
								placeholder="Card holder name" class="form-control" required />
							<div class="err-msg">
								<span class="card-name-msg"></span>
							</div>
						</div>
						<div class="form-group">
							<button type="button" name="btnValidate"
								onclick="validateCreditCard();" class="btn btn-light">Validate</button>
							<span class="valid-msg"></span>
						</div>
					</form>
					<!-- // end NEW CARD FORM -->
				</div>
			</div>
			<button type="button" name="btnContinue" class="btn btn-dark">Continue</button>
		</div>
		<div class="col-4">
			<div class="card">
				<div class="card-header">Cart summary</div>
				<div class="card-body">
					<table class="table">
						<%
						for (CartItem item : cartList) {
						%>
						<tr>
							<td>
								<a href="?page=productDetails&pId=<%=item.getProductId()%>">
									<img alt="<%=item.getProductName()%>"
										src="data:image/jpg;base64,<%=item.getImgBlob()%>">
								</a>
							</td>
							<td>
								<a href="?page=productDetails&pId=<%=item.getProductId()%>">
									<%=item.getProductName()%>
								</a>
								<br> <span>Qty: <%=item.getQuantity()%></span>
							</td>
							<td class="text-right"><%=dollarFormat.format(item.getUnitPrice())%></td>
						</tr>
						<%
						}
						%>
					</table>
				</div>
				<div class="card-footer">
					<div>
						Sub total<span class="subtotal"><%=dollarFormat.format(cart.totalPrice())%></span>
					</div>
					<div>
						Shipping<span class="shipping"><%=dollarFormat.format(0)%></span>
					</div>
					<div>
						Total<span class="total"><%=dollarFormat.format(cart.totalPrice())%></span>
					</div>
					<a href="javascript:gotoCartTab()" class="btn btn-dark">Edit
						cart</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Modal -->
<!-- CHANGE ADDRESS -->
<!-- The Modal -->
<div class="modal fade" id="showAddress">
	<div
		class="modal-dialog modal-lg modal-dialog-scrollable modal-dialog-centered">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h1 class="modal-title">Available address</h1>
				<button type="button" class="close" data-dismiss="modal">×</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				<%
				for (Address addr : addrList) {
				%>
				<div class="row">
					<label>
						<input type="radio" name="address" value="<%=addr.getAddrId()%>"
							class="card-input-element" />
						<div class="card card-input">
							<div class="card-body">
								<h5 class="card-title">
									<i class='far fa-address-card'></i><%=addr.getFullname()%>
								</h5>
								<div class="row">
									<div class="col">
										<h6>Contact information</h6>
										<table>
											<tbody>
												<tr>
													<th>
														<i class='fas fa-user-astronaut'></i>
													</th>
													<td><%=addr.getFullname()%></td>
												</tr>
												<tr>
													<th>
														<i class='fas fa-phone'></i>
													</th>
													<td class="card-phone"><%=addr.getPhone()%></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="col">
										<h6>Address detail</h6>
										<table>
											<tbody>
												<tr>
													<th>
														<i class="material-icons">location_on</i>
													</th>
													<td><%=addr.getDetail()%>,
														<%=addr.getWard()%>
														<br><%=addr.getDistrict()%>,
														<%=addr.getProvince()%>
														<br><%=addr.getCountry()%>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</label>
				</div>
				<%
				}
				%>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<p>
					Don't see your favorite address?
					<a href="javascript:void()">Add one</a>
				</p>
				<button type="button" class="btn btn-dark"
					onclick="changeCheckoutAddr()">Select</button>
			</div>
		</div>
	</div>
</div>
