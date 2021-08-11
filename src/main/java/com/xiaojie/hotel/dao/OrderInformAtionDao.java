package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.OrderInformAtion;
import org.apache.ibatis.annotations.Param;

public interface OrderInformAtionDao {
    int addOrderInformAtion(OrderInformAtion orderInformAtion);

    int updateOrder(OrderInformAtion orderInformAtion);

    int updateOrderNotRoom(OrderInformAtion orderInformAtion);

    int updateOrderStage(@Param("userId") String engageId,@Param("orderState") String orderState);

    int update(OrderInformAtion orderInformAtion);

}
