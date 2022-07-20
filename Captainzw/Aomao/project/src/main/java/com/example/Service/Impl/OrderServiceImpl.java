package com.example.Service.Impl;

import com.example.Dao.OrderDao;
import com.example.Domain.Order;
import com.example.Domain.OrderDetail;
import com.example.Service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderDao orderDao;

    @Override
    public int insertOrder(Order order) {
        return orderDao.insertOrder(order);
    }

    @Override
    public void insertOrderDetail(OrderDetail orderDetail) {
        orderDao.insertOrderDetail(orderDetail);
    }

    @Override
    public List<Map<String, Object>> queryOrder(int userId,int ordersId) {
        return orderDao.queryOrder(userId,ordersId);
    }

    @Override
    public void finishOrder(int orderId, int addressId) {
        orderDao.finishOrder(orderId, addressId);
    }

    @Override
    public void finishOrderDetail(int orderId, Timestamp timestamp) {
        orderDao.finishOrderDetail(orderId, timestamp);
    }
}
