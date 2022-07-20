package com.example.Dao;

import com.example.Domain.Order;
import com.example.Domain.OrderDetail;
import org.apache.ibatis.annotations.*;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Mapper
public interface OrderDao {
    @Insert("insert into orders(userid, money) values(#{userId},#{money}) ")
    @SelectKey(statement = "SELECT LAST_INSERT_ID() AS id", keyProperty = "id", keyColumn = "id", before = false, resultType = int.class)
    int insertOrder(Order order);
    @Insert("insert into orders_detail(id, orderTime, goodsid,num) VALUES(#{id},#{orderTime},#{goodsId},#{num}) ")
    void insertOrderDetail(OrderDetail orderDetail);
    @Select("SELECT orders.id,orders.money,orders_detail.num,goods.`name`,goods.price from orders INNER JOIN (orders_detail,goods) on orders.id=orders_detail.id and orders_detail.goodsid=goods.id WHERE orders.userid=#{userId} and orders.finish=0 and orders.id=#{ordersId} ")
    List<Map<String,Object>> queryOrder(@Param("userId") int userId,@Param("ordersId") int ordersId);
    @Update("update orders set finish=1,userAddress=#{addressId} where id=#{orderId}")
    void finishOrder(@Param("orderId") int orderId, @Param("addressId") int addressId);
    @Update("update orders_detail set finishTime=#{timestamp} where id=#{orderId}")
    void finishOrderDetail(@Param("orderId") int orderId,@Param("timestamp") Timestamp timestamp);
}
