package com.xiaojie.hotel.domian;

public class OrderInformAtion {
    private String id;
    private String c_name;
    private String start_time;
    private String order_id;
    private String roomId;
    private String totalPrice;
    private String userId;
    private String orderState;
    private String roomType;
    private String idcard;

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getOrderState() {
        return orderState;
    }

    public void setOrderState(String orderState) {
        this.orderState = orderState;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public OrderInformAtion() {
    }

    public OrderInformAtion(String id, String c_name, String start_time, String order_id, String roomId, String totalPrice, String userId, String orderState) {
        this.id = id;
        this.c_name = c_name;
        this.start_time = start_time;
        this.order_id = order_id;
        this.roomId = roomId;
        this.totalPrice = totalPrice;
        this.userId = userId;
        this.orderState = orderState;
    }

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

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
    }
}
