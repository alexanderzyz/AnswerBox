package com.example.Domain;
import java.sql.Timestamp;
public class OrderDetail {
    private int id;
    private Timestamp orderTime;
    private Timestamp finishTime;
    private int goodsId;
    private int num;

    @Override
    public String toString() {
        return "OrderDetail{" +
                "id=" + id +
                ", orderTime=" + orderTime +
                ", finishTime=" + finishTime +
                ", goodsId=" + goodsId +
                ", num=" + num +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Timestamp orderTime) {
        this.orderTime = orderTime;
    }

    public Timestamp getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(Timestamp finishTime) {
        this.finishTime = finishTime;
    }

    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
}
