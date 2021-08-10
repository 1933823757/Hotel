package com.xiaojie.hotel.service;

import com.xiaojie.hotel.domian.Engage;
import com.xiaojie.hotel.domian.Room;

import java.util.List;
import java.util.Map;

public interface PutUpService {
    List<Room> getRoomIdAll();

    Map<String, Object> addEngage(Engage engage);

    Map<String, Object> getEngage(Engage engage, Integer pageNo, Integer pageSize);

    Engage getEngageById(String id);

    Map<String, Object> editEngage(Engage engage);

    Map<String, Object> deleteEngage(String[] id);
}
