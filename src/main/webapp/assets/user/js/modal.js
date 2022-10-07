const EMAIL_PATTERN = new RegExp('^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$');
/*const NAME_PATTERN = new XRegExp('^\\pL+$');*/
const NAME_PATTERN = new XRegExp('^[\\p{L}]+(?:\\s[\\p{L}]+)?$');
const PHONE_PATTERN = new RegExp('^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}$');

function showPassword() {
	var x = document.getElementById("signinPassword");
	if (x.type === "password") {
		x.type = "text";
	} else {
		x.type = "password";
	}
}

$('#signinModal').on('hidden.bs.modal', function(e) {
	$(this)
		.find("input[type=text],input[type=password],input[type=email]")
		.val('')
		.end()
		.find("input[type=checkbox], input[type=radio]")
		.prop("checked", "")
		.end();
});

$('#signupModal').on('hidden.bs.modal', function(e) {
	$(this)
		.find("input[type=text],input[type=password],input[type=email]")
		.val('')
		.end()
		.find("input[type=checkbox], input[type=radio]")
		.prop("checked", "")
		.end();
});

function onSubmitLogin() {
	const email = $('#signinEmail').val();

	if (!EMAIL_PATTERN.test(email) && email != '') {
		swal({
			title: 'Invalid email pattern',
			text: 'Your email address is incorrect',
			icon: 'error'
		});
	} else {
		$.ajax({
			type: 'post',
			url: '/NasaSpaceStore/LoginServlet',
			data: $('form[name=signinModal]').serialize(),
			success: function(resp) {
				const obj = JSON.parse(resp);
				if (obj.message == 'does not exist') {
					swal({
						title: 'Not Found',
						text: 'This email is not connected with any account. Please sign up for use',
						icon: 'error'
					});
				} else if (obj.message == 'wrong password') {
					swal({
						title: 'Incorrect Password',
						text: 'Please check your password again',
						icon: 'error'
					});
				} else if (obj.message == 'disabled') {
					swal({
						title: 'Expired',
						text: 'This account has expired. Please re-register to activate it',
						icon: 'error'
					});
				} else if (obj.message == 'wrong role') {
					swal({
						title: 'Login failed',
						icon: 'error'
					});
				} else if (obj.message == 'success') {
					swal({
						title: 'Login successfully',
						text: 'Welcome back, ' + obj.fullname,
						icon: 'success'
					}).then(function() {
						/*var currentUrl = window.location.href;*/
						window.location.href = window.location.origin + '/NasaSpaceStore?page=home';
					});

				}
			}
		});
	}
}

function onSubmitRegister() {
	var signupEmail = $('form[name=register-form] input[name=signupEmail]').val();
	var signupFn = $('form[name=register-form] input[name=signupFn]').val();
	var signupLn = $('form[name=register-form] input[name=signupLn]').val();
	var signupPhone = $('form[name=register-form] input[name=signupPhone]').val();

	var $emailInput = $('form[name=register-form] input[name=signupEmail]');
	var $fnInput = $('form[name=register-form] input[name=signupFn]');
	var $lnInput = $('form[name=register-form] input[name=signupLn]');
	var $phoneInput = $('form[name=register-form] input[name=signupPhone]');

	var $emailErrMsg = $('form[name=register-form] #signup-email-msg');
	var $fnErrMsg = $('form[name=register-form] #signup-fn-msg');
	var $lnErrMsg = $('form[name=register-form] #signup-ln-msg');
	var $phoneErrMsg = $('form[name=register-form] #signup-phone-msg');

	if (!EMAIL_PATTERN.test(signupEmail)) {
		setErrMsg($emailErrMsg, $emailInput, 'Invalid email address', false);
		setErrMsg($fnErrMsg, $fnInput, '', true);
		setErrMsg($lnErrMsg, $lnInput, '', true);
		setErrMsg($phoneErrMsg, $phoneInput, '', true);
		valid = false;
	} else if (!NAME_PATTERN.test(signupFn)) {
		setErrMsg($emailErrMsg, $emailInput, '', true);
		setErrMsg($fnErrMsg, $fnInput, 'First name should contain only letters', false);
		setErrMsg($lnErrMsg, $lnInput, '', true);
		setErrMsg($phoneErrMsg, $phoneInput, '', true);
		valid = false;
	} else if (!NAME_PATTERN.test(signupLn)) {
		setErrMsg($emailErrMsg, $emailInput, '', true);
		setErrMsg($fnErrMsg, $fnInput, '', true);
		setErrMsg($lnErrMsg, $lnInput, 'Last name should contain only letters', false);
		setErrMsg($phoneErrMsg, $phoneInput, '', true);
		valid = false;
	} else if (!PHONE_PATTERN.test(signupPhone)) {
		setErrMsg($emailErrMsg, $emailInput, '', true);
		setErrMsg($fnErrMsg, $fnInput, '', true);
		setErrMsg($lnErrMsg, $lnInput, '', true);
		setErrMsg($phoneErrMsg, $phoneInput, 'Invalid phone number', false);
		valid = false;
	} else {
		setErrMsg($emailErrMsg, $emailInput, '', true);
		setErrMsg($fnErrMsg, $fnInput, '', true);
		setErrMsg($lnErrMsg, $lnInput, '', true);
		setErrMsg($phoneErrMsg, $phoneInput, '', true);

		$.ajax({
			type: 'post',
			url: '/NasaSpaceStore/SignupServlet',
			data: $('form[name=register-form]').serialize() + '&role=cus',
			success: function(resp) {
				if (resp == 'exist') {
					setErrMsg($emailErrMsg, $emailInput, 'This email is being used', false);
				} else if (resp == 'fail') {
					swal({
						title: 'Register failed',
						text: 'Something\'s wrong at the server. Please try again later',
						icon: 'error'
					});
				} else if (resp == 'success') {
					swal({
						title: 'Register successfully',
						icon: 'success'
					}).then(function() {
						window.location.href = window.location.origin + '/NasaSpaceStore?page=account';
					});
				}
			}
		});
	}
}

function logout() {
	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/LogoutServlet?role=customer',
		success: function(resp) {
			if (resp == 'logged out') {
				swal({
					title: 'Logged out',
					icon: 'success'
				}).then(function() {
					window.location.href = window.location.origin + '/NasaSpaceStore?page=account';
				});
			}
		}
	});
}

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


