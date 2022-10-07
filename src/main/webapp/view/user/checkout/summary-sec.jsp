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
%>
<section class="summary-sec" id="summary-sec">
	<h3>Order summary</h3>
	<div class="row">
		<div class="col-8">
			<div class="row">
				<div class="col-7 shipment-info">
					<div class="header">
						<h5>Shipment Information</h5>
						<a href="javascript:void();" onclick="gotoCheckoutTab()">
							<i class='fas fa-edit'></i>
						</a>
					</div>
					<div class="shipment-tb">
						<form>
							<input type="hidden" name="addrId" value="" />
						</form>
						<table class="table">
							<tbody>
								<tr>
									<th>Full name</th>
								</tr>
								<tr>
									<td></td>
								</tr>
								<tr>
									<th>Phone number</th>
								</tr>
								<tr>
									<td></td>
								</tr>
								<tr>
									<th>Shipping address</th>
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
				</div>
				<div class="col-5 payment-method">
					<div class="header">
						<h5>Payment Method</h5>
						<a href="javascript:void();" onclick="gotoCheckoutTab()">
							<i class='fas fa-edit'></i>
						</a>
					</div>
					<div class="payment-tb">
						<form>
							<input type="hidden" name="paymentId" value="" />
						</form>
						<table class="table">
							<tbody>
								<tr>
									<th>Payment type</th>
								</tr>
								<tr>
									<td></td>
								</tr>
								<tr class="cre-z">
									<th>Card no</th>
								</tr>
								<tr class="cre-z">
									<td></td>
								</tr>
								<tr class="cre-z">
									<th>Security code</th>
								</tr>
								<tr class="cre-z">
									<td></td>
								</tr>
								<tr class="cre-z">
									<th>Expiration date</th>
								</tr>
								<tr class="cre-z">
									<td></td>
								</tr>
								<tr class="cre-z">
									<th>Card holder name</th>
								</tr>
								<tr class="cre-z">
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<button type="button" class="btn btn-dark" name="btnOrder">Place
				order</button>
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