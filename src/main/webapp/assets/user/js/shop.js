$(document).ready(function() {
	var height = $('.product_desc').map(function() {
		return $(this).height();
	}).get();
	maxHeight = Math.max.apply(null, height);
	$('.product_desc').height(maxHeight);
/*
	qty();
	removeItem();*/
});

$('form[name=category-checkbox-form]').on('change', function() {
	var frm = $(this);
	$.ajax({
		type: 'post',
		url: '/NasaSpaceStore/ProductServlet',
		data: frm.serialize() + '&action=filterCategory',
		success: function(resp) {
			var url = window.location.origin + '/NasaSpaceStore' + resp;
			console.log(url);
			window.location.href = url;
		}
	});
});

$('.color-quality .btn-plus, .color-quality .btn-minus').on('click', function(e) {
	const isNegative = $(e.target).closest('.btn-minus').is('.btn-minus');
	const input = $(e.target).closest('.input-group').find('input');
	if (input.is('input')) {
		input[0][isNegative ? 'stepDown' : 'stepUp']()
	}
});

function addFromDetPage(el, id) {
	var $input = $(el).closest('.occasion-cart').prev('.color-quality').find('input[name=quantity]');
	var qty = $input.val();
	addToCart(id, qty);
}

function addToCart(id, qty) {
	$.ajax({
		type: 'post',
		url: '/NasaSpaceStore/CartServlet',
		data: {
			action: 'addToCart',
			id: id,
			qty: qty
		},
		success: function(resp) {
			if (resp == 'please login') {
				swal({
					title: 'Oops! You are not logged in yet',
					text: 'Please login to add your shopping products to cart',
					icon: 'warning',
					buttons: {
						cancel: 'No, I don\'t',
						login: {
							text: 'Login',
							value: 'login'
						}
					}
				}).then((value => {
					switch (value) {
						case 'login':
							$('#signinModal').modal('show');
							break;
						default:
							break;
					}
				}));
			} else {
				swal({
					title: 'Added item to your cart',
					icon: 'success'
				});
				$('button.top_googles_cart span').text(resp);
				viewCart();
			}
		}
	});
}
