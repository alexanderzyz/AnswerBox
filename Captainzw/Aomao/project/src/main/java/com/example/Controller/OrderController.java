package com.example.Controller;

import com.alibaba.fastjson.JSONArray;
import com.example.Domain.Cart;
import com.example.Domain.Order;
import com.example.Domain.OrderDetail;
import com.example.Service.Impl.CartServiceImpl;
import com.example.Service.Impl.OrderServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/orders")
public class OrderController {
    @Autowired
    private CartServiceImpl cartService;
    @Autowired
    private OrderServiceImpl orderService;

    @PostMapping("/insertCart")
    public Result insertCart(int goodsId, HttpServletRequest req) {
        try {
            Object userId = req.getSession().getAttribute("userId");
            Cart cart = new Cart();

            cart.setUserId((Integer) userId);
            cart.setGoodsId(goodsId);
            Map<String, Object> stringObjectMap = cartService.queryCart(cart);
            if (stringObjectMap != null) {
                cartService.updateCart((Integer) stringObjectMap.get("id"));
                return new Result(Code.ADDSUCCESS, "", "又添加了一件");
            } else {
                cart.setNum(1);
                cartService.insertCart(cart);
                return new Result(Code.ADDSUCCESS, "", "添加购物车成功");
            }

        } catch (Exception e) {
            e.printStackTrace();
            return new Result(Code.ADDERROR, "", "添加购物车失败");
        }

    }

    @PostMapping("/queryCart")
    public Result queryCart(HttpServletRequest req) {
        try {
            Object userId = req.getSession().getAttribute("userId");
            List<Cart> stringListMap = cartService.queryAllCart((Integer) userId);
            return new Result(Code.QUERYSUCCESS, stringListMap);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(Code.QUERYERROR, "", "查询失败");
        }

    }

    @PostMapping("/insertOrder")
    public Result insertOrder(int money, HttpServletRequest req) {
        try {
            Object userId = req.getSession().getAttribute("userId");
            Order order = new Order();
            order.setUserId((Integer) userId);
            order.setMoney(money);
            orderService.insertOrder(order);
            req.getSession().setAttribute("orderId", order.getId());
            return new Result(Code.ADDSUCCESS, order.getId());
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(Code.ADDERROR, "", "订单结算失败");
        }

    }
    @PostMapping("/insertOrderDetail")
    public Result insertOrderDetail(String goodsId,String num,int orderId,HttpServletRequest req) {
        try {
            System.out.println(goodsId);
            System.out.println(num);
            JSONArray jsonArray = JSONArray.parseArray(goodsId);
            JSONArray jsonArray1 = JSONArray.parseArray(num);
            for (int i=0;i<jsonArray.size();i++){
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderTime(new Timestamp(System.currentTimeMillis()));
                orderDetail.setGoodsId((Integer) jsonArray.get(i));
                orderDetail.setNum((Integer) jsonArray1.get(i));
                orderDetail.setId(orderId);
                orderService.insertOrderDetail(orderDetail);
            }
            cartService.deleteAllCart((Integer) req.getSession().getAttribute("userId"));
            return new Result(Code.ADDSUCCESS, "");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(Code.ADDERROR, "", "订单结算失败");
        }
    }
    @PostMapping("/queryOrder")
    public Result queryOrder(HttpServletRequest req){
        try {
            List<Map<String, Object>> orderMessage = orderService.queryOrder((Integer) req.getSession().getAttribute("userId"),(Integer) req.getSession().getAttribute("orderId"));
            return new Result(Code.QUERYSUCCESS, orderMessage);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(Code.QUERYERROR,"","查询订单失败");
        }
    }
    @PostMapping("/finishOrder")
    public Result finishOrder(int orderId,int addressId){
        try {
            orderService.finishOrder(orderId, addressId);
            orderService.finishOrderDetail(orderId, new Timestamp(System.currentTimeMillis()));
            return new Result(Code.UPDATESUCCESS,"");
        }catch (Exception e){
            e.printStackTrace();
            return new Result(Code.UPDATEERROR,"","提交订单失败");
        }
    }
}
