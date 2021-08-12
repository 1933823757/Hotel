package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.OrderInformAtion;
import com.xiaojie.hotel.domian.Room;
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
}
