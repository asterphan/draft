<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.model.CartItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.asterp.dao.ShoppingCart"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
ArrayList<CartItem> cartList = cart.getCartList();
//Create a new Locale
Locale usa = new Locale("en", "US");
// Create a formatter given the Locale
NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);
%>
<section class="cart-sec" id="cart-sec">
	<h3>Shopping cart</h3>
	<div class="row">
		<div class="col-9">
			<table class="table table-hover">
				<thead class="thead-dark">
					<tr>
						<th>Item</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Total</th>
						<th>Remove</th>
					</tr>
				</thead>
				<tbody id="cart-pg-body">
					<%
					for (CartItem item : cartList) {
					%>
					<tr>
						<td class="cart-prod-det">
							<a href="?page=productDetails&pId=<%=item.getProductId()%>">
								<img src="data:image/jpg;base64,<%=item.getImgBlob()%>"
									alt="<%=item.getProductName()%>" />
								<span><%=item.getProductName()%></span>
							</a>
						</td>
						<td class="text-right"><%=dollarFormat.format(item.getUnitPrice())%></td>
						<td class="cart-pg-qty">
							<div class="number-input">
								<button class="btn-minus minus"></button>
								<input type="hidden" value="<%=item.getProductId()%>"
									name="qty-prod-id" />
								<input class="quantity" min="1" name="quantity"
									value="<%=item.getQuantity()%>" type="number" readonly>
								<button class="btn-plus plus"></button>
							</div>
						</td>
						<td class="text-right"><%=dollarFormat.format(item.getUnitPrice() * item.getQuantity())%></td>
						<td class="text-center">
							<button type="button" class="btn cart-pg-remove">
								<i class='fas fa-trash-alt'></i>
							</button>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
		<div class="col-3">
			<div class="card">
				<div class="card-header">Cart summary</div>
				<div class="card-body">
					<div>
						Sub total <span class="subtotal"><%=dollarFormat.format(cart.totalPrice())%></span>
					</div>
					<div>
						Shipping <span><%=dollarFormat.format(0)%></span>
					</div>
					<div>
						Total <span class="total"><%=dollarFormat.format(cart.totalPrice())%></span>
					</div>
				</div>
				<div class="card-footer">
					<a href="javascript:gotoCheckoutTab()"
						class="btn btn-dark go-checkout">Checkout</a>
					<a href="?page=shop&pagi=1&id=all" class="btn btn-dark keep-shop">Keep
						shopping</a>
				</div>
			</div>
		</div>
	</div>
</section>