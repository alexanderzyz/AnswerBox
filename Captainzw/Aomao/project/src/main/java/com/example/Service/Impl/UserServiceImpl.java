package com.example.Service.Impl;

import com.example.Dao.UserDao;
import com.example.Domain.User;
import com.example.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Override
    public Boolean queryRegister(String phoneNumber) {
        String s = userDao.queryRegister(phoneNumber);
        return !(s == null || "".equals(s));
    }

    @Override
    public void Register(User user) {
        userDao.Register(user);
    }

    @Override
    public User Login(String login, String password) {
        return userDao.Login(login, password);
    }
}
