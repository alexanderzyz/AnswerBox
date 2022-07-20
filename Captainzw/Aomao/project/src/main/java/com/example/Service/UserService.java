package com.example.Service;

import com.example.Domain.User;

public interface UserService {
    Boolean queryRegister(String phoneNumber);
    void Register(User user);
    User Login(String login, String password);

}
