package com.xiaojie.hotel.service.Impl;

import com.xiaojie.hotel.dao.OrderInformAtionDao;
import com.xiaojie.hotel.dao.RoomDao;
import com.xiaojie.hotel.domian.Room;
import com.xiaojie.hotel.service.CountPriceService;
import com.xiaojie.hotel.vo.InvalidOder;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CountPriceServiceImpl implements CountPriceService {
    private OrderInformAtionDao orderInformAtionDao;
    private RoomDao roomDao;

    public void setRoomDao(RoomDao roomDao) {
        this.roomDao = roomDao;
    }

    public void setOrderInformAtionDao(OrderInformAtionDao orderInformAtionDao) {
        this.orderInformAtionDao = orderInformAtionDao;
    }

    @Transactional
    @Override
    public Map<String, Object> getInvalidOrder() {
        String state = "0";
        String state2 ="1";
        //第一步拿到所有失效订单的房间类型和个房间类型失效的金额
        List<InvalidOder> list = orderInformAtionDao.getRoomType(state);
        //无效订单个数
        int count = orderInformAtionDao.selectCount(state);
        //有效订单个数
        int count2 = orderInformAtionDao.selectCount(state2);
        //总数
        int sum = count+count2;
        //总盈利金额
        int sumMoney = orderInformAtionDao.selectMoney(state2);
        List<String> roomTypes=new ArrayList<>();
        List<String> totalPrice=new ArrayList<>();
        List<Map<String,Object>> list2 = orderInformAtionDao.selectMap(state2);
        for (int i =0;i<list.size();i++){
            InvalidOder invalidOder = list.get(i);
            roomTypes.add(invalidOder.getRoomType());
            totalPrice.add(invalidOder.getTotalPrice());
        }
        Map<String,Object> map =new HashMap<>();
        map.put("roomType",roomTypes);
        map.put("totalPrice",totalPrice);
        map.put("count",count);
        map.put("sum",sum);
        map.put("sunMoney",sumMoney);
        map.put("myChart2",list2);
        return map;
    }
}
