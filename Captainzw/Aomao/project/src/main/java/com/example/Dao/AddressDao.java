package com.example.Dao;

import com.example.Domain.Address;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface AddressDao {
    @Select("select * from address where userid=#{userId}")
    List<Address> getAddress(int userId);
    @Insert("insert into address(userid, receiverName, address, detailAddress, idCode, phoneNumber, landLine,defaultAddress) values(#{userId}, #{receiverName}, #{address}, #{detailAddress}, #{idCode},#{phoneNumber}, #{landLine},#{defaultAddress})")
    void addAddress(Address address);
    @Update("update address set defaultAddress=0 where userid=#{userId}")
    void updateDefault(int userId);
}
