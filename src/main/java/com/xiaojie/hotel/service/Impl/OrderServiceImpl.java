package com.xiaojie.hotel.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.dao.*;
import com.xiaojie.hotel.domian.*;
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
    private EngageDao engageDao;
    private MoveRoomDao moveRoomDao;
    private CustomerDao customerDao;

    public void setEngageDao(EngageDao engageDao) {
        this.engageDao = engageDao;
    }

    private OrderInformAtionDao orderInformAtionDao;

    public void setCustomerDao(CustomerDao customerDao) {
        this.customerDao = customerDao;
    }

    public void setMoveRoomDao(MoveRoomDao moveRoomDao) {
        this.moveRoomDao = moveRoomDao;
    }

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

    @Transactional
    @Override
    public Map<String, Object> deleteOrder(String[] id) {
        boolean flag = false;
        Map<String,Object> map = new HashMap<>();
        List<OrderInformAtion> list = orderInformAtionDao.selectById(id);
        int num = engageDao.selectByOrder(list);
        if (num != 0){
            int num1 = engageDao.deleteEngageByOrder(list);
            if (num1 != 0){
                flag = true;
            }
        }
        int num2 = moveRoomDao.selectMoveCount(list);
        if (num2 != 0){
            int num3 = moveRoomDao.deleteMoveByOrder(list);
            if (num3 != 0){
                flag = true;
            }
        }
        int num4 = customerDao.selectByOrder(list);
        if (num4 != 0){
            int num5 = customerDao.deleteCustomerByOrder(list);
            if (num5 != 0){
                flag = true;
            }
        }
        //删除订单记录
        int num6 = orderInformAtionDao.deleteOrderById(id);
        if (num6 == id.length){
            flag = true;
            map.put("success",flag);
            map.put("title","删除成功");
        }else{
            map.put("success",flag);
            map.put("title","删除失败");
        }
        return map;
    }
}
