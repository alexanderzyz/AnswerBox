package com.example.Service.Impl;

import com.example.Dao.AddressDao;
import com.example.Domain.Address;
import com.example.Service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AddressServiceImpl implements AddressService {
    @Autowired
    private AddressDao addressDao;
    @Override
    public List<Address> getAddress(int userId) {
        return addressDao.getAddress(userId);
    }

    @Override
    public void addAddress(Address address) {
        addressDao.addAddress(address);
    }

    @Override
    public void updateDefault(int userId) {
        addressDao.updateDefault(userId);
    }
}
