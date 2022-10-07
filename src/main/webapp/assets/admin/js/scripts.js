
(function($) {
	"use strict";

	/*================================
	Preloader
	==================================*/

	var preloader = $('#preloader');
	$(window).on('load', function() {
		preloader.fadeOut('slow', function() { $(this).remove(); });
	});

	/*================================
	sidebar collapsing
	==================================*/
	$('.nav-btn').on('click', function() {
		$('.page-container').toggleClass('sbar_collapsed');
	});

	/*================================
	Start Footer resizer
	==================================*/
	var e = function() {
		var e = (window.innerHeight > 0 ? window.innerHeight : this.screen.height) - 5;
		(e -= 67) < 1 && (e = 1), e > 67 && $(".main-content").css("min-height", e + "px")
	};
	$(window).ready(e), $(window).on("resize", e);

	/*================================
	sidebar menu
	==================================*/
	$("#menu").metisMenu();

	/*================================
	slimscroll activation
	==================================*/
	$('.menu-inner').slimScroll({
		height: 'auto'
	});
	$('.nofity-list').slimScroll({
		height: '435px'
	});
	$('.timeline-area').slimScroll({
		height: '500px'
	});
	$('.recent-activity').slimScroll({
		height: 'calc(100vh - 114px)'
	});
	$('.settings-list').slimScroll({
		height: 'calc(100vh - 158px)'
	});

	/*================================
	stickey Header
	==================================*/
	$(window).on('scroll', function() {
		var scroll = $(window).scrollTop(),
			mainHeader = $('#sticky-header'),
			mainHeaderHeight = mainHeader.innerHeight();

		// console.log(mainHeader.innerHeight());
		if (scroll > 1) {
			$("#sticky-header").addClass("sticky-menu");
		} else {
			$("#sticky-header").removeClass("sticky-menu");
		}
	});

	/*================================
	form bootstrap validation
	==================================*/
	$('[data-toggle="popover"]').popover()

	/*------------- Start form Validation -------------*/
	window.addEventListener('load', function() {
		// Fetch all the forms we want to apply custom Bootstrap validation styles to
		var forms = document.getElementsByClassName('needs-validation');
		// Loop over them and prevent submission
		var validation = Array.prototype.filter.call(forms, function(form) {
			form.addEventListener('submit', function(event) {
				if (form.checkValidity() === false) {
					event.preventDefault();
					event.stopPropagation();
				}
				form.classList.add('was-validated');
			}, false);
		});
	}, false);

	/*================================
	datatable active
	==================================*/
	if ($('#dataTable-ordD-ord').length) {
		$('#dataTable-ordD-ord').DataTable({
			lengthMenu: [
				[5, 10, 20, -1],
				[5, 10, 20, 'All'],
			],
			columnDefs: [{
				targets: 1,
				orderable: false
			}]
		});
	}
	if ($('#dataTable-cd-ord').length) {
		$('#dataTable-cd-ord').DataTable({
			order: [[0, 'desc']],
			lengthMenu: [
				[5, 10, 20, -1],
				[5, 10, 20, 'All'],
			],
		});
	}
	if ($('#dataTable-customers').length) {
		$('#dataTable-customers').DataTable();
	}

	if ($('#dataTable-admin').length) {
		$('#dataTable-admin').DataTable({
		});
	}

	if ($('#dataTable-categories').length) {
		$('#dataTable-categories').DataTable({
		});
	}

	var prodTb = $('#dataTable-prod').DataTable({
		columnDefs: [{
			targets: 1,
			orderable: false
		}]
	});

	var ordTb = $('#dataTable-ord-list').DataTable({
		order: [[0, 'desc']]
	});

	var $priceRange = $(".js-range-slider").ionRangeSlider();

	$.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
		console.log(settings.nTable.id);
		if (settings.nTable.id !== 'dataTable-prod') {
			return true;
		}
		var $inp = $priceRange;
		var min = parseInt($inp.data("from"), 10);
		var max = parseInt($inp.data("to"), 10);
		var price = parseFloat(data[4].substr(1)) || 0;

		//		console.log(min, max, data[4].substr(1));

		if (
			(isNaN(min) && isNaN(max)) ||
			(isNaN(min) && price <= max) ||
			(min <= price && isNaN(max)) ||
			(min <= price && price <= max)
		) {
			return true;
		}
		return false;
	});

	$.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
		console.log(settings.nTable.id);
		if (settings.nTable.id !== 'dataTable-ord-list') {
			return true;
		}
		var start = $ordStartDate.datepicker('getDate');
		var end = $ordEndDate.datepicker('getDate');
		var date = new Date(data[2]);

		if (
			(start === null && end === null) ||
			(start === null && date <= end) ||
			(start <= date && end === null) ||
			(start <= date && date <= end)
		) {
			return true;
		}
		return false;
	});

	$('.prod-p select[name=filter-prod-c]').on('change', function() {
		var c = $(this).val();
		prodTb.column(3).search(c).draw();
	});

	$('.prod-p select[name=filter-prod-stt]').on('change', function() {
		var stt = $(this).val();
		prodTb.column(5).search(stt).draw();
	});

	$priceRange.on('change', function() {
		prodTb.draw();
	});

	$('#filter-prod button[type=reset]').click(function() {
		prodTb.columns().search('').draw();
		$(".js-range-slider").data('ionRangeSlider').reset();
		prodTb.draw();
	});

	var today = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());
	var $ordStartDate = $('input[name=startDate]');
	var $ordEndDate = $('input[name=endDate]');
	$ordStartDate.datepicker({
		todayHighlight: true
	});
	console.log($ordStartDate.datepicker('getDate'))
	
	$ordEndDate.datepicker({
		endDate: '0d',
		todayHighlight: true
	});

	$('#filter-ord select[name=filter-ord-pt]').on('change', function() {
		var pt = $(this).val();
		ordTb.column(3).search(pt).draw();
	});

	$('#filter-ord select[name=filter-ord-stt]').on('change', function() {
		var stt = $(this).val();
		ordTb.column(5).search(stt).draw();
	});

	$ordStartDate.datepicker().on('changeDate', function() {
		ordTb.draw();
	});
	
	$ordEndDate.datepicker().on('changeDate', function() {
		ordTb.draw();
	});
	
	$('#filter-ord button[type=reset]').click(function() {
		console.log('reset filter');
		ordTb.columns().search('').draw();
		$ordStartDate.datepicker('update', new Date(2021,1,1));
		$ordEndDate.datepicker('update', today);
		ordTb.draw();
	});

	/*================================
	Slicknav mobile menu
	==================================*/
	$('ul#nav_menu').slicknav({
		prependTo: "#mobile_menu"
	});

	/*================================
	login form
	==================================*/
	$('.form-gp input').on('focus', function() {
		$(this).parent('.form-gp').addClass('focused');
	});
	$('.form-gp input').on('focusout', function() {
		if ($(this).val().length === 0) {
			$(this).parent('.form-gp').removeClass('focused');
		}
	});

	/*================================
	slider-area background setting
	==================================*/
	$('.settings-btn, .offset-close').on('click', function() {
		$('.offset-area').toggleClass('show_hide');
		$('.settings-btn').toggleClass('active');
	});

	/*================================
	Owl Carousel
	==================================*/
	function slider_area() {
		var owl = $('.testimonial-carousel').owlCarousel({
			margin: 50,
			loop: true,
			autoplay: false,
			nav: false,
			dots: true,
			responsive: {
				0: {
					items: 1
				},
				450: {
					items: 1
				},
				768: {
					items: 2
				},
				1000: {
					items: 2
				},
				1360: {
					items: 1
				},
				1600: {
					items: 2
				}
			}
		});
	}
	slider_area();

	/*================================
	Fullscreen Page
	==================================*/

	if ($('#full-view').length) {

		var requestFullscreen = function(ele) {
			if (ele.requestFullscreen) {
				ele.requestFullscreen();
			} else if (ele.webkitRequestFullscreen) {
				ele.webkitRequestFullscreen();
			} else if (ele.mozRequestFullScreen) {
				ele.mozRequestFullScreen();
			} else if (ele.msRequestFullscreen) {
				ele.msRequestFullscreen();
			} else {
				console.log('Fullscreen API is not supported.');
			}
		};

		var exitFullscreen = function() {
			if (document.exitFullscreen) {
				document.exitFullscreen();
			} else if (document.webkitExitFullscreen) {
				document.webkitExitFullscreen();
			} else if (document.mozCancelFullScreen) {
				document.mozCancelFullScreen();
			} else if (document.msExitFullscreen) {
				document.msExitFullscreen();
			} else {
				console.log('Fullscreen API is not supported.');
			}
		};

		var fsDocButton = document.getElementById('full-view');
		var fsExitDocButton = document.getElementById('full-view-exit');

		fsDocButton.addEventListener('click', function(e) {
			e.preventDefault();
			requestFullscreen(document.documentElement);
			$('body').addClass('expanded');
		});

		fsExitDocButton.addEventListener('click', function(e) {
			e.preventDefault();
			exitFullscreen();
			$('body').removeClass('expanded');
		});
	}

	$('form[name=prod-d-inf] .custom-file').css('display', 'none');

})(jQuery);

const EMAIL_PATTERN = new RegExp('^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$');
const NAME_PATTERN = new XRegExp('^[\\p{L}]+(?:\\s[\\p{L}]+)?$');
const PHONE_PATTERN = new RegExp('^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}$');

$('#ad_login_submit').click(function() {
	var $form = $('form[name=ad-login-form]');
	var email = $form.find('input[name=signinEmail]').val().trim();
	var pass = $form.find('input[name=signinPassword]').val().trim();

	if (!EMAIL_PATTERN.test(email)) {
		swal({
			text: "Invalid email address",
			icon: "error"
		});
	} else if (pass.length <= 5) {
		swal({
			text: "Password length should be greater than 5",
			icon: "error"
		});
	} else {
		$.ajax({
			type: 'post',
			url: '/NasaSpaceStore/LoginServlet',
			data: $form.serialize(),
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
						window.location.href = window.location.origin + '/NasaSpaceStore/admin.jsp';
					});

				}

			}
		});
	}
});

function adLogout() {
	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/LogoutServlet?role=admin',
		success: function(resp) {
			if (resp == 'logged out') {
				swal({
					title: 'Logged out',
					icon: 'success'
				}).then(function() {
					window.location.href = window.location.origin + '/NasaSpaceStore/view/admin/login.jsp';
				});
			}
		}
	});
}

$('#updateOrdStt button[name=update-btn]').click(function() {
	var $form = $('form[name=udOrdSttForm]');
	$.ajax({
		type: 'get',
		url: '/NasaSpaceStore/OrderServlet',
		data: $form.serialize() + '&action=updateOrdStt',
		success: function(resp) {
			if (resp) {
				location.reload();
			} else {
				swal({
					title: 'Update status failed',
					icon: 'error'
				});
			}
		}
	});
});

function alertAd() {
	$.toast({
		heading: 'Warning',
		text: 'You\'re not permitted to view others',
		showHideTransition: 'slide',
		icon: 'warning',
		loader: false,
		position: {
			top: 20,
			right: 20
		},
		stack: 4,
		hideAfter: 5000,
		allowToastClose: true
	});
}

$('#editAdInf').on('shown.bs.collapse', function() {
	var $form = $('form[name=edit-ad-inf-form]');
	$form.find('input[type=text]').prop('readonly', false);
	$form.find('input[type=radio]').prop('disabled', false);
});

$('#editAdInf').on('hidden.bs.collapse', function() {
	var $form = $('form[name=edit-ad-inf-form]');
	$form[0].reset();
	$form.find('input[type=text]').prop('readonly', true);
	$form.find('input[type=radio]').prop('disabled', true);
	$form[0].reset();
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

$('form[name=edit-ad-inf-form] button[type=reset]').click(function() {
	var $form = $('form[name=edit-ad-inf-form]');

	var $fnInp = $form.find('input[name=ad-fn-input]');
	var $lnInp = $form.find('input[name=ad-ln-input]');
	var $phoneInp = $form.find('input[name=ad-phone-input]');

	var $fnErr = $fnInp.siblings('.form-control-feedback');
	var $lnErr = $lnInp.siblings('.form-control-feedback');
	var $phoneErr = $phoneInp.siblings('.form-control-feedback');

	setErrMsg($fnErr, $fnInp, '', true);
	setErrMsg($lnErr, $lnInp, '', true);
	setErrMsg($phoneErr, $phoneInp, '', true);
});

$('form[name=edit-ad-inf-form] button[type=button]').click(function() {
	var $form = $('form[name=edit-ad-inf-form]');

	var $fnInp = $form.find('input[name=ad-fn-input]');
	var $lnInp = $form.find('input[name=ad-ln-input]');
	var $phoneInp = $form.find('input[name=ad-phone-input]');

	var $fnErr = $fnInp.siblings('.form-control-feedback');
	var $lnErr = $lnInp.siblings('.form-control-feedback');
	var $phoneErr = $phoneInp.siblings('.form-control-feedback');

	if (!NAME_PATTERN.test($fnInp.val())) {
		console.log('wrong fn');
		setErrMsg($fnErr, $fnInp, 'Invalid name pattern. Please enter again', false);
		setErrMsg($lnErr, $lnInp, '', true);
		setErrMsg($phoneErr, $phoneInp, '', true);
	} else if (!NAME_PATTERN.test($lnInp.val())) {
		console.log('wrong ln');
		setErrMsg($fnErr, $fnInp, '', true);
		setErrMsg($lnErr, $lnInp, 'Invalid name pattern. Please enter again', false);
		setErrMsg($phoneErr, $phoneInp, '', true);
	} else if (!PHONE_PATTERN.test($phoneInp.val())) {
		console.log('wrong pn');
		setErrMsg($fnErr, $fnInp, '', true);
		setErrMsg($lnErr, $lnInp, '', true);
		setErrMsg($phoneErr, $phoneInp, 'Invalid phone pattern. Please enter again', false);
	} else {
		setErrMsg($fnErr, $fnInp, '', true);
		setErrMsg($lnErr, $lnInp, '', true);
		setErrMsg($phoneErr, $phoneInp, '', true);

		$.ajax({
			type: 'post',
			url: '/NasaSpaceStore/UserServlet',
			data: $form.serialize() + '&action=editAdInf',
			success: function(resp) {
				console.log(resp);
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
						location.reload();
					});
				}
			}
		});
	}
});

$('#dataTable-prod button[name=viewProd]').click(function() {
	var prodId = $(this).closest('tr').children('td').eq(0).text();
	console.log(prodId);
	window.location.href = window.location.origin + '/NasaSpaceStore/admin.jsp?page=prodMng&t=pd&id=' + prodId;
});

$('#edit-prod-inf').on('show.bs.collapse', function() {
	var $form = $('form[name=prod-d-inf]');
	$form.find('button[name=outer-del-prod-btn]').css('display', 'none');
});

$('#edit-prod-inf').on('shown.bs.collapse', function() {
	var $form = $('form[name=prod-d-inf]');
	$form.find('input, textarea').prop('readonly', false);
	$form.find('input[name=prod-id]').prop('readonly', true);
	$form.find('select').prop('disabled', false);
	$form.find('.custom-file').show();
});

$('#edit-prod-inf').on('hidden.bs.collapse', function() {
	var $form = $('form[name=prod-d-inf]');
	$form.find('input, textarea').prop('readonly', true);
	$form.find('select').prop('disabled', true);
	$form.find('.custom-file').css('display', 'none');
	$form.find('button[name=outer-del-prod-btn]').show();
	$form[0].reset();
});

$('form[name=prod-d-inf] input[name=prod-price], form[name=add-new-prod] input[name=prod-price]').on('input', function() {
	var val = $(this).val();
	console.log($.isNumeric(val));
	if (!$.isNumeric(val)) {
		$(this).val(val.substr(0, val.length - 1));
	}
});

function previewImg($inputFile, $imgTag) {
	const file = $inputFile.files[0];
	console.log(file);
	if (file) {
		let reader = new FileReader();
		reader.onload = function(event) {
			//			console.log(event.target.result);
			$imgTag.attr('src', event.target.result);
		}
		reader.readAsDataURL(file);
	}
}

$('form[name=prod-d-inf] input[name=prod-img-file]').change(function() {
	var $inputFile = this;
	var $imgTag = $('form[name=prod-d-inf] img.prod-img-tag');

	previewImg($inputFile, $imgTag);
});

$('form[name=prod-d-inf]').ajaxForm({
	success: function(resp) {
		if (resp) {
			swal({
				title: 'Product information has been updated',
				icon: 'success'
			}).then(function() {
				location.reload();
			});
		} else {
			swal({
				title: 'Failed to update',
				icon: 'error'
			});
		}
	},
	error: function(resp) {
		swal({
			title: "Couldn't update product info",
			icon: 'error'
		});
	}
});

$('form[name=prod-d-inf] button[name=inner-del-prod-btn], form[name=prod-d-inf] button[name=outer-del-prod-btn]').click(function() {
	var id = $(this).closest('form').find('input[name=prod-id]').val();

	disableProd(id);
});

function disableProd(id) {
	console.log('delete item: ' + id);
	swal("Are you sure you want to disable this product?", {
		buttons: {
			cancel: "Cancel",
			yes: true,
		},
	}).then((value) => {
		switch (value) {
			case "yes":
				$.ajax({
					type: 'post',
					url: '/NasaSpaceStore/ProductServlet',
					data: {
						id: id,
						action: 'disableProd'
					},
					success: function(resp) {
						console.log(resp);
						if (resp) {
							swal({
								title: 'Product has been disabled',
								icon: 'success'
							}).then(function() {
								location.reload();
							});
						}
					},
					error: function(resp) {
						alert("Couldn't disable this product'");
					}
				});
				break;
			default:
				break;
		}
	});
}

function gotoAddProd() {
	window.location.href = window.location.origin + '/NasaSpaceStore/admin.jsp?page=prodMng&t=add';
}

$('form[name=add-new-prod] input[name=prod-img-file]').change(function() {
	var $inputFile = this;
	var $imgTag = $('form[name=add-new-prod] img.prod-img-tag');

	previewImg($inputFile, $imgTag);
});

$('form[name=add-new-prod]').on('submit', function(e) {


});

$('form[name=add-new-prod]').ajaxForm({
	beforeSubmit: function(arr, $form) {
		console.log(arr);
		var $inpName = $form.find('input[name=prod-name]'),
			$inpDesc = $form.find('textarea[name=prod-desc]'),
			$inpPrice = $form.find('input[name=prod-price]');

		var $msgName = $inpName.closest('.form-group').find('.form-control-feedback'),
			$msgDesc = $inpDesc.closest('.form-group').find('.form-control-feedback'),
			$msgPrice = $inpPrice.closest('.form-group').find('.form-control-feedback');

		if ($.trim($inpName.val()) == '') {
			setErrMsg($msgName, $inpName, 'Product name cannot be empty', false);
			setErrMsg($msgDesc, $inpDesc, '', true);
			setErrMsg($msgPrice, $inpPrice, '', true);
			$inpName.focus();
			return false;
		} else if ($.trim($inpDesc.val()) == '') {
			setErrMsg($msgName, $inpName, '', true);
			setErrMsg($msgDesc, $inpDesc, 'Product description cannot be empty', false);
			setErrMsg($msgPrice, $inpPrice, '', true);
			$inpDesc.focus();
			return false;
		} else if ($.trim($inpPrice.val()) == '') {
			setErrMsg($msgName, $inpName, '', true);
			setErrMsg($msgDesc, $inpDesc, '', true);
			setErrMsg($msgPrice, $inpPrice, 'Product price cannot be empty', false);
			$inpPrice.focus();
			return false;
		}
		setErrMsg($msgName, $inpName, '', true);
		setErrMsg($msgDesc, $inpDesc, '', true);
		setErrMsg($msgPrice, $inpPrice, '', true);
		return true;
	},
	success: function(resp) {
		//		alert(resp)
		if (resp) {
			swal({
				title: 'Product information has been inserted to database',
				icon: 'success'
			}).then(function() {
				location.reload();
			});
		} else {
			swal({
				title: 'Failed to insert',
				icon: 'error'
			});
		}
	},
	error: function(resp) {
		swal({
			title: "Couldn't insert product",
			icon: 'error'
		});
	}
});

$('form[name=add-new-category]').on('submit', function(e) {
	e.preventDefault();
	var $form = $(this);
	$.ajax({
		type: 'post',
		url: '/NasaSpaceStore/CategoryServlet',
		data: $form.serialize() + '&action=add',
		success: function(resp) {
			if (resp) {
				swal({
					title: 'New category has been inserted',
					icon: 'success'
				}).then(function() {
					location.reload();
				});
			} else {
				swal({
					title: 'Failed to insert',
					icon: 'error'
				});
			}
		},
		error: function(resp) {
			alert("Couldn't insert new category");
		}
	});
});

$('#edit-c-form').on('shown.bs.collapse', function() {
	$('#dataTable-categories a[data-toggle=collapse]').prop('disabled', true);
});

$('#dataTable-categories a[data-toggle=collapse]').on('click', function() {
	var id = $(this).closest('tr').find('td').eq(0).text();
	var name = $(this).closest('tr').find('td').eq(1).text();
	var $form = $('#edit-c-form form');
	$form.find('input[name=c-id]').val(id);
	$form.find('input[name=cur-c-name]').val(name);
});

$('form[name=edit-c-form] button[type=button]').click(function() {
	var $form = $('form[name=edit-c-form]');
	$form.find('input[name=new-c-name]').val('');
});

$('form[name=edit-c-form]').on('submit', function(e) {
	e.preventDefault();
	var $form = $(this);
	$.ajax({
		type: 'post',
		url: '/NasaSpaceStore/CategoryServlet',
		data: $form.serialize() + '&action=edit',
		success: function(resp) {
			if (resp) {
				swal({
					title: 'Category has been updated',
					icon: 'success'
				}).then(function() {
					location.reload();
				});
			} else {
				swal({
					title: 'Failed to update',
					icon: 'error'
				});
			}
		},
		error: function(resp) {
			alert("Couldn't edit");
		}
	});
});
