package com.example.Service.Impl;

import com.example.Dao.CartDao;
import com.example.Domain.Cart;
import com.example.Domain.Order;
import com.example.Service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CartServiceImpl implements CartService {
    @Autowired
    private CartDao cartDao;

    @Override
    public void insertCart(Cart cart) {
        cartDao.insertCart(cart);
    }

    @Override
    public Map<String, Object> queryCart(Cart cart) {
        return cartDao.queryCart(cart);
    }

    @Override
    public void updateCart(int id) {
        cartDao.updateCart(id);
    }

    @Override
    public List<Cart> queryAllCart(int userId) {
        return cartDao.queryAllCart(userId);
    }

    @Override
    public void deleteAllCart(int userId) {
        cartDao.deleteAllCart(userId);
    }
}
