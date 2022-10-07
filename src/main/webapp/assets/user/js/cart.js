$(document).ready(function() {
	qty();
	qtyCartPage();
	removeItem();
	removeItemInCartPg();
});

// Prevent closing dropdown when click inside
document.getElementById("ddcart-content").addEventListener('click', function(event) {
	event.stopPropagation();
});

// Show dropdown cart
$('.cart .dropdown').on('show.bs.dropdown', function() {
	viewCart();
});

function viewCart() {
	var $cbody = $('#ddcart-content').find('.card-body');
	$.ajax({
		type: 'post',
		url: '/NasaSpaceStore/CartServlet?action=viewCart',
		success: function(resp) {
			if (resp == 'please login') {
				$cbody.html('Login to see your cart');
			} else if (resp == 'empty') {
				$cbody.html('Your cart is empty');
				if ($('#ddcart-content .card-footer').length) {
					$('#ddcart-content .card-footer').remove();
				}
			} else {
				const data = $.parseJSON(resp);
				var html = '';
				var subTotal = 0;
				var formatter = new Intl.NumberFormat('en-US', {
					style: 'currency',
					currency: 'USD',

					// These options are needed to round to whole numbers if that's what you want.
					//minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
					//maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
				});
				$.each(data, function(k, v) {
					subTotal += v.price * v.qty;
					html += '<div class="row">'
						+ '<div class="col-2">'
						+ '<a href="?page=productDetails&pId=' + v.id + '">'
						+ '<img alt="' + v.name + '" src="data:image/jpg;base64,' + v.img + '">'
						+ '</a>'
						+ '</div>'
						+ '<div class="col-6">'
						+ '<a href="?page=productDetails&pId=' + v.id + '">' + v.name + '</a>'
						+ '<div>' + formatter.format(v.price) + '</div>'
						+ '</div>'
						+ '<div class="col-3 ddcart-qty">'
						+ '<div class="number-input">'
						+ '<button class="btn-minus minus"></button>'
						+ '<input type="hidden" value="' + v.id + '" name="qty-prod-id" />'
						+ '<input class="quantity" min="1" name="quantity"'
						+ 'value="' + v.qty + '" type="number" readonly>'
						+ '<button class="btn-plus plus"></button>'
						+ '</div>'
						+ '</div>'
						+ '<div class="col-1">'
						+ '<button class="btn btn-light ddcart-remove">'
						+ '<i class="material-icons">close</i>'
						+ '</button>'
						+ '</div>'
						+ '</div>';
				});
				document.getElementById('ddcart-content-body').innerHTML = html;
				if (!$('#ddcart-content .card-footer').length) {
					var footer = '<div class="card-footer">'
						+ '<p id="estimate-total-price">'
						+ 'Sub total: <span id="total-price"></span>'
						+ '</p>'
						+ '<div class="row">'
						+ '<div class="col">'
						+ '<a href="?page=cart#cart" class="btn btn-dark viewCart">View cart</a>'
						+ '</div>'
						+ '<div class="col">'
						+ '<a href="?page=cart#checkout" class="btn btn-dark checkout">Checkout</a>'
						+ '</div>'
						+ '</div>'
						+ '</div>';
					$(footer).insertAfter('#ddcart-content-body');
				}
				document.getElementById('total-price').innerHTML = formatter.format(subTotal);
				qty();
				removeItem();
			}
		}
	});
}

function viewCartTable() {
	$.ajax({
		type: 'post',
		url: '/NasaSpaceStore/CartServlet?action=viewCart',
		success: function(resp) {
			if (resp == 'please login') {

			} else if (resp == 'empty') {
				swal({
					title: 'Your cart is empty now',
					text: 'Add some items to view your cart',
					icon: 'info',
				}).then(function() {
					window.location.href = window.location.origin + '/NasaSpace/?page=shop&pagi=1&id=all';
				});
			} else {
				const data = $.parseJSON(resp);
				var html = '';
				var subTotal = 0;
				var formatter = new Intl.NumberFormat('en-US', {
					style: 'currency',
					currency: 'USD',

					// These options are needed to round to whole numbers if that's what you want.
					//minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
					//maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
				});
				$.each(data, function(k, v) {
					subTotal += v.price * v.qty;
					total = v.price * v.qty;
					html += '<tr>'
						+ '<td class="cart-prod-det">'
						+ '<a href="?page=productDetails&pId=' + v.id + '">'
						+ '<img src="data:image/jpg;base64,' + v.img + '"'
						+ 'alt="' + v.name + '" />'
						+ '<span>' + v.name + '</span>'
						+ '</a>'
						+ '</td>'
						+ '<td class="text-right">' + formatter.format(v.price) + '</td>'
						+ '<td class="cart-pg-qty">'
						+ '<div class="number-input">'
						+ '<button class="btn-minus minus"></button>'
						+ '<input type="hidden" value="' + v.id + '"'
						+ 'name="qty-prod-id" />'
						+ '<input class="quantity" min="1" name="quantity"'
						+ 'value="' + v.qty + '" type="number" readonly>'
						+ '<button class="btn-plus plus"></button>'
						+ '</div>'
						+ '</td>'
						+ '<td class="text-right">' + formatter.format(total) + '</td>'
						+ '<td class="text-center">'
						+ '<button class="btn cart-pg-remove">'
						+ '<i class=\'fas fa-trash-alt\'></i>'
						+ '</button>'
						+ '</td>'
						+ '</tr>';
				});
				$('#cart-pg-body').html(html);
				$('.cart-sec .col-3 .card .subtotal').html(formatter.format(subTotal));
				$('.cart-sec .col-3 .card .total').html(formatter.format(subTotal));
				qtyCartPage();
				viewCart();
				removeItemInCartPg();
				checkoutCartSummary();
			}
		}
	});
}

function qty() {
	$('.ddcart-qty .btn-plus, .ddcart-qty .btn-minus').on('click', function(e) {
		const isNegative = $(e.target).closest('.btn-minus').is('.btn-minus');
		const input = $(e.target).closest('.number-input').find('input.quantity');
		const prodId = $(e.target).closest('.number-input').find('input[type=hidden]');
		if (input.is('input')) {
			input[0][isNegative ? 'stepDown' : 'stepUp']()
			changeQty(input.val(), prodId.val());
		}
	});
}

function qtyCartPage() {
	$('.cart-pg-qty .btn-plus, .cart-pg-qty .btn-minus').on('click', function(e) {
		const isNegative = $(e.target).closest('.btn-minus').is('.btn-minus');
		const input = $(e.target).closest('.number-input').find('input.quantity');
		const prodId = $(e.target).closest('.number-input').find('input[type=hidden]');
		if (input.is('input')) {
			input[0][isNegative ? 'stepDown' : 'stepUp']()
			changeQty(input.val(), prodId.val());
		}

		console.log(input.val())
	});
}

function removeItem() {
	$('.ddcart-remove').on('click', function(e) {
		const id = $(e.target).closest('#ddcart-content-body').find('input[name=qty-prod-id]').val();
		$.ajax({
			type: 'post',
			url: '/NasaSpaceStore/CartServlet',
			data: {
				action: 'remove',
				id: id
			}, success: function(resp) {
				$('button.top_googles_cart span').text(resp);
				viewCartTable();
			}
		});
	});
}

function removeItemInCartPg() {
	$('.cart-pg-remove').on('click', function(e) {
		console.log('sk')
		const id = $(e.target).closest('tr').find('input[name=qty-prod-id]').val();
		$.ajax({
			type: 'post',
			url: '/NasaSpaceStore/CartServlet',
			data: {
				action: 'remove',
				id: id
			}, success: function(resp) {
				$('button.top_googles_cart span').text(resp);
				viewCart();
				viewCartTable();
			}
		});
	});
}

function changeQty(qty, id) {
	$.ajax({
		type: 'post',
		url: '/NasaSpaceStore/CartServlet',
		data: {
			action: 'changeQty',
			qty: qty,
			id: id
		},
		success: function() {
			viewCart();
			viewCartTable();
		}
	});
}

function checkoutCartSummary() {
	$.ajax({
		type: 'post',
		url: '/NasaSpaceStore/CartServlet?action=viewCart',
		success: function(resp) {
			if (resp == 'please login') {

			} else if (resp == 'empty') {
				swal({
					title: 'Your cart is empty now',
					text: 'Add some items to view your cart',
					icon: 'info',
				}).then(function() {
					window.location.href = window.location.origin + '/NasaSpace/?page=shop&pagi=1&id=all';
				});
			} else {
				const data = $.parseJSON(resp);
				var html = '';
				var subTotal = 0;
				var formatter = new Intl.NumberFormat('en-US', {
					style: 'currency',
					currency: 'USD',

					// These options are needed to round to whole numbers if that's what you want.
					//minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
					//maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
				});
				$.each(data, function(k, v) {
					subTotal += v.price * v.qty;
					html += '<tr>'
						+ '<td>'
						+ '<a href="?page=productDetails&pId='+v.id+'">'
						+ '<img alt="'+v.name+'"'
						+ 'src="data:image/jpg;base64,'+v.img+'">'
						+ '</a>'
						+ '</td>'
						+ '<td><a href="?page=productDetails&pId='+v.id+'">'
						+ v.name
						+ '</a>'
						+ '<br> <span>Qty: ' + v.qty + '</span>'
						+ '</td>'
						+ '<td class="text-right">' + formatter.format(v.price) + '</td>'
						+ '</tr>';
				});
				$('.checkout-sec .card table').html(html);
				$('.checkout-sec .card-footer .subtotal').html(formatter.format(subTotal));
				$('.checkout-sec .card-footer .total').html(formatter.format(subTotal));
			}
		}
	});
}