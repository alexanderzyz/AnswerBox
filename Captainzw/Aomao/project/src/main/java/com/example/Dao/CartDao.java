package com.example.Dao;

import com.example.Domain.Cart;
import com.example.Domain.Order;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface CartDao {
    @Insert("insert into cart(userid, goodsid, num) values(#{userId},#{goodsId},#{num}) ")
    void insertCart(Cart order);
    @Select("SELECT * from cart where goodsid=#{goodsId} and userid=#{userId}")
    Map<String,Object> queryCart(Cart order);
    @Update("update cart set num=num+1 where id=#{id}")
    void updateCart(int id);
    @Select("select cart.id,userid,goodsid,num,name,introduction,img,price from cart inner join goods on cart.goodsid = goods.id where userid=#{userId}")
    List<Cart> queryAllCart(int userId);
    @Delete("delete from cart where userid=#{userId}")
    void deleteAllCart(int userId);
}
