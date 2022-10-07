// Store customer info value (use when user revert the info form)
const fn = $('form[name=info-form] input[name=cus-fname]').val();
const ln = $('form[name=info-form] input[name=cus-lname]').val();
const phone = $('form[name=info-form] input[name=cus-phone]').val();
const gender = $('form[name=info-form] input[name=cus-gender]:checked').val();
var table;

$(document).ready(function() {
	$('form[name=info-form] input[name=cus-gender]').prop('disabled', true); // set Gender radio btn to disable
	if (window.location.hash === '#addAddr') {
		$('#collapseAddrForm').collapse('show');
		$('html, body').animate({
			scrollTop: $("#collapseAddrForm").offset().top
		}, 500);
	}

	loadDataTb();
});

function loadDataTb() {
	table = $('.display-orders table').DataTable({
		"columnDefs": [{
			"targets": 4,
			"orderable": false
		},
		{
			"targets": 6,
			"orderable": false
		}],
		order: [[0, 'desc']],
		dom: 'flrtip'
	});

	var html = '<form class="form-inline">'
		+ '<label for="order-stt" class="mr-sm-2">Status:</label>'
		+ '<select class="form-control" name="order-stt">'
		+ '<option value="">All</option>'
		+ '<option value="1">Unconfirmed</option>'
		+ '<option value="2">Confirmed</option>'
		+ '<option value="3">Delivering</option>'
		+ '<option value="4">Received</option>'
		+ '<option value="5">Canceled</option>'
		+ '</select>'
		+ '</form>';

	$('#DataTables_Table_0_filter').html(html);

	$('select[name=order-stt]').on('change', function() {
		var status = $(this).val();
		table.column(5).search(status).draw();
	});
}

$('#collapseAddrForm .btn-danger').on('click', function() {
	$('#collapseAddrForm').collapse('hide');
})

$('#collapseCusInfo').on('shown.bs.collapse', function() {
	$('form[name=info-form] input[name=cus-fname]').prop('disabled', false);
	$('form[name=info-form] input[name=cus-lname]').prop('disabled', false);
	$('form[name=info-form] input[name=cus-phone]').prop('disabled', false);
	$('form[name=info-form] input[name=cus-gender]').prop('disabled', false);
});

$('#collapseCusInfo').on('hidden.bs.collapse', function() {
	$('form[name=info-form] input[name=cus-fname]').prop('disabled', true);
	$('form[name=info-form] input[name=cus-lname]').prop('disabled', true);
	$('form[name=info-form] input[name=cus-phone]').prop('disabled', true);
	$('form[name=info-form] input[name=cus-gender]').prop('disabled', true);

	$('form[name=info-form] input[name=cus-fname]').val(fn);
	$('form[name=info-form] input[name=cus-lname]').val(ln);
	$('form[name=info-form] input[name=cus-phone]').val(phone);
	$('form[name=info-form] input[name=cus-gender][value=' + gender + ']').prop('checked', true);
});

$('#collapseCusPwForm').on('hidden.bs.collapse', function() {
	$('#collapseCusPwForm form')[0].reset();
	setErrMsg($(this).find('#cur-pw-msg'), $(this).find('input[name=cus-cur-pw]'), '', true);
	setErrMsg($(this).find('#new-pw-msg'), $(this).find('input[name=cus-new-pw]'), '', true);
	setErrMsg($(this).find('#conf-pw-msg'), $(this).find('input[name=cus-conf-pw]'), '', true);
});

$('#collapseAddrForm').on('hidden.bs.collapse', function() {
	$('#collapseAddrForm form')[0].reset();
	setErrMsg($(this).find('#addr-fn-msg'), $(this).find('input[name=newAddrFn]'), '', true);
	setErrMsg($(this).find('#addr-ln-msg'), $(this).find('input[name=newAddrLn]'), '', true);
	setErrMsg($(this).find('#addr-phone-msg'), $(this).find('input[name=newAddrPhone]'), '', true);
	setErrMsg($(this).find('#addr-prov-msg'), $(this).find('select[name=sel-province]'), '', true);
	setErrMsg($(this).find('#addr-dist-msg'), $(this).find('select[name=sel-district]'), '', true);
	setErrMsg($(this).find('#addr-ward-msg'), $(this).find('select[name=sel-ward]'), '', true);
	setErrMsg($(this).find('#addr-det-msg'), $(this).find('input[name=newAddrDetail]'), '', true);
});

function updateCusInfo() {
	var newFn = $('form[name=info-form] input[name=cus-fname]').val();
	var newLn = $('form[name=info-form] input[name=cus-lname]').val();
	var newPhone = $('form[name=info-form] input[name=cus-phone]').val();

	var $fnErrMsg = $('form[name=info-form] span.cus-fn-msg');
	var $fnInput = $('form[name=info-form] input[name=cus-fname]');

	var $lnErrMsg = $('form[name=info-form] span.cus-ln-msg');
	var $lnInput = $('form[name=info-form] input[name=cus-lname]');

	var $phoneErrMsg = $('form[name=info-form] span.cus-phone-msg');
	var $phoneInput = $('form[name=info-form] input[name=cus-phone]');

	if (!NAME_PATTERN.test(newFn)) {
		setErrMsg($fnErrMsg, $fnInput, 'Invalid first name pattern', false);
		setErrMsg($lnErrMsg, $lnInput, '', true);
		setErrMsg($phoneErrMsg, $phoneInput, '', true);
	} else if (!NAME_PATTERN.test(newLn)) {
		setErrMsg($fnErrMsg, $fnInput, '', true);
		setErrMsg($lnErrMsg, $lnInput, 'Invalid last name pattern', false);
		setErrMsg($phoneErrMsg, $phoneInput, '', true);
	} else if (!PHONE_PATTERN.test(newPhone)) {
		setErrMsg($fnErrMsg, $fnInput, '', true);
		setErrMsg($lnErrMsg, $lnInput, '', true);
		setErrMsg($phoneErrMsg, $phoneInput, 'Invalid phone number pattern', false);
	} else {
		setErrMsg($fnErrMsg, $fnInput, '', true);
		setErrMsg($lnErrMsg, $lnInput, '', true);
		setErrMsg($phoneErrMsg, $phoneInput, '', true);

		$.ajax({
			type: 'post',
			url: '/NasaSpaceStore/UserServlet',
			data: $('form[name=info-form]').serialize() + '&action=updateInfo',
			success: function(resp) {
				if (resp == 'nothing change') {
					swal({
						title: 'Nothing has been changed',
						icon: 'warning'
					});
				} else if (resp == 'fail') {
					swal({
						title: 'Updated failed',
						text: 'An error occurred during the update. Please try again later',
						icon: 'error'
					});
				} else if (resp == 'success') {
					swal({
						title: 'Success',
						text: 'Updated personal info successfully',
						icon: 'success'
					}).then(function() {
						window.location.href = window.location.origin + '/NasaSpaceStore?page=account';
					});
				}
			}
		});
	}
}

$('form[name=info-form] button.revert-info-btn').on('click', function() {
	$('form[name=info-form] input[name=cus-fname]').val(fn);
	$('form[name=info-form] input[name=cus-lname]').val(ln);
	$('form[name=info-form] input[name=cus-phone]').val(phone);
	$('form[name=info-form] input[name=cus-gender][value=' + gender + ']').prop('checked', true);
});

function setErrMsg($msg, $input, errMsg, valid) {
	if (!valid) {
		$msg.text(errMsg);
		$msg.css('color', 'red');
		$input.css('border-color', 'red');
		$input.css('background-color', '#ffe8e8');
	} else {
		$msg.text('');
		$input.css('border-color', '#ced4da');
		$input.css('background-color', '#fff');
	}
}

function updateCusPassword() {
	var curPw = $('form[name=cus-change-pw-form] input[name=cus-cur-pw]').val();
	var newPw = $('form[name=cus-change-pw-form] input[name=cus-new-pw]').val();
	var confPw = $('form[name=cus-change-pw-form] input[name=cus-conf-pw]').val();

	var $curMsg = $('#cur-pw-msg');
	var $newMsg = $('#new-pw-msg');
	var $confMsg = $('#conf-pw-msg');

	var $curInput = $('form[name=cus-change-pw-form] input[name=cus-cur-pw]');
	var $newInput = $('form[name=cus-change-pw-form] input[name=cus-new-pw]');
	var $confInput = $('form[name=cus-change-pw-form] input[name=cus-conf-pw]');

	if (curPw == newPw) {
		setErrMsg($newMsg, $newInput, 'The new password cannot be the same as the current password', false);
		setErrMsg($curMsg, $curInput, '', true);
		setErrMsg($confMsg, $confInput, '', true);
	} else if (newPw != confPw) {
		setErrMsg($newMsg, $newInput, '', true);
		setErrMsg($curMsg, $curInput, '', true);
		setErrMsg($confMsg, $confInput, 'Confirmed password and entered new password do not match', false);
	} else {
		setErrMsg($newMsg, $newInput, '', true);
		setErrMsg($curMsg, $curInput, '', true);
		setErrMsg($confMsg, $confInput, '', true);

		$.ajax({
			type: 'put',
			url: '/NasaSpaceStore/UserServlet',
			data: $('form[name=cus-change-pw-form]').serialize() + '&action=changePw',
			success: function(resp) {
				if (resp == 'wrong') {
					swal({
						title: 'Incorrect password',
						text: 'The current password you\'ve entered is not correct',
						icon: 'error'
					});
				} else if (resp == 'fail') {
					swal({
						title: 'Something\'s wrong',
						text: 'Update password failed. Please try again later',
						icon: 'error'
					});
				} else {
					swal({
						title: 'Success',
						text: 'Your password has been changed',
						icon: 'success'
					}).then(function() {
						window.location.href = window.location.origin + '/NasaSpaceStore?page=account';
					});
				}
			}
		});
	}
}


/**
Address func
*/

// Add new address
$('form[name=addr-form]').on('submit', function(e) {
	e.preventDefault();
	var addrFn = $(this).find('input[name=newAddrFn]').val();
	var addrLn = $(this).find('input[name=newAddrLn]').val();
	var addrPhone = $(this).find('input[name=newAddrPhone]').val();
	var addrProv = $(this).find('select[name=sel-province]').children(':selected').text();
	var addrDist = $(this).find('select[name=sel-district]').children(':selected').text();
	var addrWard = $(this).find('select[name=sel-ward]').children(':selected').text();
	var addrDetail = $(this).find('input[name=newAddrDetail]').val();

	var $fnInp = $(this).find('input[name=newAddrFn]');
	var $lnInp = $(this).find('input[name=newAddrLn]');
	var $phoneInp = $(this).find('input[name=newAddrPhone]');
	var $provInp = $(this).find('select[name=sel-province]');
	var $distInp = $(this).find('select[name=sel-district]');
	var $wardInp = $(this).find('select[name=sel-ward]');
	var $detInp = $(this).find('input[name=newAddrDetail]');

	var $fnMsg = $(this).find('#addr-fn-msg');
	var $lnMsg = $(this).find('#addr-ln-msg');
	var $phoneMsg = $(this).find('#addr-phone-msg');
	var $provMsg = $(this).find('#addr-prov-msg');
	var $distMsg = $(this).find('#addr-dist-msg');
	var $wardMsg = $(this).find('#addr-ward-msg');
	var $detMsg = $(this).find('#addr-det-msg');

	if (!NAME_PATTERN.test(addrFn.trim())) {
		setErrMsg($fnMsg, $fnInp, 'First name should contain only letters', false);
		setErrMsg($lnMsg, $lnInp, '', true);
		setErrMsg($phoneMsg, $phoneInp, '', true);
		setErrMsg($provMsg, $provInp, '', true);
		setErrMsg($distMsg, $distInp, '', true);
		setErrMsg($wardMsg, $wardInp, '', true);
		setErrMsg($detMsg, $detInp, '', true);
	} else if (!NAME_PATTERN.test(addrLn.trim())) {
		setErrMsg($fnMsg, $fnInp, '', true);
		setErrMsg($lnMsg, $lnInp, 'Last name should contain only letters', false);
		setErrMsg($phoneMsg, $phoneInp, '', true);
		setErrMsg($provMsg, $provInp, '', true);
		setErrMsg($distMsg, $distInp, '', true);
		setErrMsg($wardMsg, $wardInp, '', true);
		setErrMsg($detMsg, $detInp, '', true);
	} else if (!PHONE_PATTERN.test(addrPhone.trim())) {
		setErrMsg($fnMsg, $fnInp, '', true);
		setErrMsg($lnMsg, $lnInp, '', true);
		setErrMsg($phoneMsg, $phoneInp, 'Invalid phone number', false);
		setErrMsg($provMsg, $provInp, '', true);
		setErrMsg($distMsg, $distInp, '', true);
		setErrMsg($wardMsg, $wardInp, '', true);
		setErrMsg($detMsg, $detInp, '', true);
	} else if (addrProv == '--Select Province--') {
		setErrMsg($fnMsg, $fnInp, '', true);
		setErrMsg($lnMsg, $lnInp, '', true);
		setErrMsg($phoneMsg, $phoneInp, '', true);
		setErrMsg($provMsg, $provInp, 'Please select a Province', false);
		setErrMsg($distMsg, $distInp, '', true);
		setErrMsg($wardMsg, $wardInp, '', true);
		setErrMsg($detMsg, $detInp, '', true);
	} else if (addrDist == '--Select District--') {
		setErrMsg($fnMsg, $fnInp, '', true);
		setErrMsg($lnMsg, $lnInp, '', true);
		setErrMsg($phoneMsg, $phoneInp, '', true);
		setErrMsg($provMsg, $provInp, '', true);
		setErrMsg($distMsg, $distInp, 'Please select a District', false);
		setErrMsg($wardMsg, $wardInp, '', true);
		setErrMsg($detMsg, $detInp, '', true);
	} else if (addrWard == '--Select Ward--') {
		setErrMsg($fnMsg, $fnInp, '', true);
		setErrMsg($lnMsg, $lnInp, '', true);
		setErrMsg($phoneMsg, $phoneInp, '', true);
		setErrMsg($provMsg, $provInp, '', true);
		setErrMsg($distMsg, $distInp, '', true);
		setErrMsg($wardMsg, $wardInp, 'Please select a Ward', false);
		setErrMsg($detMsg, $detInp, '', true);
	} else if (addrDetail.trim() == '') {
		setErrMsg($fnMsg, $fnInp, '', true);
		setErrMsg($lnMsg, $lnInp, '', true);
		setErrMsg($phoneMsg, $phoneInp, '', true);
		setErrMsg($provMsg, $provInp, '', true);
		setErrMsg($distMsg, $distInp, '', true);
		setErrMsg($wardMsg, $wardInp, '', true);
		setErrMsg($detMsg, $detInp, 'Address detail should not be empty', false);
	} else {
		$.ajax({
			type: 'post',
			url: '/NasaSpaceStore/AddressServlet',
			data: {
				action: 'add',
				fn: addrFn,
				ln: addrLn,
				phone: addrPhone,
				prov: addrProv,
				dist: addrDist,
				ward: addrWard,
				detail: addrDetail
			},
			success: function(resp) {
				if (resp) {
					swal({
						title: 'Added successfully',
						icon: 'success'
					}).then(function() {
						window.location.href = window.location.origin + '/NasaSpaceStore?page=account&sc=addr&p=1';
					});
				} else {
					swal({
						title: 'Added failed',
						text: 'Something\'s wrong in server side. Please try again later',
						icon: 'error'
					});
				}
			}
		});
	}
});

// Add Province option tags
$(document).ready(function() {
	$('select[name=sel-district]').prop('disabled', true);
	$('select[name=sel-ward]').prop('disabled', true);
	$.getJSON('https://cdn.jsdelivr.net/gh/thien0291/vietnam_dataset@1.0.0/Index.json', function(data) {
		const ordered = Object.keys(data).sort().reduce(
			(obj, key) => {
				obj[key] = data[key];
				return obj;
			},
			{}
		);
		$.each(ordered, function(key, value) {
			var prov = new Option(key, value.code);
			$(prov).html(key);
			$('select[name=sel-province]').append(prov);
		});
	});
});

// Add District option tags
$('select[name=sel-province]').on('change', function(e) {
	var val = $(e.target).val();
	$('select[name=sel-district]').prop('disabled', false);
	$('select[name=sel-district]').find('option').not(':first').remove();
	$.getJSON('https://cdn.jsdelivr.net/gh/thien0291/vietnam_dataset@1.0.0/data/' + val + '.json', function(data) {
		const ordered = Object.keys(data.district).sort().reduce(
			(obj, key) => {
				obj[key] = data.district[key];
				return obj;
			},
			{}
		);
		$.each(ordered, function(key, value) {
			var dist = new Option(value.name, key);
			$(dist).html(value.name);
			$('select[name=sel-district]').append(dist);
		});
	});
});

// Add Ward option tags
$('select[name=sel-district]').on('change', function(e) {
	var prov = $('select[name=sel-province]').val();
	var dist = $(e.target).val();
	$('select[name=sel-ward]').prop('disabled', false);
	$('select[name=sel-ward]').find('option').not(':first').remove();
	$.getJSON('https://cdn.jsdelivr.net/gh/thien0291/vietnam_dataset@1.0.0/data/' + prov + '.json', function(data) {
		const ordered = Object.keys(data.district[dist].ward).sort().reduce(
			(obj, key) => {
				obj[key] = data.district[dist].ward[key];
				return obj;
			},
			{}
		);
		$.each(ordered, function(key, value) {
			var ward = new Option(value.name, value.name);
			$(ward).html(value.name);
			$('select[name=sel-ward]').append(ward);
		});
	});
});

// Autofill all fields when show the collapse Edit address form
var addrFn = null, addrLn = null, addrPhone = null, addrDetail = null;
function getAddrId(id) {
	var $form = $('form#' + id);
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

function setProvince($form, prov, dist, ward) {
	$.ajax({
		url: 'https://cdn.jsdelivr.net/gh/thien0291/vietnam_dataset@1.0.0/Index.json',
		async: false,
		dataType: 'json',
		success: function(data) {
			// reorder data
			const ordered = Object.keys(data).sort().reduce(
				(obj, key) => {
					obj[key] = data[key];
					return obj;
				},
				{}
			);
			// add option tags for PROVINCE
			$.each(ordered, function(key, value) {
				var p = new Option(key, value.code);
				$(p).html(key);
				$form.find('select[name=edit-sel-province]').append(p);
			});
			// set selected value for PROVINCE
			$form.find('select[name=edit-sel-province] option').filter(function() {
				return $(this).text() == prov;
			}).prop('selected', true);



			setDistrict($form, dist, ward);
		}
	});
}

function setDistrict($form, dist, ward) {
	$.ajax({
		url: 'https://cdn.jsdelivr.net/gh/thien0291/vietnam_dataset@1.0.0/data/' + $form.find('select[name=edit-sel-province]').val() + '.json',
		async: false,
		dataType: 'json',
		success: function(data) {
			// reorder data2
			const ordered = Object.keys(data.district).sort().reduce(
				(obj, key) => {
					obj[key] = data.district[key];
					return obj;
				},
				{}
			);
			// add option tags for DISTRICT
			$.each(ordered, function(key, value) {
				var d = new Option(value.name, key);
				$(d).html(value.name);
				$('select[name=edit-sel-district]').append(d);
			});
			// set selected value for DISTRICT
			$form.find('select[name=edit-sel-district] option').filter(function() {
				return $(this).text() == dist;
			}).prop('selected', true);

			setWard($form, data, ward);
		}
	});
}

function setWard($form, data, ward) {
	var dst = $form.find('select[name=edit-sel-district]').val(); // get selected value of DISTRICT
	// reorder data2 district
	const ordered = Object.keys(data.district[dst].ward).sort().reduce(
		(obj, key) => {
			obj[key] = data.district[dst].ward[key];
			return obj;
		},
		{}
	);
	// add option tags for WARD
	$.each(ordered, function(key, value) {
		var w = new Option(value.name, value.name);
		$(w).html(value.name);
		$('select[name=edit-sel-ward]').append(w);
	});
	// set selected value for WARD
	$form.find('select[name=edit-sel-ward] option').filter(function() {
		return $(this).text() == ward;
	}).prop('selected', true);
}

// Event when click Revert button of Edit address form
$('form[name=edit-addr-form] button[name=revertAddr]').on('click', function() {
	var $form = $(this).closest('form[name=edit-addr-form]');

	var prov = $.trim($form.find('input[name=province]').val());
	var dist = $.trim($form.find('input[name=district]').val());
	var ward = $.trim($form.find('input[name=ward]').val());

	$form.find('input[name=editAddrFn]').val(addrFn);
	$form.find('input[name=editAddrLn]').val(addrLn);
	$form.find('input[name=editAddrPhone]').val(addrPhone);
	$form.find('input[name=editAddrDetail]').val(addrDetail);

	$form.find('select[name=edit-sel-province] option').remove(); // remove all existing options
	$form.find('select[name=edit-sel-district] option').remove(); // remove all existing options
	$form.find('select[name=edit-sel-ward] option').remove(); // remove all existing options

	setProvince($form, prov, dist, ward);
});

// Fetch District when change Province
$('select[name=edit-sel-province]').on('change', function(e) {
	var $form = $(this).closest('form[name=edit-addr-form]');
	var val = $(e.target).val();
	var $dist = $form.find('select[name=edit-sel-district]');
	var $ward = $form.find('select[name=edit-sel-ward]');
	$dist.find('option').remove();
	$ward.find('option').remove();
	$.ajax({
		url: 'https://cdn.jsdelivr.net/gh/thien0291/vietnam_dataset@1.0.0/data/' + val + '.json',
		async: false,
		dataType: 'json',
		success: function(data) {
			// reorder data2
			const ordered = Object.keys(data.district).sort().reduce(
				(obj, key) => {
					obj[key] = data.district[key];
					return obj;
				},
				{}
			);
			// add option tags for DISTRICT
			$.each(ordered, function(key, value) {
				var d = new Option(value.name, key);
				$(d).html(value.name);
				$dist.append(d);
			});
			// set selected value for DISTRICT
			$dist.find('option:first').prop('selected', true);

			// Fetch Ward automatically after fetching District
			var dst = $dist.val(); // get selected value of DISTRICT
			// reorder data2 district
			const ordered2 = Object.keys(data.district[dst].ward).sort().reduce(
				(obj, key) => {
					obj[key] = data.district[dst].ward[key];
					return obj;
				},
				{}
			);
			// add option tags for WARD
			$.each(ordered2, function(key, value) {
				var w = new Option(value.name, value.name);
				$(w).html(value.name);
				$ward.append(w);
			});
			// set selected value for WARD
			$ward.find('option:first').prop('selected', true);
		}
	});

});

// Fetch Ward when change District
$('select[name=edit-sel-district]').on('change', function(e) {
	var $form = $(this).closest('form[name=edit-addr-form]');
	/*console.log($form.find('select[name=edit-sel-province]').val());*/
	var $prov = $form.find('select[name=edit-sel-province]');
	var $ward = $form.find('select[name=edit-sel-ward]');
	var prov = $prov.val();
	var dist = $(e.target).val();
	$ward.find('option').remove();
	$.ajax({
		url: 'https://cdn.jsdelivr.net/gh/thien0291/vietnam_dataset@1.0.0/data/' + prov + '.json',
		async: false,
		dataType: 'json',
		success: function(data) {
			const ordered = Object.keys(data.district[dist].ward).sort().reduce(
				(obj, key) => {
					obj[key] = data.district[dist].ward[key];
					return obj;
				},
				{}
			);
			$.each(ordered, function(key, value) {
				var ward = new Option(value.name, value.name);
				$(ward).html(value.name);
				$ward.append(ward);
			});

			$ward.find('option:first').prop('selected', true);
		}
	});
});

// Unset default address
function unsetDefaultAddr(id) {
	swal('Are you sure you want to unset this address?', {
		buttons: {
			yes: 'OK',
			cancel: 'Cancel'
		}
	}).then((value) => {
		switch (value) {
			case 'yes':
				$.ajax({
					type: 'get',
					url: '/NasaSpaceStore/AddressServlet',
					data: {
						action: 'unsetDefault',
						id: id
					},
					success: function(resp) {
						if (resp) {
							swal({
								title: 'Unset Default successfully',
								icon: 'success'
							}).then(function() {
								window.location.href = window.location.origin + '/NasaSpaceStore/?page=account&sc=addr&p=1'
							});
						}
					}
				});
				break;
			default:
				break;
		}
	});
}

// Set default address
function setDefaultAddr(id) {
	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/AddressServlet',
		data: {
			action: 'setDefault',
			id: id
		},
		success: function(resp) {
			if (resp == 'true') {
				swal({
					title: 'Set Default successfully',
					icon: 'success'
				}).then(function() {
					window.location.href = window.location.origin + '/NasaSpaceStore/?page=account&sc=addr&p=1';
				});
			} else if (resp == 'have one') {
				swal('You already have 1 default address. Do you want to change the default to this address?', {
					buttons: {
						yes: 'Yes',
						cancel: 'Cancel'
					}
				}).then((value) => {
					switch (value) {
						case 'yes':
							$.ajax({
								type: 'get',
								url: '/NasaSpaceStore/AddressServlet',
								data: {
									action: 'changeDefault',
									id: id
								},
								success: function(resp2) {
									if (resp2) {
										swal({
											title: 'Change default address successfully',
											icon: 'success'
										}).then(function() {
											window.location.href = window.location.origin + '/NasaSpaceStore/?page=account&sc=addr&p=1';
										});
									}
								}
							});
							break;
						default:
							break;
					}
				});
			}
		}
	});
}

// Edit address
$('form[name=edit-addr-form]').on('submit', function(e) {
	e.preventDefault();
	var id = $(this).find('input[name=addrId]').val();

	var $fn = $(this).find('input[name=editAddrFn]');
	var $ln = $(this).find('input[name=editAddrLn]');
	var $phone = $(this).find('input[name=editAddrPhone]');
	var $detail = $(this).find('input[name=editAddrDetail]');

	var $prov = $(this).find('select[name=edit-sel-province]').children(':selected');
	var $dist = $(this).find('select[name=edit-sel-district]').children(':selected');
	var $ward = $(this).find('select[name=edit-sel-ward]').children(':selected');

	var $fnMsg = $(this).find('#e-addr-fn-msg');
	var $lnMsg = $(this).find('#e-addr-ln-msg');
	var $phoneMsg = $(this).find('#e-addr-phone-msg');
	var $detailMsg = $(this).find('#e-addr-det-msg');

	if (!NAME_PATTERN.test($.trim($fn.val()))) {
		setErrMsg($fnMsg, $fn, 'First name should contain only letters', false);
		setErrMsg($lnMsg, $ln, '', true);
		setErrMsg($phoneMsg, $phone, '', true);
		setErrMsg($detailMsg, $detail, '', true);
	} else if (!NAME_PATTERN.test($.trim($ln.val()))) {
		setErrMsg($fnMsg, $fn, '', true);
		setErrMsg($lnMsg, $ln, 'Last name should contain only letters', false);
		setErrMsg($phoneMsg, $phone, '', true);
		setErrMsg($detailMsg, $detail, '', true);
	} else if (!PHONE_PATTERN.test($.trim($phone.val()))) {
		setErrMsg($fnMsg, $fn, '', true);
		setErrMsg($lnMsg, $ln, '', true);
		setErrMsg($phoneMsg, $phone, 'Invalid phone number', false);
		setErrMsg($detailMsg, $detail, '', true);
	} else if ($.trim($detail.val()) == '') {
		setErrMsg($fnMsg, $fn, '', true);
		setErrMsg($lnMsg, $ln, '', true);
		setErrMsg($phoneMsg, $phone, '', true);
		setErrMsg($detailMsg, $detail, 'This field cannot be empty', false);
	} else {
		setErrMsg($fnMsg, $fn, '', true);
		setErrMsg($lnMsg, $ln, '', true);
		setErrMsg($phoneMsg, $phone, '', true);
		setErrMsg($detailMsg, $detail, '', true);

		$.ajax({
			type: 'post',
			url: '/NasaSpaceStore/AddressServlet',
			data: {
				action: 'edit',
				id: id,
				fn: $.trim($fn.val()),
				ln: $.trim($ln.val()),
				phone: $.trim($phone.val()),
				prov: $.trim($prov.text()),
				dist: $.trim($dist.text()),
				ward: $.trim($ward.text()),
				detail: $.trim($detail.val())
			},
			success: function(resp) {
				if (resp == 'true') {
					swal({
						title: 'Update address successfully',
						icon: 'success'
					}).then(function() {
						var currentUrl = window.location.href;

						const params = new Proxy(new URLSearchParams(window.location.search), {
							get: (searchParams, prop) => searchParams.get(prop),
						});
						// Get the value of "some_key" in eg "https://example.com/?some_key=some_value"
						let page = params.page;
						if (page == 'account') {
							window.location.href = currentUrl;
						} else {
							changeCheckoutAddrInfo(id);
						}
					});
				} else {
					swal({
						title: 'Update failed due to some server\'s mistakes',
						icon: 'error'
					});
				}

			}
		});
	}
});

// Change address info of address card in Checkout page
function changeCheckoutAddrInfo(id) {
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
				$('#editCheckoutAddr').collapse('hide');
			}
		}
	});
}

function writeAddrHtml(data) {
	$('.checkout-addr-detail input[name=addr-id]').val(data.id);
	$('.checkout-addr-detail .display-addr-inf tr').eq(0).find('td').text(data.fullname);
	$('.checkout-addr-detail .display-addr-inf tr').eq(1).find('td').text(data.phone);
	$('.checkout-addr-detail .display-addr td').html(data.detail + ', ' + data.ward + '<br>' + data.dist + ', ' + data.prov + '<br>' + data.country);
}

// Delete address
function deleteAddr(id) {
	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/AddressServlet',
		data: {
			action: 'checkDefault',
			id: id
		},
		success: function(isDefault) {
			if (isDefault == 1) {
				swal('This address is currently default. Are you sure you want to delete?', {
					buttons: {
						yes: 'OK',
						cancel: 'Cancel'
					}
				}).then((value) => {
					switch (value) {
						case 'yes':
							$.ajax({
								type: 'get',
								url: '/NasaSpaceStore/AddressServlet',
								data: {
									action: 'delete',
									id: id
								},
								success: function(resp) {
									if (resp) {
										swal({
											title: 'Delete address successfully',
											icon: 'success'
										}).then(function() {
											window.location.href = window.location.origin + '/NasaSpaceStore/?page=account&sc=addr&p=1'
										});
									} else {
										swal({
											title: 'Delete failed due to some server\'s mistakes',
											icon: 'error'
										});
									}
								}
							});
							break;
						default:
							break;
					}
				});
			} else if (isDefault == 0) {
				swal('Are you sure you want to delete this address?', {
					buttons: {
						yes: 'OK',
						cancel: 'Cancel'
					}
				}).then((value) => {
					switch (value) {
						case 'yes':
							$.ajax({
								type: 'get',
								url: '/NasaSpaceStore/AddressServlet',
								data: {
									action: 'delete',
									id: id
								},
								success: function(resp) {
									if (resp) {
										swal({
											title: 'Delete address successfully',
											icon: 'success'
										}).then(function() {
											window.location.href = window.location.origin + '/NasaSpaceStore/?page=account&sc=addr&p=1'
										});
									} else {
										swal({
											title: 'Delete failed due to some server\'s mistakes',
											icon: 'error'
										});
									}
								}
							});
							break;
						default:
							break;
					}
				});
			}
		}
	});
}


$('#address-cards .collapse').on('show.bs.collapse', function(e) {
	var $default = $(e.target).siblings('.default-symb');
	if ($.trim($default.text()).length) {
		$default.css('display', 'none');
	}
});

$('#address-cards .collapse').on('hidden.bs.collapse', function(e) {
	var $default = $(e.target).siblings('.default-symb');
	if ($.trim($default.text()).length) {
		$default.show();
	}
});

$('#address-cards .collapse button[name=close-collapse]').on('click', function(e) {
	var $collapse = $(e.target).closest('.collapse');
	$collapse.collapse('toggle');
});

function showOrderDetails(orderId, addrId) {
	var $modal = $('#orderDetails');
	var $table = $modal.find('#order-items table');
	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/OrderServlet',
		data: {
			action: 'getOrderDetail',
			id: orderId
		}, success: function(resp) {
			if (resp != null) {
				var formatter = new Intl.NumberFormat('en-US', {
					style: 'currency',
					currency: 'USD',

					// These options are needed to round to whole numbers if that's what you want.
					//minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
					//maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
				});
				/*var $tbody = $table.find('tbody');*/
				var id = 0;
				var html = '';
				var data = $.parseJSON(resp);
				var no = 1;
				var subtotal = 0;
				$.each(data, function(k, v) {
					id = v.orderId;
					subtotal += v.price * v.qty;
					var total = v.price * v.qty;
					html += '<div class="row">'
						+ '<div class="col-2"><img alt="' + v.product + '" src="data:image/jpg;base64,' + v.img + '" /></div>'
						+ '<div class="col-6">' + v.product + '<br><span>' + formatter.format(v.price) + '</span></div>'
						+ '<div class="col-2">x' + v.qty + '</div>'
						+ '<div class="col-2">' + formatter.format(total) + '</div>'
						+ '</div>'
				});
				/*$tbody.html(html);*/
				$modal.find('input[name=orderId]').val(id);
				$modal.find('.orders-body').html(html);
				$modal.find('#order-items').find('.noOfItem').text(data.length);
				$modal.find('#order-items').find('.subtotal').text(formatter.format(subtotal));

				$.ajax({
					type: 'get',
					url: '/NasaSpaceStore/AddressServlet',
					data: {
						action: 'getAddr',
						id: addrId
					},
					success: function(resp) {
						if (resp != null) {
							var $table = $('#shipping-info table').eq(0);
							var data = $.parseJSON(resp);
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
		}
	});
}

$('#invoice').on('show.bs.modal', function() {
	$('#orderDetails').modal('toggle');
});

$('#invoice').on('hide.bs.modal', function() {
	$('#orderDetails').modal('show');
});

function cancelOrder(id, el) {
	swal({
		title: 'Are you sure you want to cancel?',
		icon: 'warning',
		buttons: {
			yes: 'Yes',
			cancel: 'Cancel'
		}
	}).then((value) => {
		switch (value) {
			case 'yes':
				$.ajax({
					type: 'get',
					url: '/NasaSpaceStore/OrderServlet',
					data: {
						action: 'cancelOrder',
						id: id
					},
					success: function(resp) {
						if (resp) {
							swal({
								title: 'Cancel order successfully',
								icon: 'success'
							}).then(function() {
								var $tr = $(el).closest('tr');
								$tr.find('td').eq(3).find('span').removeClass('badge-danger').addClass('badge-dark').text('Canceled');
								$tr.find('td.stt').text(5);
								$tr.find('td').eq(6).find('button').prop('disabled', true);
								table
									.rows($tr)
									.invalidate()
									.draw();
							});
						}
					}
				});
				break;
			default:
				break;
		}
	});

}

function viewInvoice() {
	var id = $('#orderDetails').find('input[name=orderId]').val();
//	$.ajax({
//		type: 'post',
//		url: '/NasaSpaceStore/OrderServlet',
//		data: {
//			action: 'getInvoice',
//			id: id
//		}, success: function(resp) {
//			$('#invoice .modal-body').html(resp);
//		}
//	});
	var url = window.location.origin + '/NasaSpaceStore/view/user/invoice.jsp?orderId=' + id;
	window.open(url, '_blank');
}

function printInvoice() {
	var id = $('#orderDetails').find('input[name=orderId]').val();
	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/OrderServlet',
		data: {
			action: 'printInvoice',
			id: id
		}, success: function(resp) {

		}
	});
}
