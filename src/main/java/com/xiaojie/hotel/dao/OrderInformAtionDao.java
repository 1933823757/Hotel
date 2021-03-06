package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.OrderInformAtion;
import com.xiaojie.hotel.domian.Room;
import com.xiaojie.hotel.domian.User;
import com.xiaojie.hotel.vo.InvalidOder;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface OrderInformAtionDao {
    int addOrderInformAtion(OrderInformAtion orderInformAtion);

    int updateOrder(OrderInformAtion orderInformAtion);

    int updateOrderNotRoom(OrderInformAtion orderInformAtion);

    int updateOrderStage(@Param("userId") String engageId,@Param("orderState") String orderState);

    int update(OrderInformAtion orderInformAtion);

    List<InvalidOder> getRoomType(String state);

    int selectCount(String state);

    int selectMoney(String state);

    List<Map<String, Object>> selectMap(String state);

    List<OrderInformAtion> selectByUserId(@Param("id") String id,@Param("state") String state);

    OrderInformAtion select(String id);

    Integer selectByRoomId(List<Room> roomList);

    int deleteOrder(List<Room> list);

    List<OrderInformAtion> getOrder(@Param("orderInformAtion") OrderInformAtion orderInformAtion, @Param("list") List<Room> list);

    List<OrderInformAtion> selectByUserIdAll(String id);

    int updateOrderByUser(@Param("list") List<OrderInformAtion> list,@Param("user") User user);

    List<OrderInformAtion> selectById(String[] id);

    int deleteOrderById(String[] id);
}
