package com.xiaojie.hotel.domian;

public class Customer {
    private String id;

    private String c_name;

    private String c_tel;

    private String c_start_time;

    private String idCard;

    private String engageId;

    private String roomId;

    private String order_id;

    private String state;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getC_name() {
        return c_name;
    }

    public void setC_name(String c_name) {
        this.c_name = c_name;
    }

    public String getC_tel() {
        return c_tel;
    }

    public void setC_tel(String c_tel) {
        this.c_tel = c_tel;
    }

    public String getC_start_time() {
        return c_start_time;
    }

    public void setC_start_time(String c_start_time) {
        this.c_start_time = c_start_time;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getEngageId() {
        return engageId;
    }

    public void setEngageId(String engageId) {
        this.engageId = engageId;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Customer() {
    }

    public Customer(String id, String c_name, String c_tel, String c_start_time, String idCard, String engageId, String roomId, String order_id, String state) {
        this.id = id;
        this.c_name = c_name;
        this.c_tel = c_tel;
        this.c_start_time = c_start_time;
        this.idCard = idCard;
        this.engageId = engageId;
        this.roomId = roomId;
        this.order_id = order_id;
        this.state = state;
    }
}
