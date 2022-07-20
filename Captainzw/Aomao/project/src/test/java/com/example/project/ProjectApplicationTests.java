package com.example.project;

import com.example.Service.Impl.AddressServiceImpl;
import com.example.Service.Impl.UserServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ProjectApplicationTests {
    @Autowired
    private UserServiceImpl userService;
    @Autowired
    private AddressServiceImpl addressService;
    @Test
    void contextLoads() {
        System.out.println(addressService.getAddress(1));
    }

}
