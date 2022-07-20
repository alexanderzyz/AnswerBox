//require('jQuery')
$(function () {
	$('.PNunber .checkbox').click(function (event) {
		if ($('.PNunber .checkbox').hasClass('checked')) {
			$(this).removeClass('checked');
			$('.chp input').addClass('Cn');
		} else {
			$(this).addClass('checked');
			$('.chp input').removeClass('Cn');
		}
	});
	$('input').focusin(function (event) {
		$(this).css('borderColor', '#0079CC');
	});
	$('input').focusout(function (event) {
		$(this).css('borderColor', '#CACACA');
	});
	$('.Ypic a').on('click', function () {
		$(this).siblings('img').attr('src', '/users/captcha?time=' + Math.random())
	})

	let success2 = false;
	let phoneNumber = ''
	$('#phoneNumber').on('blur', function () {
		phoneNumber = $('#phoneNumber').val();
		let pn = {
			phoneNumber: phoneNumber
		}
		$.ajax({
			type: "post",
			url: '/users/queryRegister',
			data: pn,
			success: function (res) {
				if (res.data == 'true') {
					$('#wrongInfo').text('用户名重复了，换一个吧')
					$('#wrongInfo').fadeIn()
					success2 = false;
				} else {
					$('#wrongInfo').fadeOut()
					success2 = true;
				}
			}
		})
	})

	$('#register').on('click', function () {
		let password = $('#password').val();
		let ensurePassword = $('#ensurePassword').val();
		let inputCaptcha = $('#inputCaptcha').val();
		let email = $('#email').val();
		let registerJudge = (phoneNumber, password, ensurePassword) => {
			if (phoneNumber == '' || phoneNumber == null) {
				$('#wrongInfo').text('电话号码不能为空')
				$('#wrongInfo').fadeIn()
				return false
			}
			if (password.length < 6) {
				$('#wrongInfo').text('密码不能少于6位')
				$('#wrongInfo').fadeIn()
				return false
			}
			if (password != ensurePassword) {
				$('#wrongInfo').text('两次密码输入的不一致')
				$('#wrongInfo').fadeIn()
				return false
			}
			if (!($('.Plast .checkbox').is('.checked'))) {
				$('#wrongInfo').text('请勾选用户注册协议')
				$('#wrongInfo').fadeIn()
				return false
			}

			return true
		};
		let success = registerJudge(phoneNumber, password, ensurePassword)
		if (success2 && success) {
			let user = {
				'username': '',
				'phoneNumber': phoneNumber,
				'captcha': inputCaptcha,
				'password': password,
				'email': email
			}
			$.ajax({
				type: 'post',
				url: '/users/register',
				data: user,
				success: function (res) {
					let result = res;
					console.log(result)
					if (result.code != "20011") {
						$('#wrongInfo').text('验证码错误')
						$('#wrongInfo').fadeIn()
					} else {
						alert("注册成功")
						setTimeout(() => {
							window.location.href = "/pages/login.html"
						}, 1000);
					}

				},
				timeout: 2000,
				error: function () {
					alert("注册失败请重试")
				}
			})
		}
	})
});