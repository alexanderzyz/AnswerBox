package com.example.Service;

import com.example.Domain.Address;

import java.util.List;

public interface AddressService {
    List<Address> getAddress(int userId);
    void addAddress(Address address);
    void updateDefault(int userId);
}
