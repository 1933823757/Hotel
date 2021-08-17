package com.xiaojie.hotel.service;

import com.xiaojie.hotel.domian.Floor;
import com.xiaojie.hotel.domian.OrderInformAtion;

import java.util.List;
import java.util.Map;

public interface OrderServices {
    List<Floor> getRoomType();


    Map<String, Object> getOrderAll(Integer valueOf, Integer valueOf1, String c_name, String order_id, String start_time, String orderState, String floorId);
}
