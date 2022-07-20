//require('jQuery')
$(function () {
	var goodsIds = []

	function addLi(name, introduction, price, image, num) {
		$('.IAbdArea').append(`<li class="IAbdw">
						<span class="lincheck checkbox"></span>
						<img src="../${image}" alt="">
						<p>
							<a class="pro" href="#" > ${name}  ${introduction}</a>
							<a class="use" href="#">
								适用税率：10%
								<s></s>
								<u>
									<em></em>
									税费 = 不含税价格 * 件数 * 商品税率<br>
									根据海关规定，本商品适用税率 : 10%,<br>
									若订单总税额 ≤ 50元，海关予以免征。<br>
								</u>
							</a>
						</p>
						<ul class="IAul">
							<li class="IAtax">￥<u>11.40</u></li>
							<li class="price">
								<strong>¥ <u>${price}</u></strong><br>
								<s>125元</s>
							</li>
							<li class="num">
								<span class="reduce">-</span>
								<input type="text" value="${num}">
								<span class="add">+</span>
							</li>
							<li class="Lastprice">¥ <u>${price}</u></li>
							<li class="last btn">
								<button>移入收藏夹</button><br>
								<button class="delet">删除</button>
							</li>
						</ul>
					</li>`)

	}
	$.ajax({
		type: 'post',
		url: '/orders/queryCart',
		data: '',
		success: function (res) {
			for (const iterator of res.data) {
				goodsIds.push(iterator.goodsId);
				addLi(iterator.name, iterator.introduction, iterator.price, iterator.img, iterator.num)
			}
			bindThings()
		}
	})

	// 购物车的复选框全选
	$('.Allcheck').click(function (event) {
		if ($(this).hasClass('checked')) {
			$(this).removeClass('checked');
			$('.indent .checkbox').removeClass('checked');
			setTotal();
		} else {
			$(this).addClass('checked');
			$('.indent .checkbox').addClass('checked');
			setTotal();
		}
	});

	function bindThings() {
		$('.lincheck').click(function (event) {
			if ($(this).hasClass('checked')) {
				$(this).removeClass('checked');
				$('.Allcheck').removeClass('checked');
				setTotal();
			} else {
				$(this).addClass('checked');
				var flag = 1;
				$(".lincheck").each(function () {
					if (!$(this).hasClass("checked")) {
						flag = 0;
					}
				});
				if (flag == 0) {
					$(".Allcheck").removeClass("checked");
				} else {
					$(".Allcheck").addClass("checked");

				}
				setTotal();
			};
		});
		// 删除
		$('.IAbdw .delet').click(function (event) {
			$(this).parentsUntil('.IAbdArea').remove();
		});
		// 购物车金额结算
		$('.IAul .reduce').click(function (event) {
			var n = parseFloat($(this).siblings('input').val());
			n--;
			if (n < 0) {
				n = 0;
			}
			$(this).siblings('input').val(n);
			var onePreice = parseFloat($(this).parent('.num').siblings('.price').find('u').html());
			var OlAll = n * onePreice;
			$(this).parent('li').siblings('.Lastprice').children('u').html(OlAll);
			console.log(OlAll);
			setTotal();
		});
		$('.IAul .add').click(function (event) {
			var n = parseFloat($(this).siblings('input').val());
			n++;
			$(this).siblings('input').val(n);
			var onePreice = parseFloat($(this).parent('.num').siblings('.price').find('u').html());
			var OlAll = n * onePreice;
			$(this).parent('li').siblings('.Lastprice').children('u').html(OlAll);
			setTotal();
		});
		setTotal();
	}

	var s = 0;
	var nu = 0;

	function setTotal() {
		s = 0;
		nu = 0;

		$(".IAbdArea .IAbdw").each(function () {
			if ($(this).find('.lincheck').hasClass('checked')) {
				s += parseInt($(this).find('.Lastprice u').html());
				nu += parseInt($(this).find('.num input').val());
			} else {
				s = s;
				nu = nu;
			};
		});
		$("#allpri").html(s);
		$('#allnum').html(nu);
	}
	var orderId;
	$('#orderCheck').on('click', function () {

		if (confirm("确定要结算吗？") == true) {
			let id = [];
			let num = [];
			if (parseInt($('#allpri').text()) == 0) {
				alert('请选择商品后再结算')
			} else {
				$.ajax({
					type: 'post',
					url: '/orders/insertOrder',
					data: {
						money: s
					},
					success: function (res) {
						if (res.code == 20011) {
							orderId = parseInt(res.data)
							$('.IAbdw').each(function (index) {
								if ($(this).children('.checkbox').is('.checked')) {
									id.push(goodsIds[index]);
									num.push(parseInt($('.IAbdw .num input').eq(index).val()));
								}
								console.log($('.IAbdw .num input').eq(index).val())
							})
							setTimeout(function () {
								$.ajax({
									type: 'post',
									url: '/orders/insertOrderDetail',
									data: {
										goodsId: JSON.stringify(id),
										num: JSON.stringify(num),
										orderId: orderId
									},
									success: function (res) {
										if (res.code != 20011) {
											alert(res.msg)
										}
									}
								})
								alert("结算成功，前前往付款页面")
								window.location.href = "/pages/Cart-Indent.html"
							}, 1000)
						} else {
							alert(res.msg)
						}
					}
				})
			}


		}
	})

});