//require('jQuery')
$(function () {
	let cartCount = 0;
	$.ajax({
		type: 'post',
		url: '/orders/queryCart',
		data: '',
		success: function (res) {
			let tempCount = 0
			for (const iterator of res.data) {
				tempCount += iterator.num
			}
			cartCount = tempCount
			$('.orderNum').text(cartCount)
			console.log(res);
		}
	})
	//导航下边三角的移动
	$(".nav ul li a").hover(function () {
		$(this).find("span").animate({
			left: "30px"
		}, 500);
	}, function () {
		$(this).find("span").animate({
			left: "-18px"
		}, 0);
	});
	// 导航下边的鼠标移动上去的效果
	$(".hotPro li a").hover(function () {
		$(this).find('.move_box').animate({
			bottom: "0px"
		}, 500);
	}, function () {
		$(this).find('.move_box').animate({
			bottom: "-65px"
		}, 500);
	})

	$('.turnTo').on('click', function () {
		let goodsId = $('.turnTo').index($(this)) + 1;
		$.ajax({
			type: 'post',
			url: '/orders/insertCart',
			data: {
				goodsId: goodsId
			},
			success: function (res) {
				if (res.code == 20011) {
					cartCount++
					$('.orderNum').text(cartCount)
				}
				alert(res.msg)
			}
		})
	})

	$('#myOrder').on('click', function () {
		window.location.href = '/pages/Cart.html'
	})
})