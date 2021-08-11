package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.Engage;

import java.util.List;

public interface EngageDao {
    int addMoveRoom(Engage engage);

    List<Engage> getEngage(Engage engage);

    Engage getEngageById(String id);

    int updateEngageNoRoomId(Engage engage);

    int updateEngageAll(Engage engage);

    int deleteEngageById(String engageId);

    int updateEngage(Engage engage);
}
