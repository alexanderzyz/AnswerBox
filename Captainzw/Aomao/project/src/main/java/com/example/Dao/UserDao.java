package com.example.Dao;

import com.example.Domain.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserDao {
    @Select("select phoneNumber from user where phoneNumber=#{phoneNumber};")
    String queryRegister(String phoneNumber);
    @Insert("insert into user(id,username,password,phoneNumber,email) values(#{id},#{username},#{password},#{phoneNumber},#{email})" )
    void Register(User user);
    @Select("select * from user where (phoneNumber=#{login} or email=#{login}) and password=#{password}")
    User Login(@Param("login") String login, @Param("password") String password);
}
