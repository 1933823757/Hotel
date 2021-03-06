package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.Engage;
import com.xiaojie.hotel.domian.OrderInformAtion;
import com.xiaojie.hotel.domian.Room;
import com.xiaojie.hotel.domian.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EngageDao {
    int addMoveRoom(Engage engage);

    List<Engage> getEngage(Engage engage);

    Engage getEngageById(String id);

    int updateEngageNoRoomId(Engage engage);

    int updateEngageAll(Engage engage);

    int deleteEngageById(String engageId);

    int updateEngage(Engage engage);

    List<Engage> getEngageByRoom(String roomType);

    int updateEngageAllByRoom(@Param("list") List<Engage> list,@Param("roomType") String roomType);

    Integer getDeleteCount(List<Room> roomList);

    int deleteEngage(List<Room> roomList);

    Engage getEngageByCname(String username);

    int updateEngageByCname(@Param("user") User user,@Param("username") String username);

    int selectByOrder(List<OrderInformAtion> list);

    int deleteEngageByOrder(List<OrderInformAtion> list);
}
