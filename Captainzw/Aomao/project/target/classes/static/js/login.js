//require('jQuery')
$(function () {
	$.ajax({
		type: 'post',
		url: '/users/queryLogin',
		data: '',
		success: function (res) {
			if (res.code == 20041) {
				$('#login').val(res.data.phoneNumber)
				$('#password').val(res.data.password)
			}
		}
	})
	$('.checkbox').click(function (event) {
		if ($(this).hasClass('checked')) {
			$(this).removeClass('checked');
		} else {
			$(this).addClass('checked');
		}
	});
	$('input').focusin(function (event) {
		$(this).css('borderColor', '#0079CC');
	});
	$('input').focusout(function (event) {
		$(this).css('borderColor', '#cacaca');
	});
	$('.Ypic a').on('click', function () {
		$(this).siblings('img').attr('src', '/users/captcha?time=' + Math.random())
		$('#captcha').val('')
	})
	$('.loGin').on('click', function () {
		let loginJudge = (login, password, captcha) => {
			if (login == null || login == '') {
				$('#wrongInfo').text("电话号或者邮箱不能为空")
				$('#wrongInfo').fadeIn()
				return false
			} else if (password == null || password == '') {
				$('#wrongInfo').text("密码不能为空")
				$('#wrongInfo').fadeIn()
				return false
			} else if (captcha == null || captcha == '') {
				$('#wrongInfo').text("验证码不能为空")
				$('#wrongInfo').fadeIn()
				return false
			}
			return true
		}
		let login = $('#login').val()
		let password = $('#password').val()
		let captcha = $('#captcha').val()
		let remember = $('.Jzmm .checkbox').is('.checked')
		let success = loginJudge(login, password, captcha)
		if (success) {
			$.ajax({
				type: 'post',
				url: '/users/login',
				data: {
					login: login.trim(),
					password: password.trim(),
					captcha: captcha.trim(),
					remember: remember
				},
				success: function (res) {
					if (res.code == 20041) {
						alert('登录成功')
						window.location.href = '/pages/brand_sukin_content.html'
					} else {
						$('#wrongInfo').text(res.msg)
						$('#wrongInfo').fadeIn()
					}
				}
			})
		}
	})

});