package com.example.Service;

import com.example.Domain.Cart;
import java.util.List;
import java.util.Map;

public interface CartService {
    void insertCart(Cart order);
    Map<String, Object> queryCart(Cart order);
    void updateCart(int id);
    List<Cart> queryAllCart(int userId);

    void deleteAllCart(int userId);
}
