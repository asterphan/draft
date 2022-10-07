function gotoCheckoutTab() {
	$('#pills-tab a[href="#pills-checkout"]').tab('show');
	window.location.hash = '#checkout';
	$('html, body').animate({
		scrollTop: $("#pills-tab").offset().top
	}, 500);
}

$(document).ready(function() {
	if (window.location.hash === '#cart') {
		$('#pills-tab a[href="#pills-cart"]').tab('show');
		$('html, body').animate({
			scrollTop: $("#pills-tab").offset().top
		}, 500);
	} else if (window.location.hash === '#checkout') {
		$('#pills-tab a[href="#pills-checkout"]').tab('show');
		$('html, body').animate({
			scrollTop: $("#pills-tab").offset().top
		}, 500);
	} else if (window.location.hash === '#summary') {
		$('#pills-tab a[href="#pills-summary"]').tab('show');
		$('html, body').animate({
			scrollTop: $("#pills-tab").offset().top
		}, 500);
	}

	const params = new Proxy(new URLSearchParams(window.location.search), {
		get: (searchParams, prop) => searchParams.get(prop),
	});

	let page = params.page;
	console.log(page);

	if (page == 'cart') {
		writeSumAddr();
		writeSumPay();
	}

});

function gotoCartTab() {
	$('#pills-tab a[href="#pills-cart"]').tab('show');
	window.location.hash = '#cart';
	$('html, body').animate({
		scrollTop: $("#pills-tab").offset().top
	}, 500);
}

$('#showAddress').on('show.bs.modal', function() {
	var selectedId = $('.checkout-addr-detail input[name=addr-id]').val();
	$('#showAddress .modal-body .card-input-element[value=' + selectedId + ']').prop('checked', true);
});

function changeCheckoutAddr() {
	var $checked = $('#showAddress .modal-body .card-input-element:checked');
	var id = $checked.val();
	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/AddressServlet',
		data: {
			action: 'getAddr',
			id: id
		},
		success: function(resp) {
			if (resp != null) {
				var data = $.parseJSON(resp);
				writeAddrHtml(data);
				writeSumAddr();
				$('#showAddress button.close').click();
			}
		}
	});
}

$('.checkout-shipment .ch-header .add-new, #showAddress .modal-footer a').on('click', function() {
	window.location.href = window.location.origin + '/NasaSpaceStore?page=account&sc=addr&p=1#addAddr';
});

$('#editCheckoutAddr').on('show.bs.collapse', function() {
	var id = $('.checkout-addr-detail input[name=addr-id]').val();
	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/AddressServlet',
		data: {
			action: 'getAddr',
			id: id
		},
		success: function(resp) {
			if (resp != null) {
				var data = $.parseJSON(resp);
				var $form = $('#editCheckoutAddr form');

				addrFn = data.fn;
				addrLn = data.ln;
				addrPhone = data.phone;
				addrDetail = data.detail;

				var prov = data.prov;
				var dist = data.dist;
				var ward = data.ward;

				$form.find('input[name=editAddrFn]').val(data.fn);
				$form.find('input[name=editAddrLn]').val(data.ln);
				$form.find('input[name=editAddrPhone]').val(data.phone);
				$form.find('input[name=editAddrDetail]').val(data.detail);

				$form.find('input[name=province]').val(data.prov);
				$form.find('input[name=district]').val(data.dist);
				$form.find('input[name=ward]').val(data.ward);

				$form.find('select[name=edit-sel-province] option').remove(); // remove all existing options
				$form.find('select[name=edit-sel-district] option').remove(); // remove all existing options
				$form.find('select[name=edit-sel-ward] option').remove(); // remove all existing options

				setProvince($form, prov, dist, ward);
			}
		}
	});
});

$('#editCheckoutAddr form .btn-danger').on('click', function() {
	$('#editCheckoutAddr').collapse('hide');
});

function getCheckoutAddrId() {
	var $form = $('#editCheckoutAddr form');
	addrFn = $.trim($form.find('input[name=editAddrFn]').val());
	addrLn = $.trim($form.find('input[name=editAddrLn]').val());
	addrPhone = $.trim($form.find('input[name=editAddrPhone]').val());
	addrDetail = $.trim($form.find('input[name=editAddrDetail]').val());

	var prov = $.trim($form.find('input[name=province]').val());
	var dist = $.trim($form.find('input[name=district]').val());
	var ward = $.trim($form.find('input[name=ward]').val());

	$form.find('select[name=edit-sel-province] option').remove(); // remove all existing options
	$form.find('select[name=edit-sel-district] option').remove(); // remove all existing options
	$form.find('select[name=edit-sel-ward] option').remove(); // remove all existing options

	setProvince($form, prov, dist, ward);
}

$('input[name=payment]').hover(function() {
	$(this).closest('label').css('color', '#ff4e00');
});

$('input[name=payment]').mouseleave(function() {
	$(this).closest('label').css('color', '#000');
});

/*$('input[name=payment]').off( "mouseenter mouseleave" );*/

$('input[name=payment]').on('click', function() {
	var checked = $('input[name=payment]:checked').val();
	if (checked == 'credit') {
		$('#collapsePaymentForm').collapse('show');
		$('button[name=btnContinue]').prop('disabled', true);
	} else {
		$('#collapsePaymentForm').collapse('hide');
		$('button[name=btnContinue]').prop('disabled', false);
	}
});

$('#collapsePaymentForm').on('show.bs.collapse', function() {
	var $msg = $('.customer-payment .credit-cards p');
	if ($msg.length) {
		$msg.css('display', 'none');
	}
	if ($('input[name=card-type]:checked').val() == undefined) {
		$(this).find('input[type=text]').prop('readonly', true);
		$(this).find('input[type=text]').closest('.input-group').css('background', '#e9ecef');
	}

	/*$(this).find('form button[type=submit]').prop('disabled', true);*/
	console.log($('input[name=card-type]:checked').val());
});

$('#collapsePaymentForm').on('hidden.bs.collapse', function() {
	var $msg = $('.customer-payment .credit-cards p.no-card');
	if ($msg.length) {
		$msg.show();
	}
	$('#collapsePaymentForm form')[0].reset();
	$('input[name=card-type]:checked').prop('checked', false);
});

$('#collapsePaymentForm input[name=secCode], #collapsePaymentForm input[name=cardNo]').on('keyup', function() {
	this.value = this.value.replace(/[^0-9]/g, '');
});

$('input[name=card-type]').on('click', function() {
	/*console.log($('input[name=card-type]:checked').val());*/
	$('form[name=card-form]').find('.card-type-msg').html('');
	$('#collapsePaymentForm').find('input[type=text]').prop('readonly', false);
	$('#collapsePaymentForm').find('input[type=text]').closest('.input-group').css('background', '#fff');
	$('form[name=card-form]').find('input[type=text]').val('');

	var type = $('input[name=card-type]:checked').val();
	var $cardNo = $('form[name=card-form] input[name=cardNo]');

	$('form[name=card-form]').find('.valid-msg').html('');
	$('form[name=card-form]').find('.card-no-msg').html('');
	$('form[name=card-form]').find('.card-sec-msg').html('');
	$('form[name=card-form]').find('.card-date-msg').html('');
	$('form[name=card-form]').find('.card-name-msg').html('');

	if (type == 1) {
		$cardNo.attr('minlength', '15');
		$cardNo.attr('maxlength', '15');
	} else if (type == 2) {
		$cardNo.attr('minlength', '13');
		$cardNo.attr('maxlength', '16');
	} else if (type == 3) {
		$cardNo.attr('minlength', '16');
		$cardNo.attr('maxlength', '16');
	} else if (type == 4) {
		$cardNo.attr('minlength', '15');
		$cardNo.attr('maxlength', '16');
	}
});
var jsonPaymentMethod;
function validateCreditCard() {
	var $form = $('form[name=card-form]');
	var valid = true;
	var $cardNo = $form.find('input[name=cardNo]');
	var $secCode = $form.find('input[name=secCode]');
	var $expDate = $form.find('input[name=expDate]');
	var $holder = $form.find('input[name=holderName]');
	var cardType = $form.find('input[name=card-type]:checked').val();
	var $typeMsg = $form.find('.card-type-msg');

	if (cardType == undefined) {
		$typeMsg.html('Choose your card type first');
		valid = false;
	} else {
		$typeMsg.html('');
		if ($.trim($cardNo.val()) == '') {
			$form.find('.card-no-msg').html('This field cannot be empty');
			valid = false;
		} else if (!checkCardNo(cardType, $.trim($cardNo.val()), $form.find('.card-no-msg'))) {
			valid = false;
		} else {
			$form.find('.card-no-msg').html('');
		}

		if ($.trim($secCode.val()) == '') {
			$form.find('.card-sec-msg').html('This field cannot be empty');
			valid = false;
		} else if ($.trim($secCode.val()).length != 3) {
			$form.find('.card-sec-msg').html('Security code should be in 3 digits');
			valid = false;
		} else {
			$form.find('.card-sec-msg').html('');
		}

		if ($.trim($expDate.val()) == '') {
			$form.find('.card-date-msg').html('This field cannot be empty');
			valid = false;
		} else {
			$form.find('.card-date-msg').html('');
		}

		if ($.trim($holder.val()) == '') {
			$form.find('.card-name-msg').text('This field cannot be empty');
			valid = false;
		} else {
			$form.find('.card-name-msg').text('');
		}

		if (valid) {
			$form.find('.valid-msg').html('<i class="material-icons">check</i>Valid Credit Card');
			$form.find('.valid-msg').css('color', '#58bf70');
			$('button[name=btnContinue]').prop('disabled', false);
			jsonPaymentMethod = '{"cardNo":"' + $.trim($cardNo.val()) + '","secCode":"' + $.trim($secCode.val()) + '","expDate":"' + $.trim($expDate.val()) + '","holder":"' + $.trim($holder.val()) + '"}';
		} else {
			$form.find('.valid-msg').html('<i class="material-icons">close</i>Invalid Credit Card');
			$form.find('.valid-msg').css('color', 'red');
			$('button[name=btnContinue]').prop('disabled', true);
		}
	}
	return valid;
}

function checkCardNo(type, cardNo, $cardNoMsg) {
	var pattern;
	if (type == 1) {
		pattern = new RegExp('^(?:3[47][0-9]{13})$');
		if (!pattern.test(cardNo)) {
			$cardNoMsg.html('Invalid American Express card number.<br>Starting with 34 or 37, length 15 digits.');
			return false;
		}

	} else if (type == 2) {
		pattern = new RegExp('^(?:4[0-9]{12}(?:[0-9]{3})?)$');
		if (!pattern.test(cardNo)) {
			$cardNoMsg.html('Invalid Visa credit card number.<br>Starting with 4, length 13 or 16 digits.');
			return false;
		}

	} else if (type == 3) {
		pattern = new RegExp('^(?:5[1-5][0-9]{14})$');
		if (!pattern.test(cardNo)) {
			$cardNoMsg.html('Invalid Mastercard number.<br>Starting with 51 through 55, length 16 digits.');
			return false;
		}

	} else if (type == 4) {
		pattern = new RegExp('^(?:(?:2131|1800|35\\d{3})\\d{11})$');
		if (!pattern.test(cardNo)) {
			$cardNoMsg.html('Invalid JCB card number.<br>Starting with 2131 or 1800, length 15 digits or starting with 35, length 16 digits.');
			return false;
		}

	}
	return true;
}

$('.checkout-sec button[name=btnContinue]').on('click', function() {
	$('#pills-tab a[href="#pills-summary"]').tab('show');
	window.location.hash = '#summary';
	$('html, body').animate({
		scrollTop: $("#pills-tab").offset().top
	}, 500);
	writeSumAddr();
	writeSumPay();
});

function writeSumAddr() {
	var id = $('.checkout-addr-detail').find('input[name=addr-id]').val();
	var $table = $('.summary-sec .shipment-tb .table');
	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/AddressServlet',
		data: {
			action: 'getAddr',
			id: id
		},
		success: function(resp) {
			if (resp != null) {
				var data = $.parseJSON(resp);
				$table.closest('.shipment-tb').find('input[name=addrId]').val(id);
				$table.find('tr').eq(1).find('td').text(data.fullname);
				$table.find('tr').eq(3).find('td').text(data.phone);
				$table.find('tr').eq(5).find('td').text(data.detail);
				$table.find('tr').eq(6).find('td').text(data.ward);
				$table.find('tr').eq(7).find('td').text(data.dist);
				$table.find('tr').eq(8).find('td').text(data.prov);
				$table.find('tr').eq(10).find('td').text(data.country);
			}
		}
	});
}

function writeSumPay() {
	var type = $('input[name=payment]:checked').val();
	var $table = $('.summary-sec .payment-tb .table');
	if (type == 'cash') {
		type = 'Cash';
		$('#summary-sec').find('input[name=paymentId]').val(1);
		$table.find('.cre-z').css('display', 'none');
	} else if (type == 'credit') {
		type = 'Credit card';
		$('#summary-sec').find('input[name=paymentId]').val(2);
		var data = $.parseJSON($.trim(jsonPaymentMethod));
		let cardNo = [];
		for (let i = 0; i < data.cardNo.length; i++) {
			if (i < data.cardNo.length - 4) {
				cardNo.push("*");
			} else {
				cardNo.push(data.cardNo[i]);
			}
		}

		let secCode = [];
		for (let i = 0; i < data.secCode.length; i++) {
			if (i < data.secCode.length) {
				secCode.push("*");
			} else {
				secCode.push(data.secCode[i]);
			}
		}

		$table.find('.cre-z').show();
		$table.find('tr').eq(3).find('td').text(cardNo.join(""));
		$table.find('tr').eq(5).find('td').text(secCode.join(""));
		$table.find('tr').eq(7).find('td').text(data.expDate);
		$table.find('tr').eq(9).find('td').text(data.holder.toUpperCase());
	}
	$table.find('tr').eq(1).find('td').text(type);
}

$('button[name=btnOrder]').on('click', function() {
	var addrId = $('#summary-sec').find('input[name=addrId]').val();
	var paymentId = $('#summary-sec').find('input[name=paymentId]').val();

	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/OrderServlet',
		data: {
			action: 'createOrder',
			addrId: addrId,
			paymentId: paymentId
		},
		success: function(resp) {
			if (resp) {
				swal({
					title: 'Thank you for your order!',
					text: 'Hope you enjoy your purchase',
					icon: 'success',
					buttons: {
						shopping: 'Keep shopping',
						view: 'View order'
					}
				}).then((value) => {
					switch (value) {
						case 'shopping':
							window.location.href = window.location.origin + '/NasaSpaceStore/?page=shop&pagi=1&id=all';
							break;
						case 'view':
							window.location.href = window.location.origin + '/NasaSpaceStore/?page=account&sc=orders';
							break;
					}
				}).then(function() {
					$('#dropdownCart span').text(0);
					viewCart();
				});
			}
		}
	});
});
