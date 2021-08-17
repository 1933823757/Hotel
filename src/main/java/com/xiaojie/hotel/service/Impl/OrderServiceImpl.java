package com.xiaojie.hotel.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.dao.FloorDao;
import com.xiaojie.hotel.dao.OrderInformAtionDao;
import com.xiaojie.hotel.dao.RoomDao;
import com.xiaojie.hotel.dao.UserDao;
import com.xiaojie.hotel.domian.Floor;
import com.xiaojie.hotel.domian.OrderInformAtion;
import com.xiaojie.hotel.domian.Room;
import com.xiaojie.hotel.service.OrderServices;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl  implements OrderServices {
    private FloorDao floorDao;
    private RoomDao roomDao;
    private UserDao userDao;
    private OrderInformAtionDao orderInformAtionDao;

    public void setOrderInformAtionDao(OrderInformAtionDao orderInformAtionDao) {
        this.orderInformAtionDao = orderInformAtionDao;
    }

    public void setRoomDao(RoomDao roomDao) {
        this.roomDao = roomDao;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public void setFloorDao(FloorDao floorDao) {
        this.floorDao = floorDao;
    }

    @Override
    public List<Floor> getRoomType() {
        List<Floor> list = floorDao.getFloorId();
        return list;
    }

    //分页
    @Transactional
    @Override
    public Map<String, Object> getOrderAll(Integer valueOf, Integer valueOf1, String c_name, String order_id, String start_time, String orderState, String floorId) {
        OrderInformAtion orderInformAtion = new OrderInformAtion();
        orderInformAtion.setC_name(c_name);
        orderInformAtion.setOrder_id(order_id);
        orderInformAtion.setStart_time(start_time);
        orderInformAtion.setOrderState(orderState);
        //通过楼层的id拿到房间的id
        List<Room> list = new ArrayList<>();
        if (floorId != null){
            list = roomDao.getRoomByFloorId(floorId);
        }
        Map<String, Object> map = new HashMap<>();
        PageHelper.startPage(valueOf, valueOf1);
        List<OrderInformAtion> orderlist = orderInformAtionDao.getOrder(orderInformAtion,list);
        PageInfo pageInfo = new PageInfo(orderlist);
        map.put("total", pageInfo.getTotal());
        map.put("pages", pageInfo.getPages());
        map.put("list", pageInfo.getList());
        return map;
    }
}
