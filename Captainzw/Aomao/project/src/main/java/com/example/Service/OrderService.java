package com.example.Service;

import com.example.Domain.Order;
import com.example.Domain.OrderDetail;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public interface OrderService {
    int insertOrder(Order order);
    void insertOrderDetail(OrderDetail orderDetail);
    List<Map<String,Object>> queryOrder(int userId,int ordersId);
    void finishOrder(int orderId, int addressId);
    void finishOrderDetail(int orderId,Timestamp timestamp);
}
