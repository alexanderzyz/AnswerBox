//require('jQuery')
$(function () {
    $('.mode button').on('click', function () {
        function judge(receiverName, detailAddress, idCode, phoneNumber) {
            $('.margin-left').hide()
            if (receiverName == null || receiverName == '' || receiverName.length > 20) {
                $('.Rpeople .margin-left').show()
                return false
            } else if (detailAddress == null || detailAddress == '' || detailAddress > 50) {
                $('.Detailed .margin-left').show()
                return false
            } else if (idCode == null || idCode == '') {
                $('.IDcard .margin-left').show()
                return false
            } else if (phoneNumber == null || phoneNumber == '') {
                $('.phonenum .margin-left').show()
                return false
            }
            return true
        }
        let receiverName = $('.mode #receiverName').val().trim()
        let address = $('.mode option:selected').text().trim()
        let detailAddress = $('#detailAddress').val().trim()
        let idCode = $('#idCode').val().trim()
        let phoneNumber = $('#phoneNumber').val().trim()
        let landLine = $('#landLine').val()
        if (landLine != null || landLine != '') landLine = landLine.trim()
        let defaultAddress = $('.default .checkbox').is('.checked')
        let res = judge(receiverName, detailAddress, idCode, phoneNumber)
        if (res) {
            $.ajax({
                type: 'post',
                url: '/address/addAddress',
                data: {
                    address: JSON.stringify({
                        receiverName: receiverName,
                        address: address,
                        detailAddress: detailAddress,
                        idCode: idCode,
                        phoneNumber: phoneNumber,
                        landLine: landLine,
                        defaultAddress: defaultAddress
                    })
                },
                success: function (res) {
                    if (res.code = 20011) {
                        $('.sure span').text('添加成功')
                        $('.sure span').show()
                        queryAddress()
                        setTimeout(() => {
                            $('.sure a').click()
                        }, 2000);
                    } else {
                        $('.sure span').text('添加失败')
                        $('.sure span').show()
                    }
                }
            })
        }

    })
    queryAddress()
    let addressId = []

    function queryAddress() {
        $('.address').empty()
        $.ajax({
            type: 'post',
            url: '/address/getAddress',
            data: '',
            success: function (res) {
                if (res.code == 20041) {
                    var obj = []
                    obj = res.data
                    for (const iterator of obj) {
                        addressId.push(iterator.id)
                        if (iterator.defaultAddress) {
                            $('.address').append(`
                <li class="checkbox checked" style="margin-bottom:10px;">
					<p class="user">${iterator.receiverName}</p>
					<p class="site">${iterator.address},${iterator.detailAddress}</p>
					<p class="phonenum">${iterator.phoneNumber}</p>
				</li>`)
                        } else {
                            $('.address').append(`
                <li class = "checkbox" style="margin-bottom:10px;">
					<p class="user">${iterator.receiverName}</p>
					<p class="site">${iterator.address},${iterator.detailAddress}</p>
					<p class="phonenum">${iterator.phoneNumber}</p>
				</li>`)
                        }

                    }
                } else {
                    alert(res.msg)
                }
            }
        })
    }
    let orderId
    $.ajax({
        type: 'post',
        url: '/orders/queryOrder',
        data: '',
        success: function (res) {
            if (res.code == 20041) {
                var list = res.data
                orderId = list[0].id
                for (var i in list) {
                    var tempPrice = list[i].num * list[i].price
                    $('.prouduct').append(`<ul class="blur clearfix">
                    <li class="first">
                        <p>${list[i].name}</p>
                    </li>
                    <li>${list[i].num}</li>
                    <li>￥${list[i].price}</li>
                    <li>200g</li>
                    <li>￥0.0</li>
                    <li>${tempPrice}</li>
                </ul>`)
                }
                $('.Alladd .r').text('￥' + list[0].money)
                $('.submit span em').text('￥' + list[0].money)
            } else {
                console.log(res.msg)
            }
        }
    })
    $('.submit a').on('click', function () {
        if (confirm("确定提交订单吗") == true) {
            var checkedAddress
            $('.address .checkbox').each(function (index) {
                if ($(this).is('.checked')) checkedAddress = addressId[index]
            })
            $.ajax({
                type: 'post',
                url: '/orders/finishOrder',
                data: {
                    orderId: orderId,
                    addressId: checkedAddress
                },
                success: function (res) {
                    if (res.code = 20031) {
                        window.location.href = "/pages/Cart-pay.html"
                    } else {
                        alert(res.msg)
                    }
                }
            })
        }
    })

})