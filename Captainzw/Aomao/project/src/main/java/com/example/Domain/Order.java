package com.example.Domain;

public class Order {
    private int id;
    private int userId;
    private double money;
    private int userAddress;
    private boolean finish;

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", userId=" + userId +
                ", money=" + money +
                ", userAddress=" + userAddress +
                ", finish=" + finish +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public int getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(int userAddress) {
        this.userAddress = userAddress;
    }

    public boolean isFinish() {
        return finish;
    }

    public void setFinish(boolean finish) {
        this.finish = finish;
    }
}
